# ZSH envioronment

export LANG="en_US.UTF-8"
export TERM=xterm-256color
# TODO emacs tiny config
export EDITOR='emacs'

# Golang
export GO111MODULE=auto
export GOPROXY=https://goproxy.cn 
export GOPATH=$HOME/go
export PATH=${GOPATH//://bin:}/bin:$PATH

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Global(gtags)
export GTAGSOBJDIRPREFIX=$HOME/.cache/gtags/
export GTAGSCONF=$HOME/.globalrc
export GTAGSLABEL=native-pygments

# sdcv
export STARDICT_DATA_DIR=$HOME/.sdcv-dict

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
