----------------
--- MONITORS ---
----------------

-- Defining connected monitors and their options

-- Main monitor settings (name is "description" from "hyprctl monitors" command)
local mainMonitor = "desc:Chimei Innolux Corporation 0x1618"
local mainMonitorResX = 1920
local mainMonitorResY = 1200
local mainMonitorRefresh = 60
local mainMonitorScale = 1.25
local mainMonitorPosition = "0x0"

-- Second monitor settings (name is "description" from "hyprctl monitors" command)
local secondMonitor = "desc:BNQ BenQ GW2780 ETJCM0042204U"
local secondMonitorResX = 1920
local secondMonitorResY = 1080
local secondMonitorRefresh = 60
local secondMonitorScale = 1
local secondMonitorPosition = math.floor(mainMonitorResX / mainMonitorScale) .. "x0" -- Right of the main monitor's scaled width

-- Main monitor rule
hl.monitor({
    output = mainMonitor,
    mode = mainMonitorResX .. "x" .. mainMonitorResY .. "@" .. mainMonitorRefresh,
    scale = mainMonitorScale,
    position = mainMonitorPosition,
})

-- Second monitor rule
hl.monitor({
    output = secondMonitor,
    mode = secondMonitorResX .. "x" .. secondMonitorResY .. "@" .. secondMonitorRefresh,
    scale = secondMonitorScale,
    position = secondMonitorPosition,
})

-- Fallback rule to mirror the main monitor by default
hl.monitor({
    output = "",
    mode = mainMonitorResX .. "x" .. mainMonitorResY .. "@" .. mainMonitorRefresh,
    scale = "auto",
    position = "auto",
    mirror = mainMonitor,
})

-- Use a scale of 1 for XWayland windows on scaled monitors to prevent pixelated or blurry look
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

------------------
--- WORKSPACES ---
------------------

-- Defining workspace-to-monitor behavior

-- Workspaces on main monitor
hl.workspace_rule({ workspace = "1", monitor = mainMonitor, persistent = true, default = true })
hl.workspace_rule({ workspace = "2", monitor = mainMonitor, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = mainMonitor, persistent = true })
hl.workspace_rule({ workspace = "4", monitor = mainMonitor, persistent = true })
hl.workspace_rule({ workspace = "5", monitor = mainMonitor, persistent = true })

-- Workspaces on second monitor
hl.workspace_rule({ workspace = "6", monitor = secondMonitor, persistent = true, default = true })
hl.workspace_rule({ workspace = "7", monitor = secondMonitor, persistent = true })
hl.workspace_rule({ workspace = "8", monitor = secondMonitor, persistent = true })
hl.workspace_rule({ workspace = "9", monitor = secondMonitor, persistent = true })
hl.workspace_rule({ workspace = "10", monitor = secondMonitor, persistent = true })

-- Special workspace behavior
hl.workspace_rule({ workspace = "special:SpecialWorkspace", persistent = true })
