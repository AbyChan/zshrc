source "$HOME/.zgen.zsh"

##very useful
function exists { which $1 &> /dev/null }

#zgen init
###############################################################
###############################################################
# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/history-substring-search
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load tarruda/zsh-autosuggestions
    # completions
    zgen load zsh-users/zsh-completions src
    # theme
    zgen oh-my-zsh themes/miloshadzic
    # save all to init script
    zgen save
fi

zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init


###  VARIABLES
###############################################################
###############################################################

export PATH="$HOME/bin:$PATH"
export TERM=xterm-256color
export EDITOR=vim

#export PATH="/home/tyan/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/tyan/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/tyan/USR/android-sdk-linux/tools:/home/tyan/USR/android-sdk-linux/platform-tools"
#export ANDROID_HOME="/home/tyan/USR/android-sdk-linux"
#export PATH="/home/tyan/.cask/bin:$PATH"

AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=14'

#fix arrow keys that display A B C D on remote shell
export term=cons25
[[ $TERM == eterm-color  ]] && export TERM=xterm
export EDITOR=vim
export PYTHONPATH=.:$PYTHONPATH

# output colored grep
export GREP_OPTIONS='--color=auto' 
export GREP_COLOR='7;31'



###keybinding
###############################################################
###############################################################
##autosuggestion
bindkey '^f' vi-forward-word
bindkey '^e' vi-end-of-line

##history
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down


if [[ "$TERM" != emacs ]]; then
    [[ -z "$terminfo[kdch1]" ]]        || bindkey -M emacs "$terminfo[kdch1]"       delete-char
    [[ -z "$terminfo[khome]" ]]        || bindkey -M emacs "$terminfo[khome]"       beginning-of-line
    [[ -z "$terminfo[kend]"  ]]        || bindkey -M emacs "$terminfo[kend]"        end-of-line
    [[ -z "$terminfo[kich1]" ]]        || bindkey -M emacs "$terminfo[kich1]"       overwrite-mode
    [[ -z "$terminfo[kdch1]" ]]        || bindkey -M vicmd "$terminfo[kdch1]"       vi-delete-char
    [[ -z "$terminfo[khome]" ]]        || bindkey -M vicmd "$terminfo[khome]"       vi-beginning-of-line
    [[ -z "$terminfo[kend]"  ]]        || bindkey -M vicmd "$terminfo[kend]"        vi-end-of-line
    [[ -z "$terminfo[kich1]" ]]        || bindkey -M vicmd "$terminfo[kich1]"       overwrite-mode

    [[ -z "$terminfo[cuu1]"  ]]        || bindkey -M viins "$terminfo[cuu1]"        vi-up-line-or-history
    [[ -z "$terminfo[cuf1]"  ]]        || bindkey -M viins "$terminfo[cuf1]"        vi-forward-char
    [[ -z "$terminfo[kcuu1]" ]]        || bindkey -M viins "$terminfo[kcuu1]"       vi-up-line-or-history
    [[ -z "$terminfo[kcud1]" ]]        || bindkey -M viins "$terminfo[kcud1]"       vi-down-line-or-history
    [[ -z "$terminfo[kcuf1]" ]]        || bindkey -M viins "$terminfo[kcuf1]"       vi-forward-char
    [[ -z "$terminfo[kcub1]" ]]        || bindkey -M viins "$terminfo[kcub1]"       vi-backward-char

    # ncurses stuff
    [[ "$terminfo[kcuu1]" == "O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
    [[ "$terminfo[kcud1]" == "O"* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history
    [[ "$terminfo[kcuf1]" == "O"* ]] && bindkey -M viins "${terminfo[kcuf1]/O/[}" vi-forward-char
    [[ "$terminfo[kcub1]" == "O"* ]] && bindkey -M viins "${terminfo[kcub1]/O/[}" vi-backward-char
    [[ "$terminfo[khome]" == "O"* ]] && bindkey -M viins "${terminfo[khome]/O/[}" beginning-of-line
    [[ "$terminfo[kend]"  == "O"* ]] && bindkey -M viins "${terminfo[kend]/O/[}"  end-of-line
    [[ "$terminfo[khome]" == "O"* ]] && bindkey -M emacs "${terminfo[khome]/O/[}" beginning-of-line
    [[ "$terminfo[kend]"  == "O"* ]] && bindkey -M emacs "${terminfo[kend]/O/[}"  end-of-line
fi

case "$TERM" in
    linux)	# Linux console
	bindkey '\e[1~'   beginning-of-line      # Home 
	bindkey '\e[4~'   end-of-line            # End  
	bindkey '\e[3~'   delete-char            # Del
	bindkey '\e[2~'   overwrite-mode         # Insert  
	;;
    screen)
	bindkey '\e[1~'   beginning-of-line      # Home
	bindkey '\e[4~'   end-of-line            # End
	bindkey '\e[3~'   delete-char            # Del
	bindkey '\e[2~'   overwrite-mode         # Insert
	bindkey '\e[7~'   beginning-of-line      # Home
	bindkey '\e[8~'   end-of-line            # End
	bindkey '\eOc'    forward-word           # ctrl cursor right
	bindkey '\eOd'    backward-word          # ctrl cursor left
	bindkey '\e[3~'   backward-delete-char   # This should not be necessary!
	;;
    rxvt)
	bindkey '\e[7~'   beginning-of-line      # Home
	bindkey '\e[8~'   end-of-line            # End
	bindkey '\eOc'    forward-word           # ctrl cursor right
	bindkey '\eOd'    backward-word          # ctrl cursor left
	bindkey '\e[3~'   backward-delete-char   # This should not be necessary!
	bindkey '\e[2~'   overwrite-mode         # Insert
	;;
    xterm*)
	bindkey '\e[H'    beginning-of-line      # Home
	bindkey '\e[F'    end-of-line            # End
	bindkey '\e[3~'   delete-char            # Del
	bindkey '\e[2~'   overwrite-mode         # Insert
	bindkey "^[[5C"   forward-word           # ctrl cursor right
	bindkey "^[[5D"   backward-word          # ctrl cursor left
	bindkey "^[[1;5C" forward-word           # ctrl cursor right
	bindkey "^[[1;5D" backward-word          # ctrl cursor left
	;;
    sun)
	bindkey '\e[214z' beginning-of-line      # Home
	bindkey '\e[220z' end-of-line            # End
	bindkey '^J'      delete-char            # Del
	bindkey '^H'      backward-delete-char   # Backspace
	bindkey '\e[247z' overwrite-mode         # Insert
	;;
