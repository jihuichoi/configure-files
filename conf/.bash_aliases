
### find, ls, grep, du

# find something, show with ls -alh and sort
alias fl='_(){ find $@ -exec ls -alh {} \;| column -t | sort -k9}; _'

# find something and show the size
function fdu() { find $@ -type f -exec du -ch {} + | grep total$ ;};

# ls with options
# -a : all files
# -l : long format
# -h : human readable
# -L : show inside of symbolic link
# -r : reverse order while sorting
# -t : sort by modification time, newest first
alias ls='ls --time-style=long-iso'
alias l='ls -alh'		# all, long, human-readable
alias ll='ls -Lalh'		# all, long, human-readable for symbolic link
alias lt='ls -alhtr'	# all, long, human-readble, sort by modi-time, order by reverse

# grep with options
# -n : line-number
# -i : ignore-case
# -r : recursive
alias gr='grep -nir --color' #

# du with depth and sort
alias du1='du -ch -d 1'
alias du2='du -ch -d  2'
alias du3='du -ch -d  3'
alias du4='du -ch -d  4'
alias dus1='du -ch -d  1 | sort -h'	# -h : human-numeric-sort
alias dus2='du -ch -d  2 | sort -h'
alias dus3='du -ch -d  3 | sort -h'
alias dus4='du -ch -d  4 | sort -h'



### GIT
export LESSCHARSET=utf-8

# basic actions
alias git='LANG=en_GB git'
alias gch='git checkout'
alias gs='git status -s'
alias gad='git add'
alias gcm='git commit -m'
alias gdf='git diff --word-diff=color'
function gitl() { if [ $# -eq 0 ]; then git l; else git l ":(exclude)$1"; fi;};

# push to origin [branch], pull from origin [branch]:  ex) gpull master
function gpush() { if [ $# -eq 0 ]; then git push origin $(git branch | cut -d" " -f 2); else git push origin $1; fi;};
function gpull() { if [ $# -eq 0 ]; then git pull origin $(git branch | cut -d" " -f 2); else git pull origin $1; fi;};


function gupdate() { currentbranch=$(git branch | awk '/\*/{print $2}' | awk '{print $1}');
	git checkout master && git pull origin master  \
	&& printf "\n" \
	&& git checkout develop && git pull origin develop  \
	&& printf "\n" \
	&& git checkout $currentbranch ; };


### Misc

# show time as ISO 8601 format, recent 100 only
alias hist='\history -t "%Y-%m-%d %H:%M:%S" -100'

# os update for ubuntu
alias osupdate='sudo apt autoremove && sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove && sudo apt autoclean'

# 프로세스 검색
alias psgrep='ps aux | grep -ni --color'

#지정한 키워드가 들어간 프로세스 모두 삭제: kall 키워드
function kall() { ps aux | grep "$1" | grep -v "fpm\|grep" | awk '{print $2}' | xargs kill -9; };

#for safety
alias crontab='crontab -i'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'
