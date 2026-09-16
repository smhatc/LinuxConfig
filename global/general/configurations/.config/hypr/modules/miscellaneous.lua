---------------------
--- MISCELLANEOUS ---
---------------------

-- Defining miscellaneous configuration options

-- Disabling splash message, update popup, logo, and other general settings
hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        font_family = fontFamily,
        splash_font_family = fontFamily,
    },
    ecosystem = {
        no_update_news = true,
    },
})