esac


if (( $+key )); then
    bindkey -r ${key[Up]}
    bindkey -r ${key[Down]}
    bindkey -r ${key[Left]}
    bindkey -r ${key[Right]}
fi

# emacs keymap
## bindkey -M emacs '^W' kill-region
## bindkey -M emacs '
#silly-calc
bindkey -M emacs '%' zsh-query-replace
bindkey -M emacs '^[r' run-as-root  # esc-r
bindkey -M emacs '^[S' run-as-root # alt+shift+s
bindkey -M emacs '^[H' local-run-help
bindkey -M emacs '\en' history-beginning-search-forward-end
bindkey -M emacs '\ep' history-beginning-search-backward-end
bindkey -M emacs '\e/' lhist
bindkey "^Y"    yank                                   # <STRG>-Y
bindkey "^B"    backward-word                          # <STRG>-B
bindkey "^N"    forward-word                           # <STRG>-N

###alias
###############################################################
###############################################################
alias emax="emacsclient -t"                      # used to be "emacs -nw"
alias semac="sudo emacsclient -t"                # used to be "sudo emacs -nw"
alias emacsc="emacsclient -c -a emacs"           # new - opens the GUI with alternate non-daemon
alias py="python" 
alias rg='ranger'
alias ccat="source-highlight --out-format=esc -o STDOUT -i"

alias	 cd..='cd ..'
alias	 ..='cd ..'
alias    ...='cd ../..'
alias    ....='cd ../../..'
alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

#alias ks='ls'
#alias cd=rm -rf #####NOTICE: is a joke


###  SETTING
###############################################################
###############################################################

##某些linux系统在控制台发出蜂鸣，狗日的，吓死本宝宝了
xset b off
unsetopt beep


autoload      insert-unicode-char
zle -N        insert-unicode-char

#autojump
[[ -s /home/tyan/.autojump/etc/profile.d/autojump.sh  ]] && source /home/tyan/.autojump/etc/profile.d/autojump.sh #debian like
if exists brew; then
    [[ -s $(brew --prefix)/etc/profile.d/autojump.sh  ]] && . $(brew --prefix)/etc/profile.d/autojump.sh #mac
