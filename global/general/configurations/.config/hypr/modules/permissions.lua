-------------------
--- PERMISSIONS ---
-------------------

-- Utilizing the Hyprland permission system to restrict programs' system access

-- Enforce Hyprland compositor permissions (requires Hyprland restart to apply, format: path/regex, permission, mode)
hl.config({
    ecosystem = {
        enforce_permissions = true,
    },
})

-- "screencopy" permission (access to screen without going through xdg-desktop-portal-hyprland)
hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprpicker", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprlock", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = ".*", type = "screencopy", mode = "deny" })

-- "plugin" permission (access to load a plugin)
hl.permission({ binary = ".*", type = "plugin", mode = "deny" })

-- "keyboard" permission (access to connecting a new keyboard)
hl.permission({ binary = ".*", type = "keyboard", mode = "allow" })
