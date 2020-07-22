#!/bin/bash

colour="\\e[32m"
bold="\\e[1m"

presenting=true

function demopause () {
    read -r -n 1 -p "$1"
}

function demoheader (){
    if [ $presenting ]
      then
        clear
    fi
    echo -e "$bold$colour$1"
    demoresetterminal
}

function demofocus (){
    echo -e "$colour\$ $1"
    demoresetterminal
    if [ $presenting ]
      then
        demopause
    fi
    eval "$1"
}

function demoresetterminal (){
    echo -e "\\e[0m"
}

function demoend (){
	echo -e "\\n\\n"
    if [ $presenting ]
      then
        demopause "Press any key to continue..."
    fi
}