fi

# :completion:function:completer:command:argument:tag

zstyle    ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
          /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# this will include newly installed programs into tab completion
_force_rehash() { (( CURRENT == 1 )) && rehash return 1 }
zstyle    ':completion:*' completers _force_rehash

LISTMAX=0       # only ask if completion should be shown if it is larger than our screen
# this will not complete dotfiles in ~, unless you provide at least .<tab>
zstyle -e ':completion:*' ignored-patterns 'if [[ $PWD = ~ ]] && [[ ! $words[-1] == .* ]]; then reply=(.*); fi'
# Don't complete backup files (e.g. 'bin/foo~') as executables
zstyle    ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
# color completion
zstyle    ':completion:*' list-colors ''
# cache completions (think apt completion)
zstyle    ':completion:*' use-cache on
zstyle    ':completion:*' cache-path "$XDG_CACHE_HOME/zsh"


# Enable ..<TAB> -> ../
zstyle ':completion:*' special-dirs true

# RPROMPT="%(?..${fg_light_gray}[$fg_red%U%?%u${fg_light_gray}]$fg_no_colour) %h %D{%T %a %e.%m.%Y}"
# #PS2='%_ > '                                     # show for i in 1 2 3 \r foo > 
# #RPS2="<%^"                                      # _right_ PS2 
# SPROMPT="zsh: correct '%R' to '%r'? [N/y/a/e] "  # the prompt we see when being asked for substitutions

watch=(notme)
LOGCHECK=300
WATCHFMT='%n %a %l from %m at %t.'

CORRECT_IGNORE='_*'

setopt    append_history               # don't overwrite history
setopt    extended_history             # [unset] 
setopt    hist_find_no_dups            # [unset] ignore dupes in history search
setopt    hist_ignore_dups             # this will not put _consecutive_ duplicates in the history
setopt    hist_ignore_space            # if any command starts with a whitespace, it will not be saved. it will stil be displayed in the current session, though
setopt    hist_verify                  # [unset] when doing history substitution, put the substituted line into the line editor
# perhaps we want to change HISTCONTROL=ignoredups ?

setopt    auto_remove_slash            # [unset] If a completion ends with a slash and you type another slash, remove one of them
setopt    bg_nice                      # [set -6] Renice background jobs
#setopt    cdablevars
setopt    auto_param_slash             # [set] append a slash if completion target was a directory
setopt    auto_cd                      # [unset] enables you to omit 'cd' before a path
setopt    correct_all                  # Try to autocorrect commands & file names
setopt    hash_list_all                # [set] always make sure that the entire command path is hashed
setopt    short_loops                  # [unset] 'for i in *; echo $i;' instead of 'for i in *; do echo $i; done'
#setopt globdots                # with this, we could treat dotfiles the same as normal ones

setopt    interactive_comments         # with this, we can do 'some_evil_stuff # which we explain' and just execute some_evil_stuff
setopt    list_packed                  # [unset] show compact completion list
setopt    long_list_jobs               # [unset] show job number & PID when suspending
setopt no_clobber                      # this will probihbit 'cat foo > bar' if bar exists. use >! instead
setopt    extended_glob                # enables various things, most notably ^negation. '^', '#' and forgotwhich :/ see cheatsheet & http://zsh.dotsrc.org/Intro/intro_2.html#SEC2
setopt    numeric_glob_sort            # [unset] enables numeric order in globs
setopt    notify                       # [on] this will put info from finished background processes over the current line
setopt    function_arg_zero            # [on] this will fill $0 with the function name, not 'zsh'
# POSIX_BUILTINS                # find out about this one
setopt    complete_in_word             # [unset] tab completion within words

setopt    multios                      # this enables various goodness
# ls > foo > bar
# cmd > >(cmd1) > >(cmd2) # would redirect stdout from cmd to stdin of cmd1,2
# make install > /tmp/logfile | grep -i error
setopt    braceccl                     # {a-z} {0-2} etc expansion
setopt    prompt_subst                 # allow substition with $PS1, etc. Needed for vcs_info

autoload  compinit;compinit            # this enables autocompletion for pretty much everything
autoload  colors                       # use colors
colors
autoload  -Uz zmv                      # move function
autoload  -Uz zed                      # edit functions within zle

