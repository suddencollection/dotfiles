# Dotfiles
```bash
"There's no place like $HOME"
```

</p>
<p align="center">
  <img src="https://github.com/suddencollection/dotfiles/blob/main/etc/screenshot-260725-164947.png?raw=true"/>
</p>

> ⚠️ work in progress

A comprehensive dotfiles repository managed with [chezmoi](https://www.chezmoi.io/) for a modern Linux desktop environment featuring Hyprland, Eww, and dynamic theming with pywal.

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


## 🔧 Key Components

### Hyprland
Modern Wayland compositor with advanced features and smooth animations.

### Eww Bar
Custom status bar with widgets for:
- System information (CPU, memory, temperature, volume, storage, battery)
- Workspace management
- Calendar and clock
- Custom icons and styling

### Neovim Setup
- Based on [AstroNvim](https://astronvim.com/) framework
- LSP configuration with Mason
- Treesitter for syntax highlighting
- Community plugins integration

### Custom Scripts
Located in `sh/` directory:
- Network management (`connect`, `disconnect`, `start_net`, `stop_net`)
- System utilities (`doze`, `rebuild`, `screenshot`)
- Application launchers (`launcher`, `paper`)
- Development tools (`edit`)

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
<!--
## 🛠️ Dependencies
-->

## 🎯 Usage

### Applying Changes
```bash
# Apply all dotfiles
chezmoi apply

# Edit a configuration
chezmoi edit ~/.config/hypr/hyprland.conf

# Add new files
chezmoi add ~/.config/newapp/config
```

### Theme Management
```bash
# Generate new color scheme from wallpaper
wal -i /path/to/wallpaper.jpg

# Restart applications to apply new colors
# (Most applications will automatically reload)
```

## 🔄 Updates

To update your dotfiles:
```bash
chezmoi update
