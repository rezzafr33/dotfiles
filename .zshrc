# local PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# rust
export LD_LIBRARY_PATH=$HOME/Development/rust/rustc/lib
export PATH=$HOME/Development/rust/rustc/bin:$HOME/Development/rust/cargo/bin:$PATH

# android
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH

# composer
export PATH=$HOME/.config/composer/vendor/bin:$PATH

# yarn
export PATH=$HOME/.yarn/bin:$PATH
# rvm
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# MANPATH
export MANPATH=$HOME/.local/man:$HOME/.local/share/man:$MANPATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/home/jefri/.sdkman"
#[[ -s "/home/jefri/.sdkman/bin/sdkman-init.sh" ]] && source "/home/jefri/.sdkman/bin/sdkman-init.sh"

# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# load completion function
autoload -U +X bashcompinit && bashcompinit

# Export LESS
export LESS="-s -X -R -F"

# Man
export MANPAGER="less -s -X -R -F"

# ANTIGEN
source ~/.antigen/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle wp-cli
antigen bundle history
antigen bundle history-substring-search

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme dracula

# Tell antigen that you're done.
antigen apply
