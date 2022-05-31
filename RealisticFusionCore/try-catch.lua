function try_catch(func, ...)
    xpcall(func, function(err)
        global.stop = true
        local err_msg = tostring(err).."\n"..debug.traceback()

        game.print("[font=default-large-semibold][color=#ff0000]Realistic Fusion encountered an error.\n"
        .."Normally this would cause a crash, but it's not completely game-breaking, so instead you get this message.[/color]\n"
        .."I'd appreciate it if you reported this to me (the mod author) along with the following error message: [/font]\n"
        ..err_msg
        .."\n[font=default-large-semibold]You can continue continue playing normally if you aren't using anything from RF, but if you are, your"
        .."\nreactors aren't going to work until this is fixed. You could also try reloading the game, see if that helps.[/font]")
        log("nonfatal-ish error: \n"..err_msg)
    end, ...)
end