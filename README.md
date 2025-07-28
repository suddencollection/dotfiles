# Dotfiles
```bash
"There's no place like $HOME"
```

</p>
<p align="center">
  <img src="https://github.com/suddencollection/dotfiles/blob/main/etc/screenshot-260725-164947.png?raw=true"/>
</p>

> ⚠️ work in progress

A collection of configuration files for a Linux desktop, built around NixOS and a curated list of programs and tools. Intended to be lightweight, visually clean, and easy to tweak.
  
## 🚀 Features

Here's a breakdown of the main software I use and configure in this repository:

| Component | Software | Description |
|-----------|----------|-------------|
| **OS** | NixOS | Declarative package management and system configuration |
| **Window Manager** | Hyprland | Modern Wayland compositor with smooth animations |
| **Dotfile Manager** | Chezmoi | Secure and flexible dotfiles management |
| **Theming Engine** | Pywal | Dynamic color scheme generation from wallpapers |
| **Bar / Widgets** | Eww | ElKowar's Wacky Widgets for custom status bars |
| **Shell** | Fish Shell | Smart and user-friendly command line shell |
| **Editor** | Neovim _(AstroNvim)_ | Extensible text editor with modern features |
| **Launcher** | Rofi | Application launcher and dmenu replacement |

## 🎯 Workflow
### Basic Navigation

> **Note**: `MOD` is the Super key (`Alt` here, by default).

| Action                  | Keybinding                |
| ----------------------- | ------------------------- |
| Launch terminal         | `MOD` + `M`                   |
| Open app launcher     | `MOD` + `R`                   |
| Close focused window     | `MOD` + `C`                   |
| Change window focus     | `MOD` + `J/K/L/;`             |
| Move focuses window      | `MOD` + `Shift` + `J/K/L/;`     |
| Switch to workspace     | `MOD` + `1 - 9`               |

This should be enough for getting started. A complete list of keybindings can be seem in `.config/hyprland.conf`

## 📦 Installation
0. Add the following to your `configuration.nix`
```nix

  fonts.packages = with pkgs; [ 
    nerd-fonts.fira-code # fancy icons and ligatures
  ];

  users.users.your_username.packages = with pkgs; [
    # improved terminal workflow, see 'fish.config'
    zoxide
    lsd
    bat
    trash-cli # no more rm -rf doom

    # toys
    cava
    neofetch
    cmatrix

    # programs
    neovim
    chezmoi
    hyprland
    eww
    kitty
    rofi
    pywal
    swww
    pywalfox-native # see the pywalfox firefox addon for theming your browser
    git # you may already have it
    

    # For hyprland mapped keybindings and eww widgets
    brightnessctl
    lm_sensors
    grim
    graphviz
    playerctl
    # alsa-utils

    # optional
    # syncthing  # unneeded, but it autostarts in the defaults
    # gimp       # a heavy way of editing screenshots

    # extra, quality of life
    gdu             # disk usage
    wf-recorder     # screen recorder
    broot           # you can use a file manager of your choice
    gh              # github (not git) terminal tool
    appimage-run
    tree
    file
    btop
  ]

  # users.users.your_username.shell = pkgs.fish;  # only for your user
  users.defaultUserShell = pkgs.fish;               # If you want fish everywhere

  # they need to be explicty enabled
  fish.enable = true;
  hyprland.enable = true;

  # needed by mason on neovim
  nix-ld.enable = true;
```

1. **Initialize chezmoi with this repository**:
   ```bash
   $ chezmoi init --apply https://github.com/suddencollection/dotfiles.git
   ```

2. **Apply configurations**
   ```bash
   $ # backup you old configs first, in case you need them back
   $ chezmoi apply
   ```
