# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/lenonr/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=3

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
#export LANGUAGE="pt_BR.UFT-8"
#export LANG="pt_BR.UTF-8"
#setxkbmap -model pc105 -layout br -variant abnt2

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR=$(which nano)
else
   export EDITOR=$(which vim)
fi

## Export editor default
export EDITOR=$(which nano)

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# autocompletar 
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#################
## ALIAS DIVERSOS
#################
## GIT
alias check_git="/home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/push_git.sh"
alias status_git="/home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/status_git.sh"
alias repo="source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/auto_alias.sh"

## DIVERSOS
alias dc="echo 'Prefiro a Marvel...'"
alias radio="/home/lenonr/Github/dev_sysadmin/others/radio/main.sh"
alias ksp_stats="subl /home/lenonr/Dropbox/Arquivos/Jogos/KSP/missions"
alias podcast="source /home/lenonr/Github/dev_sysadmin/others/podcast.sh"
alias rotina="libreoffice /home/lenonr/MEGA/LifeStyle/Outros/rotina.odt &"
alias pulseeffects="/home/lenonr/Github/dev_sysadmin/others/pulseeffects.sh"
alias pomodoro="/home/lenonr/Github/dev_scripts/Scripts/ShellScript/others/pomodoro.sh"
alias twitt="python /home/lenonr/Github/dev_scripts/Scripts/Python/twitter_bot/v1.py -t"
alias packages="dpkg --get-selections > /tmp/packages.txt && mousepad /tmp/packages.txt &"
alias internet="/home/lenonr/Github/dev_sysadmin/others/internet.sh"
alias launch_rocket="cd /home/lenonr/Github/dev_scripts/Scripts/Python/launch_bot && bash main.sh notify && cd - >/dev/null"
alias mpsyt="rm ~/.config/mps-youtube/cache_py_* ; /home/lenonr/.local/bin/mpsyt"

## SISTEMA
alias home="cd ~ && clear && ls"
alias subl="/snap/bin/sublime-text.subl"
alias vscode="/snap/bin/code.url-handler"
alias reboot_interface="xfce4-panel -r &"
alias wrt="/home/lenonr/Github/dev_sysadmin/others/wrt.sh"
alias session="/home/lenonr/Github/dev_sysadmin/others/session.sh"
alias sistema="cd /home/lenonr/Github/dev_sysadmin/others/sistema && bash main.sh && cd ~ > /dev/null"
alias mata="/home/lenonr/Github/dev_sysadmin/others/mata_processo.sh"
alias ip_externo="/home/lenonr/Github/dev_sysadmin/others/ip_externo.sh"
alias backup_zsh="/home/lenonr/Github/dev_sysadmin/others/backup_zsh.sh"
alias reboot_dropbox="/home/lenonr/Github/dev_sysadmin/others/dropbox.sh"
alias mega_dropbox="/home/lenonr/Github/dev_sysadmin/others/mega_dropbox.sh"
alias verificahd="/home/lenonr/Github/dev_sysadmin/others/verifica_midia.sh"
alias check_battery="/home/lenonr/Github/dev_sysadmin/others/battery/main.sh"
alias check_sizefile="/home/lenonr/Github/dev_sysadmin/others/check_sizefile.sh"
alias check_services="/home/lenonr/Github/dev_sysadmin/others/check_services.sh"
alias change_brightness="su root /home/lenonr/Github/dev_sysadmin/others/change_brightness.sh"