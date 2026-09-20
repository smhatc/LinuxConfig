-------------
--- INPUT ---
-------------

-- Adjusting general keyboard layout and mouse/touchpad settings

-- Keyboard layout switching, general keyboard settings, and mouse/touchpad settings
hl.config({
    input = {
        kb_layout = "us,ara",
        kb_options = "grp:win_space_toggle",
        numlock_by_default = true,
        repeat_delay = 300,

        accel_profile = "adaptive",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- Touchpad gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-------------------
--- KEYBINDINGS ---
-------------------

-- Defining various keyboard shortcuts to speed up the overall workflow

-- The main modifier key (SUPER = "Windows" key)
local mainMod = "SUPER"

-- The name of the laptop lid switch device (found through "hyprctl devices")
local laptopLid = "Lid Switch"

-- Lock and suspend when closing laptop lid (in place of systemd-logind)
hl.bind("switch:on:" .. laptopLid, hl.dsp.exec_cmd("loginctl lock-session && systemctl suspend"), { locked = true })

-- Lock and suspend when pressing power button (prevents accidental shutdowns, in place of systemd-logind)
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("loginctl lock-session && systemctl suspend"), { locked = true })

-- Session, power, and notification controls
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd(powerMenu))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(notificationMenu .. " " .. notificationMenuShowOpts))
hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd(notificationMenu .. " " .. notificationMenuDndOpts))

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd(screenshotApp .. " " .. screenshotAppRegionOpts .. " " .. screenshotAppSaveOpts)) -- Region
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd(screenshotApp .. " " .. screenshotAppWindowOpts .. " " .. screenshotAppSaveOpts)) -- Window
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd(screenshotApp .. " " .. screenshotAppMonitorOpts .. " " .. screenshotAppSaveOpts)) -- Monitor

-- Night light
hl.bind("F12", hl.dsp.exec_cmd(nightLight), { locked = true })

-- App launcher
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(appLauncher))

-- Wallpaper switcher
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(wallpaperSwitcher))

-- Theme switcher
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(themeSwitcher))

-- Launching apps
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd(secondaryTerminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + ALT + E", hl.dsp.exec_cmd(notepad))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(firefox))
hl.bind(mainMod .. " + ALT + F", hl.dsp.exec_cmd(firefoxPrivate))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(brave))
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd(bravePrivate))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(vscode))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(virtManager))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(localSend))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(bleachbit))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(emojiPicker))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(keePassXC))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(yubicoAuthenticator))

-- Launching scripts
hl.bind(mainMod .. " + ALT + K", hl.dsp.exec_cmd(backupScript))
hl.bind(mainMod .. " + ALT + U", hl.dsp.exec_cmd(updateScript))

-- Switching window focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Moving windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Moving windows across workspaces
hl.bind(mainMod .. " + ALT + SHIFT + left", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mainMod .. " + ALT + SHIFT + right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + ALT + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + ALT + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + ALT + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + ALT + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + ALT + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + ALT + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + ALT + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + ALT + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + ALT + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + ALT + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
hl.bind(mainMod .. " + ALT + SHIFT + BACKSPACE", hl.dsp.window.move({ workspace = "special:SpecialWorkspace" }))

-- Resizing windows
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float())

-- Closing windows
hl.bind("ALT + F4", hl.dsp.window.close())

-- Switching workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + ALT + left", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + ALT + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + ALT + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + ALT + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + ALT + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + ALT + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + ALT + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + ALT + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + ALT + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + ALT + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + ALT + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + ALT + BACKSPACE", hl.dsp.workspace.toggle_special("SpecialWorkspace"))

-- Brightness controls
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightnessCtrl .. " " .. brightnessCtrlLowerOpts), { locked = true, repeating = true })
hl.bind("F4", hl.dsp.exec_cmd(brightnessCtrl .. " " .. brightnessCtrlLowerOpts), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(brightnessCtrl .. " " .. brightnessCtrlRaiseOpts), { locked = true, repeating = true })
hl.bind("F5", hl.dsp.exec_cmd(brightnessCtrl .. " " .. brightnessCtrlRaiseOpts), { locked = true, repeating = true })

-- Volume output and input controls
hl.bind("F7", hl.dsp.exec_cmd(audioCtrl))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlMuteOutputOpts))
hl.bind("F1", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlMuteOutputOpts))

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlLowerOutputOpts), { repeating = true })
hl.bind("F2", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlLowerOutputOpts), { repeating = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlRaiseOutputOpts), { repeating = true })
hl.bind("F3", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlRaiseOutputOpts), { repeating = true })

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlMuteInputOpts))
hl.bind("F9", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlMuteInputOpts))

hl.bind("F8", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlLowerInputOpts), { repeating = true })

hl.bind("F10", hl.dsp.exec_cmd(volumeCtrl .. " " .. volumeCtrlRaiseInputOpts), { repeating = true })

-- Audio track controls
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("F6", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
