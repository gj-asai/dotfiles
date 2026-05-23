hl.env("ZDOTDIR", os.getenv("HOME") .. "/.config/zsh")

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar & swaync & hyprpaper")
    hl.exec_cmd("hyprlock") -- because of sddm autologin
end)

-- additional configuration on /etc/sddm.conf.d/sddm.conf
-- [Autologin]
-- Relogin=false
-- Session=hyprland
-- User=<user>

-- additional configuration on /etc/systemd/logind.conf
-- [Login]
-- HandlePowerKey=suspend
-- HandlePowerKeyLongPress=poweroff
-- HandleLidSwitch=suspend

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "20")

hl.config({
    general = {
        border_size = 1,
        gaps_in = 1,
        gaps_out = 2,
        col = {
            active_border = "rgba(88c0d0aa)",
            inactive_border = "rgba(81a1c1aa)",
        },
        resize_on_border = true,
    },
    decoration = {
        rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 0.8,
    },
    animations = { enabled = true, },
    misc = { disable_hyprland_logo = true },
    input = {
        kb_layout = "br",
        numlock_by_default = true,
        touchpad = { natural_scroll = true },
    },
})

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "default" })

hl.window_rule({
    float = true,
    match = { title = "Volume Control" },
})
hl.window_rule({
    float = true,
    match = { title = "Bluetooth Devices" },
})
hl.window_rule({
    name = "File Picker",
    float = true,
    match = { class = "xdg-desktop-portal-gtk" },
})

require("keybindings")
