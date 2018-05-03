# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# load completion function
#autoload -U +X compinit && compinit
#autoload -U +X bashcompinit && bashcompinit

# local PATH
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# MANPATH
export MANPATH=$HOME/.local/man:$HOME/.local/share/man:$MANPATH

# Completion PATH
fpath=( ~/.local/etc/zsh/completions "${fpath[@]}" )

# Export LESS
export LESS="-s -X -R -F"

# Man
export MANPAGER="less -s -X -R -F"

# rust
if [ -d "$HOME/Development/rust" ];then
  export LD_LIBRARY_PATH=$HOME/Development/rust/rustc/lib
  export PATH=$HOME/Development/rust/rustc/bin:$HOME/Development/rust/cargo/bin:$PATH
fi

# android
if [ -d "$HOME/Development/android-sdk" ];then
  export ANDROID_HOME=$HOME/Development/android-sdk
  export PATH=$ANDROID_HOME/tools:$PATH
  export PATH=$ANDROID_HOME/platform-tools:$PATH
fi

# composer
if [ -d "$HOME/.config/composer/bin" ];then
  export PATH=$HOME/.config/composer/vendor/bin:$PATH
fi

# yarn
if [ -d "$HOME/.yarn/bin" ];then
  export PATH=$HOME/.yarn/bin:$PATH
fi

# rvm
if [ -d "$HOME/.rvm" ];then
  export PATH="$HOME/.rvm/bin:$PATH"
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# NVM
if [ -d "$HOME/.nvm" ];then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# SDKMAN
if [ -d "$HOME/.sdkman" ];then
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Snap
if [ -d "/snap/bin" ]; then
  export PATH=/snap/bin:$PATH
fi

# Dircolors
if [[ -s "$HOME/.dir_colors/dircolors" ]]; then
  eval `dircolors $HOME/.dir_colors/dircolors`
fi

if [[ -s "$HOME/Development/cmakepp" ]]; then
  alias icmakepp="cmake -P $HOME/Development/cmakepp/cmakepp.cmake icmake"
  alias cmakepp="cmake -P $HOME/Development/cmakepp/cmakepp.cmake"
  alias pkg="cmake -P $HOME/Development/cmakepp/cmakepp.cmake cmakepp_project_cli"
  alias cml="cmake -P $HOME/Development/cmakepp/cmakepp.cmake cmakelists_cli"
  export CMAKEPP_PATH=$HOME/Development/cmakepp/cmakepp.cmake
fi

# ZPLUG
# Check if zplug is installed
if [[ ! -f ~/.zplug/init.zsh ]]; then
  git clone https://github.com/b4b4r07/zplug ~/.zplug
  source ~/.zplug/init.zsh
else
  # Load ZPLUG
  source ~/.zplug/init.zsh
fi

# Add zplug plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# OMZ Libs
zplug "lib/clipboard", from:oh-my-zsh, defer:0
#zplug "lib/compfix", from:oh-my-zsh, defer:0
#zplug "lib/completion", from:oh-my-zsh, defer:0
zplug "lib/directories", from:oh-my-zsh, defer:0
zplug "lib/functions", from:oh-my-zsh, defer:0
zplug "lib/grep", from:oh-my-zsh, defer:0
zplug "lib/history", from:oh-my-zsh, defer:0
zplug "lib/key-bindings", from:oh-my-zsh, defer:0
zplug "lib/misc", from:oh-my-zsh, defer:0
zplug "lib/nvm", from:oh-my-zsh, defer:0
zplug "lib/termsupport", from:oh-my-zsh, defer:0
zplug "lib/theme-and-appearance", from:oh-my-zsh, defer:0

# Theme
zplug "themes/robbyrussell", from:oh-my-zsh

# Plugins
#zplug "plugins/tmux", from:oh-my-zsh, if:"which tmux", defer:2
zplug "bil-elmoussaoui/flatpak-zsh-completion", if:"which flatpak", use:"flatpak/flatpak.plugin.zsh", defer:2
zplug "pawel-slowik/zsh-term-title", if:"which tmux", use:"term-title.plugin.zsh", defer:2
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/history-substring-search", from:oh-my-zsh, as:plugin
zplug "plugins/nvm", from:oh-my-zsh, if:"which wp", defer:2
zplug "plugins/rvm", from:oh-my-zsh, if:"which wp", defer:2
zplug "plugins/ssh-agent", from:oh-my-zsh, if:"which ssh-agent"
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/urltools", from:oh-my-zsh
zplug "plugins/wp-cli", from:oh-my-zsh, if:"which wp", defer:2
zplug "plugins/z", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:3

# Then, source packages and add commands to $PATH
zplug load #--verbose
