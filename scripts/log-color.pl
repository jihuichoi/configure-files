#!/usr/bin/perl -w  
  
while(<STDIN>) {  
    my $line = $_;  
    chomp($line);  
    for($line){  
        s/==>.*<==/\e[1;44m$&\e[0m/gi; 				#tail multiples files name in blue background  
        s/\[ERROR\].*/\e[0;31m$&\e[0m/gi;         #red : error
        s/\[INFO\].*/\e[0;90m$&\e[0m/gi;      		#blue
        s/\[DEBUG\].*/\e[1;34m$&\e[0m/gi; 				#green : debug
        s/\[WARNING\].*/\e[1;33m$&\e[0m/gi;				#yellow :warning       
        
    }  
    print $line, "\n";  
}

# color table : http://egloos.zum.com/sunyzero/v/4282610

# usage
# tail a.log | color.pl
#
# for convinience, add below line in ~/.bash_aliases
# alias ctail='_(){ tail $@ | log-color.pl; }; _'
# 
# then use as $ ctail -f a.log
# or for the lastest file in a directory
# $ ctail -f `ls -t | head -1`