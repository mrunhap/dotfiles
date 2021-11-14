# where should we store your Zsh plugins?
ZPLUGINDIR=$HOME/.zsh/plugins

# if you want to use unplugged, you can copy/paste plugin-clone here, or just pull the repo
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/unplugged.zsh

# add your plugins to this list
plugins=(
  # core plugins
  mafredri/zsh-async
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search

  # user plugins
  rupa/z

  # load this one last
  zsh-users/zsh-syntax-highlighting
)

# clone, source, and add to fpath
for repo in $plugins; do
    plugin-load https://github.com/${repo}.git
done
unset repo

# DONTKNOW
#autoload -Uz compinit
#compinit

PS1='%F{green}%n@%m%f %F{blue}%~%f %# '

alias ls "ls --color"
alias python "python3"