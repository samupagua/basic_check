#!/bin/bash


function ctrl_c(){
 echo -e "\n [!] Closing...\n "
 exit 1

}

# Ctrl+C

trap ctrl_c INT

function helpPanel(){
  echo -e "\n[+] Enter one of these options:"
  echo -e "\tr) Show current Memory RAM usage"
  echo -e "\tc) Show CPU idle of the system"
  echo -e "\ti) Show current Inode usage"
  echo -e "\to) Show I/O Percentage of the system"
  echo -e "\td) Show current Disk usage"
  echo -e "\tp) Show mains processes that use more CPU"

}

function get_RAM(){
  RAM="$(free -h | grep 'Mem:*' | awk '{print $3 "/" $2}')"
  
  echo -e "\n[+] The system use $RAM of RAM memory\n"
}

function get_CPUidle(){

  CPU="$(iostat | grep -A1 "idle" | awk {'print $6'} | grep -v "steal")"
  echo -e "\n[+] System has $CPU% of CPU idle"
}

function get_InodeUsage(){

  InodeU="$(df -ih | awk '{print $5 " " $6}' | sort -rn | head -n 1 )"
  echo -e "\n[+] The maximum Inode usage is in $InodeU \n"
}

function get_IOPercentage(){

  IO_Per="$(iostat | grep -A1 "user" | awk {'print $1'} | grep -v "avg-cpu")"
  echo -e "\n[+] The percentage of I/O is $IO_Per%"

}

function get_DiskUsage(){

  DiskU="$(df -h | awk {'print $5 " " $6'} | sort -rn | head -n 1)"
  echo -e "\n[+] The maximum Disk usage is in $DiskU"
}

function check_Process(){

  CheckPS="$(ps -aux | awk '{print $3"%CPU" " PID: "$2" User: "$1 " Command: "$11}' | sort -rn | head -5)"
  echo -e "\n[+] The processes that consume more CPU are: \n"
  echo -e "$CheckPS"
}

while true; do
    read -p "[+] Please enter a valid option to get system stadistics, for help enter h: " option
    case $option in
        r)
            get_RAM
            break
            ;;
        c)
            get_CPUidle
            break
            ;;
        i)
            get_InodeUsage
            break
            ;;
        o) 
            get_IOPercentage
            break
            ;;
        d)
            get_DiskUsage
            break
            ;;
        p)
            check_Process
            break
            ;;
        h)
            helpPanel
            break
            ;;
        *)
            echo " "
            echo "[!] Invalid option."
            ;;
    esac
done






