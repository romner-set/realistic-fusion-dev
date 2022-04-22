//wrote this since the ENDF plotting doesn't seem to be entirely accurate

#![feature(let_chains)]
use std::{fs::{self, File}, error::Error, io::{self, Write, BufReader}};
use plotters_unstable::{prelude::*, coord::types::RangedCoordf64};
use rayon::prelude::*;
use serde_json::{Value, Map};

const COLORS: [RGBColor; 9] = [
    RGBColor {0:255,  1:0,     2:0  },
    RGBColor {0:0,    1:255,   2:0  },
    RGBColor {0:0,    1:0,     2:255},
    RGBColor {0:255,  1:0,     2:255},
    RGBColor {0:0,    1:255,   2:255},
    RGBColor {0:128,  1:0,     2:255},
    RGBColor {0:0,    1:160,   2:255},
    RGBColor {0:255,  1:128,   2:0  },
    RGBColor {0:222,  1:222,   2:0  },
];

enum Ctx<'a, 'b> { //writing this physically hurts but there isn't a better way as far as I know
    LogLog(ChartContext<'a, BitMapBackend<'b>, Cartesian2d<LogCoord<f64>, LogCoord<f64>>>),
    LogLin(ChartContext<'a, BitMapBackend<'b>, Cartesian2d<LogCoord<f64>, RangedCoordf64>>),
    LinLog(ChartContext<'a, BitMapBackend<'b>, Cartesian2d<RangedCoordf64, LogCoord<f64>>>),
    LinLin(ChartContext<'a, BitMapBackend<'b>, Cartesian2d<RangedCoordf64, RangedCoordf64>>),
}

