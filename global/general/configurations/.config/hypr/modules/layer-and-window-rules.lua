-------------------
--- LAYER RULES ---
-------------------

-- Defining layers' behavior (use "hyprctl layers" to find layers' attributes)

-- Fix random border appearing in screenshots
hl.layer_rule({
    name = "fix-screenshot-border-appearing",

    match = { namespace = "selection" },

    no_anim = true,
})

-- Dim everything around layers
hl.layer_rule({
    name = "dim-around-layers",

    match = { namespace = "(rofi|swaync-control-center)" },

    dim_around = true,
})

--------------------
--- WINDOW RULES ---
--------------------

-- Defining windows' behavior (use "hyprctl clients" to find windows' attributes)

-- Ignore maximize requests from all windows
hl.window_rule({
    name = "suppress-maximize-events",

    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",

    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

-- Float specific windows
hl.window_rule({
    name = "float-specific-windows",

    match = { class = "(^hyprland-.*$|xdg-desktop-portal-gtk|udiskie|org.bleachbit.BleachBit|org.gnome.Characters)" },

    float = true,
})
