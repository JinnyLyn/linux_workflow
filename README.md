# Linux Workflow Dotfiles

A modular, industry-standard Neovim and Tmux configuration.

## Installation

You can install this setup on a new machine using the following one-liner. It will clone the repository into `~/linux_workflow` and automatically run the installation script:

```bash
git clone https://github.com/JinnyLyn/linux_workflow.git ~/linux_workflow && cd ~/linux_workflow && ./install.sh
```

*(Note: Because the installation script creates symlinks pointing to the files in this repository, the files must be cloned to your local machine rather than just piped through curl.)*

## Post-Installation

### Tmux
1. Open a new terminal and start tmux: `tmux`
2. Press your tmux prefix (usually `Ctrl+b`) followed by `Shift+I` to fetch and install your tmux plugins via TPM.

### Neovim
1. Open Neovim: `nvim`
2. Lazy.nvim will automatically bootstrap and install all configured plugins.
