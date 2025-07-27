# Dotfiles
```bash
"There's no place like $HOME"
```
<p align="center">
  <img src="https://github.com/suddencollection/dotfiles/blob/main/etc/screenshot-260725-164947.png?raw=true"/>
</p>

> ⚠️ work in progress

## Todo
- actually write the readme


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

-------------------------

# Dotfiles Configuration

A comprehensive dotfiles repository managed with [chezmoi](https://www.chezmoi.io/) for a modern Linux desktop environment featuring Hyprland, Eww, and dynamic theming with pywal.

## 🔧 Key Components

### Hyprland
Modern Wayland compositor with advanced features and smooth animations.

### Eww Bar
Custom status bar with widgets for:
- System information (CPU, memory, temperature, storage)
- Audio controls and visualization
- Workspace management
- Calendar and clock
- Custom icons and styling

### Neovim Setup
- Based on AstroNvim framework
- LSP configuration with Mason
- Treesitter for syntax highlighting
- Community plugins integration

### Custom Scripts
Located in `sh/` directory:
- Network management (`connect`, `disconnect`, `start_net`, `stop_net`)
- System utilities (`doze`, `rebuild`, `screenshot`)
- Media controls (`music`, `flstudio`)
- Development tools (`edit`, `save2kki`)
- Application launchers (`launcher`, `paper`)

## 📦 Installation
- to make it nix specific

1. **Install chezmoi**:
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)"
   ```

2. **Initialize with this repository**:
   ```bash
   chezmoi init --apply https://github.com/yourusername/dotfiles.git
   ```

3. **Install dependencies** (adjust for your distribution):
   ```bash
   # Essential packages
   sudo pacman -S hyprland eww rofi fish neovim cava
   
   # Python dependencies for scripts
   pip install pywal
   ```

## 🛠️ Dependencies

- to talk about nix config packages

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

### Custom Scripts
All executable scripts are available in your PATH after installation
They're loaded in fish configuration, meant to be called by hyprland for certain keybindings and also from terminal usage

```bash
launcher      # Open application launcher
screenshot    # Take a screenshot
music         # Music controls
rebuild       # Rebuild system configuration
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
