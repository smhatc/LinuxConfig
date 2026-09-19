--------------
--- LAYOUT ---
--------------

-- Defining the tiling layout Hyprland uses and how it behaves (e.g. master, scrolling, etc.)

-- The layout currently in use and other general behavior settings
hl.config({
    general = {
        layout = "master",
        resize_on_border = true,
    },
    master = {
        new_status = "slave",
        mfact = 0.5,
    },
})

---------------
--- VISUALS ---
---------------

-- Everything to do with the looks of Hyprland (borders, rounding, gaps, shadows, blur, animations, etc.)

-- Requiring the external color theme file
require("theme")

-- Setting gaps, borders, and other general settings
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border = borderActiveColor,
            inactive_border = borderInactiveColor,
        },
    },
})

-- Border rounding, shadows, and blur
hl.config({
    decoration = {
        rounding = 10,
        rounding_power = 10,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 10,
            render_power = 10,
            color = shadowColor,
        },

        blur = {
            enabled = false,
        },
    },
})

-- Desktop animations
hl.config({
    animations = {
        enabled = true,
    },
})

-- Bezier curves
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("windIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("smoothIn", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.055 } } })

-- Fade
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 4, bezier = "smoothOut" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 4, bezier = "smoothIn" })
hl.animation({ leaf = "fadeDpms", enabled = true, speed = 4, bezier = "smoothIn" })

-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "overshot", style = "slidevert" })

-- Layers
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "smoothOut", style = "slide" })

-- Windows
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "windIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "smoothOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "wind", style = "slide" })