# move cursor between chars when typing '', "", (), [], and {}
magic-single-quotes()   { if [[ $LBUFFER[-1] == \' ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \' magic-single-quotes
magic-double-quotes()   { if [[ $LBUFFER[-1] == \" ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \" magic-double-quotes
magic-parentheses()     { if [[ $LBUFFER[-1] == \( ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \) magic-parentheses
magic-square-brackets() { if [[ $LBUFFER[-1] == \[ ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \] magic-square-brackets
magic-curly-brackets()  { if [[ $LBUFFER[-1] == \{ ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \} magic-curly-brackets
magic-angle-brackets()  { if [[ $LBUFFER[-1] == \< ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \> magic-angle-brackets
zle -N magic-single-quotes
zle -N magic-double-quotes
zle -N magic-parentheses
zle -N magic-square-brackets
zle -N magic-curly-brackets
zle -N magic-angle-brackets


autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# colored filename/directory completion
# Attribute codes:
# 00 none  01 bold  04 underscore  05 blink  07 reverse  08 concealed
# Text color codes:
# 30 black  31 red  32 green  33 yellow  34 blue  35 magenta  36 cyan  37 white
# Background color codes:
# 40 black  41 red  42 green  43 yellow  44 blue  45 magenta  46 cyan  47 white
LS_COLORS='no=0:fi=0:di=1;34:ln=1;36:pi=40;33:so=1;35:do=1;35:bd=40;33;1:cd=40;33;1:or=40;31;1:ex=1;32:*.tar=1;31:*.tgz=1;31:*.arj=1;31:*.taz=1;31:*.lzh=1;31:*.zip=1;31:*.rar=1;31:*.z=1;31:*.Z=1;31:*.gz=1;31:*.bz2=1;31:*.tbz2=1;31:*.deb=1;31:*.pdf=1;31:*.jpg=1;35:*.jpeg=1;35:*.gif=1;35:*.bmp=1;35:*.pbm=1;35:*.pgm=1;35:*.ppm=1;35:*.pnm=1;35:*.tga=1;35:*.xbm=1;35:*.xpm=1;35:*.tif=1;35:*.tiff=1;35:*.png=1;35:*.mpg=1;35:*.mpeg=1;35:*.mov=1;35:*.avi=1;35:*.wmv=1;35:*.ogg=1;35:*.mp3=1;35:*.mpc=1;35:*.wav=1;35:*.au=1;35:*.swp=1;30:*.pl=36:*.c=36:*.cc=36:*.h=36:*.core=1;33;41:*.gpg=1;33:'
ZLS_COLORS="$LS_COLORS"





###  FUNCION
###############################################################
###############################################################


if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
    
    function ppgrep() {
        if [[ $1 == "" ]]; then
            PERCOL=percol
        else
            PERCOL="percol --query $1"
        fi
        ps aux | eval $PERCOL | awk '{ print $2 }'
    }

    function ppkill() {
        if [[ $1 =~ "^-" ]]; then
            QUERY=""            # options only
        else
            QUERY=$1            # with a query
            [[ $# > 0 ]] && shift
        fi
        ppgrep $QUERY | xargs kill $*
    }
fi


# grep for running process, like: 'any vim'
function any() {
    if [[ -z "$1" ]] ; then
	echo "any - grep for process(es) by keyword" >&2
	echo "Usage: any <keyword>" >&2 ; return 1
    else
	local STRING=$1
	local LENGTH=$(expr length $STRING)
	local FIRSCHAR=$(echo $(expr substr $STRING 1 1))
	local REST=$(echo $(expr substr $STRING 2 $LENGTH))
	ps xauwww| grep "[$FIRSCHAR]$REST"
    fi
}

# after cd auto ls
function chpwd() {
    emulate -L zsh
    ls -a
}

# cd to the root of the current vcs repository
gr() {
    # vcsroot=`echo $vcs_info_msg_0_ | cut -d "|" -f 5`
    vcsroot=`/home/seebi/.vim/scripts/vcsroot.sh`
    echo $vcsroot && cd $vcsroot
}



###MISC
###############################################################
###############################################################


#更友好的git log
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"


###hook cancel
#control_c()
## run if user hits control-c
#{
#echo -en "\n*** Ouch! Exiting ***\n"
#return $? 
#}
## trap keyboard interrupt (control-c)
#trap control_c SIGINT

cat $HOME/.welcome 
