# dotfiles

A minimal, modern approach to bootstrapping a WSL2 development environment using Ansible.

## Features

- **Fast Shell Startup**: Uses Starship prompt instead of Oh My Zsh for lightweight configuration
- **Modern Tools**: Includes bat, eza, fd, fzf, ripgrep, zoxide, direnv, mise, and more
- **Automated Setup**: Complete bootstrap via Ansible roles
- **Dotfile Management**: Symlinks for .zshrc, .gitconfig, and .ssh/config
- **Homebrew on Linux**: Leverages Linuxbrew for consistent package management

## Quick Start

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
bash install.sh
```

The script will:
1. Update APT and install git + Ansible
2. Run the Ansible playbook with roles for:
   - **common**: APT dependencies (build-essential, curl, etc.)
   - **brew**: Homebrew installation and package management
   - **git**: Git configuration via symlinked .gitconfig
   - **ssh**: SSH config via symlinked .ssh/config
   - **zsh**: Zsh as default shell with Starship prompt
   - **vscode**: VS Code configuration (when available)

## Structure

```
dotfiles/
├── README.md
├── Brewfile              # Homebrew package list
├── install.sh            # Bootstrap script
├── ansible/
│   ├── inventory.ini     # Ansible inventory
│   ├── playbook.yaml     # Main playbook
│   ├── group_vars/
│   │   └── all.yml       # Common variables
│   └── roles/            # Ansible roles
│       ├── common/
│       ├── brew/
│       ├── git/
│       ├── ssh/
│       ├── zsh/
│       └── vscode/
└── home/                 # Dotfiles to symlink
    ├── .gitconfig
    ├── .zshrc
    ├── .ssh/
    │   └── config
    └── .config/
        └── starship.toml
```

## Customization

### Update Git Config

Edit `home/.gitconfig` with your name and email.

### Update SSH Config

Edit `home/.ssh/config` with your SSH hosts and keys.

### Add More Packages

Edit `Brewfile` and add packages using Homebrew syntax:

```
brew "package-name"
```

Then run:

```bash
brew bundle --file=Brewfile
```

### Customize Starship Prompt

Edit `home/.config/starship.toml` to customize the shell prompt.

### Update .zshrc

Edit `home/.zshrc` to add aliases, functions, or other configurations.

## Modern Tools Included

- **eza**: Modern `ls` replacement with colors and icons
- **bat**: Cat with syntax highlighting
- **fd**: Fast alternative to find
- **fzf**: Fuzzy finder
- **ripgrep**: Fast grep replacement
- **zoxide**: Smarter cd command (z)
- **direnv**: Load environment variables per directory
- **starship**: Fast, minimal shell prompt
- **uv**: Fast Python package installer
- **mise**: Version manager (pyenv/nvm/rbenv alternative)
- **lazygit**: Terminal UI for git
- **gh**: GitHub CLI

## Re-bootstrap Fresh Environment

To test the playbook on a clean environment:

```bash
# In WSL, completely remove the distro and reinstall
wsl --unregister Ubuntu-22.04
wsl --install -d Ubuntu-22.04

# Then run the bootstrap
bash ~/dotfiles/install.sh
```

## Troubleshooting

### Homebrew PATH issues

If `brew` is not found, ensure Homebrew is in your PATH:

```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

This is automatically added to `.zshrc`.

### Permission errors with Ansible

If you get permission errors, the playbook requests sudo via `become: yes`. Make sure your user can run sudo without a password:

```bash
sudo visudo
# Add: %sudo ALL=(ALL) NOPASSWD: ALL
```

Or run with `ansible-playbook --ask-become-pass` to enter your password.

## Resources

- [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux)
- [Starship Prompt](https://starship.rs)
- [Ansible Documentation](https://docs.ansible.com)
- [Zoxide](https://github.com/ajeetdsouza/zoxide)