fn main() -> Result<(), Box<dyn Error>> {
    let mut selected = vec![0usize];
    let mut selected_to_add = Vec::new();
    let mut datasets = Vec::new();
    let dataset_path = std::env::current_dir()?;

    let format_func = |v: &f64| {
        let res = format!("10^{}", v.log10().round());
        if res == "10^0" || res == "10^-0" {String::from("1")}
        else if res == "10^1" {String::from("10")}
        else if res == "10^-inf" || res == "10^inf" {String::from("0")}
        else {res}
    };

    /* #region LIST/SELECT DATASETS */
    println!(r#"Select datasets, separated by ";". Type "all" to plot all, numbers for specifics, or filter by name."#);
    println!(r#"To filter for multiple things, use commas (e.g. "He3, cross-section")."#);
    for dir in walkdir::WalkDir::new(&dataset_path).follow_links(true).into_iter().filter_map(|e| e.ok()) {
        if dir.file_type().is_file() {
            let p = dir.into_path();
            let filename = p.file_name().unwrap().to_str().unwrap();
    
            if p.extension().unwrap_or_default().to_str() == Some("json") && (filename.contains("reactivity") || filename.contains("cross-section")) {
                println!("  [{}] {}", selected[0], filename);
                selected[0]+=1;
                datasets.push(p);
            }
        }
    }
    println!(r#"To plot more datasets as one, separate them with a "+" sign. Can be used alongside "all" or a filter."#);
    print!("> "); io::stdout().flush()?;

    input(|mut buffer| {
        selected.clear();
        buffer = buffer.trim();
        if buffer.to_lowercase() == "all" {for i in 0..datasets.len() {selected.push(i)}; return Some(())}

        for mut item in buffer.split(';') {
            item = item.trim();
            
            if item == "all" {for i in 0..datasets.len() {selected.push(i)}}
            else if let Ok(n) = item.parse::<usize>() {
                if n < datasets.len() {
                    selected.push(n);
                } else {return None}
            } else if item.contains('+') {
                let mut f = Vec::new();
                for mut _item in item.split('+') {
                    _item = _item.trim();
                    if let Ok(n) = _item.parse::<usize>() && n < datasets.len() {f.push(n);}
                    else {return None}
                }
                selected_to_add.push(f);
            } else if item.contains(',') {
                let mut f = Vec::new();
                for mut _item in item.split(',') {
                    _item = _item.trim();
                    if f.is_empty() {
                        for (i, dataset) in datasets.iter().enumerate() {
                            if dataset.file_name().unwrap().to_str().unwrap().contains(_item) {f.push(i);}
                        }
                    } else {
                        let mut to_remove = Vec::new();
                        for (i, &n) in f.iter().enumerate() {
                            if !datasets[n].file_name().unwrap().to_str().unwrap().contains(_item) {to_remove.push(i);}
                        }
                        to_remove.sort();
                        for i in to_remove.into_iter().rev() {f.remove(i);}
                    }
                }
                selected.extend(f.into_iter());
            } else {
                for (i, dataset) in datasets.iter().enumerate() {
                    if dataset.file_name().unwrap().to_str().unwrap().contains(item) {selected.push(i);}
                }
            }
        }
        Some(())
    });


    let mut data = Vec::<Value>::with_capacity(selected.len());
    let mut idxs = vec![0usize; datasets.len()]; //this is a terribly inefficient solution but I really can't be bothered to make anything better
    println!("\nSelected datasets:");
    for (i, &s) in selected.iter().enumerate() {
        println!("  {}", datasets[s].file_name().unwrap().to_str().unwrap());
    
        idxs[s] = i;
        data.push(serde_json::from_reader(BufReader::new(File::open(&datasets[s])?))?);
        println!("    Retrieved from {} at {}", data[i]["datasets"][0]["LIBRARY"].to_string().replace('"', ""), data[i]["now"].to_string().replace('"', ""));
        println!("    {} total data points", data[i]["datasets"][0]["nPts"].to_string());
        println!("    Reaction type: {}", data[i]["datasets"][0]["REACTION"].to_string().replace('"', ""));
    }
    
    for s in selected_to_add.iter() {
        let mut print_str = String::new();
        println!("  {}", s.iter().enumerate().map(|(j, &_s)| {
            let adj_i = data.len();
            idxs[_s] = adj_i;
            
            data.push(serde_json::from_reader(BufReader::new(File::open(&datasets[_s]).unwrap())).unwrap());
            let filename = datasets[_s].file_name().unwrap().to_str().unwrap();

            print_str.push_str(&format!("    {}\n", filename));
            print_str.push_str(&format!("      Retrieved from {} at {}\n", data[adj_i]["datasets"][0]["LIBRARY"].to_string().replace('"', ""), data[adj_i]["now"].to_string().replace('"', "")));
            print_str.push_str(&format!("      {} total data points\n", data[adj_i]["datasets"][0]["nPts"].to_string()));
            print_str.push_str(&format!("      Reaction type: {}\n", data[adj_i]["datasets"][0]["REACTION"].to_string().replace('"', "")));

            format!("{}{}", if j==0 {""} else {" + "}, filename)
        }).collect::<String>());
        print!("{}", print_str); io::stdout().flush()?;
    }
    /* #endregion */

    /* #region OTHER PARAMETERS */
    print!("\nEnter image width in pixels (0 to skip plotting):\n> "); io::stdout().flush()?;

    //let bitmap_paths = selected.iter().map(|&s| {format!("{}{}.png", dataset_path, datasets[s].file_name().unwrap().to_str().unwrap())}).collect::<Vec<String>>();
    let width = input(|buffer| {
        if let Ok(w) = buffer.trim().parse::<u16>() {Some(w as f64)}
        else {None}
    });

    if width != 0f64 {
        //get the maximum value for the axes
        let max_ev = data.iter().map(|v| {v["datasets"][0]["pts"].as_array().unwrap().last().unwrap().as_object().unwrap()["E"].as_f64().unwrap()}).reduce(f64::max).unwrap();
        let max_sig = data.iter().map(|v| {v["datasets"][0]["pts"].as_array().unwrap().last().unwrap().as_object().unwrap()["Sig"].as_f64().unwrap()}).reduce(f64::max).unwrap();
        //yep, this is how that looks like. damn JSON
    
        let y_n = |buffer: &str| {match buffer.trim() {
            "y" | "" => Some(true),
            "n"      => Some(false),
             _       => None,
        }};

        print!("Connect data points? (y/n, nothing for default):\n> "); io::stdout().flush()?;
        let connect_points = input(y_n);
        
        print!("Use logarithmic scale on x-axis? (y/n, nothing for default):\n> "); io::stdout().flush()?;
        let range_x = input(y_n);
        print!("Use logarithmic scale on y-axis? (y/n, nothing for default):\n> "); io::stdout().flush()?;
        let range_y = input(y_n);
    /* #endregion */

    /* #region PLOTTING */
        println!("Plotting...");
        let sw = stopwatch::Stopwatch::start_new();

        let bitmap_path = format!("{}\\cross-section.png", dataset_path.to_str().unwrap());
        //_=fs::remove_file(&bitmap_path);
        let bitmap = BitMapBackend::new(&bitmap_path, (width as u32, (width*0.8) as u32)).into_drawing_area();
            bitmap.fill(&WHITE)?;
        let mut ctx = { //this is the best I could make this look, because linear and log contexts are NOT interchangable at all according to the compiler...
            let x_log = || {(0.1..max_ev/1000f64).log_scale()}; //closures prevent unnecessary calculations
            let x_lin = || {0.0..max_ev/1000f64};
            let y_log = || {(1E-50..1E+6f64).log_scale()};
            let y_lin = || {0.0..max_sig};

            if range_x {
                if range_y {Ctx::LogLog(include!("chartbuilder.in").build_cartesian_2d(x_log(), y_log()).unwrap())}
                else {Ctx::LogLin(include!("chartbuilder.in").build_cartesian_2d(x_log(), y_lin())?)}
            } else if range_y {Ctx::LinLog(include!("chartbuilder.in").build_cartesian_2d(x_lin(), y_log())?)}
            else {Ctx::LinLin(include!("chartbuilder.in").build_cartesian_2d(x_lin(), y_lin())?)}
        };

        match ctx {
            //everything does the exact same thing by calling the exact same functions with the exact same arguments, but internally everything's working on different types
            Ctx::LogLog(ref mut c) => include!("mesh_cfg.in"),
            Ctx::LogLin(ref mut c) => include!("mesh_cfg.in"),
            Ctx::LinLog(ref mut c) => include!("mesh_cfg.in"),
            Ctx::LinLin(ref mut c) => include!("mesh_cfg.in"),
        }?;
    
        for &s in selected.iter() {
            let shape = move |scale: f64| -> ShapeStyle {ShapeStyle { //closure because ShapeStyle doesn't implement Copy for some reason...
                color: COLORS[s%9].to_rgba(),
                filled: true,
                stroke_width: (width*scale) as u32,
            }};
            
            if connect_points {
                let series = LineSeries::new(data[idxs[s]]["datasets"][0]["pts"].as_array().unwrap().iter().map(|v| {
                    let obj = v.as_object().unwrap();
                    (obj["E"].as_f64().unwrap()/1000f64, obj["Sig"].as_f64().unwrap())
                }), shape(0.003));
                let label = datasets[s].file_name().unwrap().to_str().unwrap().replace(".json", "").replace("_", " => ");
                let legend = move |(x, y)| PathElement::new(vec![(x, y), (x + (width*0.04) as i32, y)], shape(0.003));
                match ctx {
                    Ctx::LogLog(ref mut c) => c.draw_series(series)?.label(label).legend(legend),
                    Ctx::LogLin(ref mut c) => c.draw_series(series)?.label(label).legend(legend),
                    Ctx::LinLog(ref mut c) => c.draw_series(series)?.label(label).legend(legend),
                    Ctx::LinLin(ref mut c) => c.draw_series(series)?.label(label).legend(legend),
                };
            } else {
                let series = data[idxs[s]]["datasets"][0]["pts"].as_array().unwrap().iter().map(|v| {
                    let obj = v.as_object().unwrap();
                    Circle::new((obj["E"].as_f64().unwrap()/1000f64, obj["Sig"].as_f64().unwrap()), (width*0.001) as u32, shape(0.001))
                });
                match ctx {
                    Ctx::LogLog(ref mut c) => c.draw_series(series),
                    Ctx::LogLin(ref mut c) => c.draw_series(series),
                    Ctx::LinLog(ref mut c) => c.draw_series(series),
                    Ctx::LinLin(ref mut c) => c.draw_series(series),
                }?;
            }
        }
        for s in selected_to_add.iter() {
            let shape = move |scale: f64| -> ShapeStyle {ShapeStyle {
                color: COLORS[s[0]%9].to_rgba(),
                filled: true,
                stroke_width: (width*scale) as u32,
            }};

            let longest = s.par_iter().map(|&_s| data[idxs[_s]]["datasets"][0]["nPts"].as_u64().unwrap()).max().unwrap() as usize;
            let mut resulting_dataset = vec![(0f64, 0f64); longest];
            for &_s in s.iter() {
                let current = data[idxs[_s]]["datasets"][0]["pts"].as_array().unwrap();

                unsafe { //can't be bothered to use arcs + this is guaranteed not to cause a data race since every element is only accessed once
                    let ptr = resulting_dataset.as_mut_ptr() as usize;
                    (0..current.len()).into_par_iter().for_each(|i| {
                        let obj = current[i].as_object().unwrap();
                        let _ptr = (ptr as *mut (f64, f64)).add(i);
                        (*_ptr).0 += obj["E"].as_f64().unwrap()/1000f64;
                        (*_ptr).1 += obj["Sig"].as_f64().unwrap();
                    });
                }
            }

            /* #region WRITE SUM TO FILE */
            /*let mut new = data[idxs[s[0]]].clone();
            let arr = new["datasets"][0]["pts"].as_array_mut().unwrap(); arr.clear();

            for v in resulting_dataset.iter() {
                arr.push(serde_json::json!({
                    "E": v.0*1000f64, "Sig": v.1
                }))
            }

            let filename = datasets[s[0]].file_name().unwrap().to_str().unwrap();
            fs::write(format!("{}.json", &filename[..filename.rfind('_').unwrap_or(filename.len())]), new.to_string()).unwrap();// */
            /* #endregion */
            
            if connect_points {
                let series = LineSeries::new(resulting_dataset, shape(0.003));
                let label = s.iter().enumerate().map(|(j, &_s)| {
                    format!("{}{}", if j==0 {""} else {" + "}, datasets[_s].file_name().unwrap().to_str().unwrap())
                }).collect::<String>().replace(".json", "").replace("_", " => ");
                let legend = move |(x, y)| PathElement::new(vec![(x, y), (x + (width*0.04) as i32, y)], shape(0.003));
                match ctx {
                    Ctx::LogLog(ref mut c) => c.draw_series(series)?.label(label).legend(legend),
                    Ctx::LogLin(ref mut c) => c.draw_series(series)?.label(label).legend(legend),
                    Ctx::LinLog(ref mut c) => c.draw_series(series)?.label(label).legend(legend),
                    Ctx::LinLin(ref mut c) => c.draw_series(series)?.label(label).legend(legend),
                };
            } else {
                let series = resulting_dataset.iter().map(|&v| {
                    Circle::new((v.0/1000f64, v.1), (width*0.001) as u32, shape(0.001))
                });
                match ctx {
                    Ctx::LogLog(ref mut c) => c.draw_series(series),
                    Ctx::LogLin(ref mut c) => c.draw_series(series),
                    Ctx::LinLog(ref mut c) => c.draw_series(series),
                    Ctx::LinLin(ref mut c) => c.draw_series(series),
                }?;
            }
        }
    
        {
            let size = (width*0.05) as u32;
            let font = ("arial", (width*0.025) as u32);
            match ctx {
                Ctx::LogLog(ref mut c) => c.configure_series_labels().legend_area_size(size).label_font(font).border_style(&BLACK).draw(),
                Ctx::LogLin(ref mut c) => c.configure_series_labels().legend_area_size(size).label_font(font).border_style(&BLACK).draw(),
                Ctx::LinLog(ref mut c) => c.configure_series_labels().legend_area_size(size).label_font(font).border_style(&BLACK).draw(),
                Ctx::LinLin(ref mut c) => c.configure_series_labels().legend_area_size(size).label_font(font).border_style(&BLACK).draw(),
            }?;
        }
    
        bitmap.present()?;
        drop(ctx);
    
        println!("Data plotted to {}\nin {}ms, opening...\n", bitmap_path, sw.elapsed_ms());
    
        open::that(fs::canonicalize(&bitmap_path)?)?;
    }
    /* #endregion */

    /* #region APPROXIMATE VALUES */
    let mut max_filename_len = 0;
    for dataset in datasets.iter() {let len = dataset.file_name().unwrap().to_str().unwrap().len(); if max_filename_len < len {max_filename_len = len;}}
    for s in selected_to_add.iter() {
        let mut len = 0;
        for &_s in s.iter() {len += datasets[_s].file_name().unwrap().to_str().unwrap().len()}
        if max_filename_len < len {max_filename_len = len;}
    }

    loop {
        print!("Approximate value at keV:\n> "); io::stdout().flush()?;

        input(|buffer| {
            if let Ok(mut e) = buffer.trim().parse::<f64>() {
                e *= 1000f64;

                println!("{3:-<max_filename_len$}{3:-<80}\n| {0:max_filename_len$} | {1:<11} | {2:<59} |\n{3:-<max_filename_len$}{3:-<80}", "Filename", "approximate", "precise", "");
                for &s in selected.iter() {
                    let est = estimate_sig(e, &data[idxs[s]]);
                    println!("| {:max_filename_len$} | {:<11} | {:<59} |", datasets[s].file_name().unwrap().to_str().unwrap(), format_func(&est), est);
                }
                println!("{0:-<max_filename_len$}{0:-<80}", "");

                Some(())
            } else {None}
        });
    }
    /* #endregion */
}

fn input<T, F>(mut condition: F) -> T where F: FnMut(&str) -> Option<T> {
    loop {
        let mut buffer = String::new();
        io::stdin().read_line(&mut buffer).unwrap();

        if let Some(v) = condition(&buffer) {break v}

        print!("Invalid value, try again:\n> ");
        io::stdout().flush().unwrap();
    }
}

fn estimate_sig(energy: f64, data: &Value) -> f64 {
    let (nearest_lower_opt, nearest_upper_opt) = find_nearest_energy_data(energy, data["datasets"][0]["pts"].as_array().unwrap());
    
    if let Some(nearest_lower) = nearest_lower_opt 
    && let Some(nearest_upper) = nearest_upper_opt {
        if nearest_lower == nearest_upper { //energy matches a datapoint
            nearest_lower["Sig"].as_f64().unwrap()
        } else {
            let lower_e = nearest_lower["E"].as_f64().unwrap();
            let lower_sig = nearest_lower["Sig"].as_f64().unwrap();
            //println!("{} {} {} {}", lower_e, nearest_upper["E"].as_f64().unwrap(), lower_sig, nearest_upper["Sig"].as_f64().unwrap());
            ((energy - lower_e)/(nearest_upper["E"].as_f64().unwrap() - lower_e)) * (nearest_upper["Sig"].as_f64().unwrap() - lower_sig) + lower_sig
        }
    } else {0f64/*f64::NAN*/} //can be either, but 0 is probably better
}

//this is not a great algorithm but who cares, the lua implementation is the fastest it can be (or close to it) which is what's actually important
fn find_nearest_energy_data(energy: f64, mut data: &[Value]) -> (Option<&Map<String,Value>>, Option<&Map<String,Value>>) {
    let new_len = data.len()/2;

    if data[new_len].as_object().unwrap()["E"].as_f64().unwrap() > energy { //halves the amount of data to process
        data = &data[..new_len+2];
    } else {
        data = &data[new_len..];
    }

    let mut nearest_down = &Value::Null;
    let mut nearest_up = &Value::Null;
    for (i, val) in data.iter().enumerate() {
        let e = val.as_object().unwrap()["E"].as_f64().unwrap();
        //let sig = val.as_object().unwrap()["Sig"].as_f64().unwrap();
        //println!("{} {}", e, sig);
        if e <= energy {
            if i < data.len()-2 {
                nearest_down = val;
                if e == energy {nearest_up = val; break}
                nearest_up = &data[i+1];//.as_object().unwrap()["E"].as_f64().unwrap();
            } else {break}
        }
    }
    //println!("{}", energy);
    (nearest_down.as_object(), nearest_up.as_object())
}