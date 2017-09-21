# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# load completion function
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# local PATH
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# MANPATH
export MANPATH=$HOME/.local/man:$HOME/.local/share/man:$MANPATH

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
  export PATH="$PATH:$HOME/.rvm/bin"
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

# Dircolors
if [[ -s "$HOME/.dir_colors/dircolors" ]]; then
  eval `dircolors $HOME/.dir_colors/dircolors`
fi

# ANTIGEN
source ~/.antigen/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle wp-cli
antigen bundle nvm
antigen bundle history
antigen bundle history-substring-search

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply
