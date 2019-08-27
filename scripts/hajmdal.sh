#!/bin/bash

open_gate()
{
    while [[ $# -gt 0 ]]
    do
        key="$1"

        case $key in
            --gpio)
            local gpio="$2"
            ;;
            --sleep)
            local sleep="$2"
            ;;
        esac

        shift # past argument
        shift # past value
    done

    echo $gpio > /sys/class/gpio/export
    echo "out" > /sys/class/gpio/gpio$gpio/direction
    echo "1" > /sys/class/gpio/gpio$gpio/value
    sleep $sleep
    echo "0" > /sys/class/gpio/gpio$gpio/value
}

read_the_plates()
{
    while [[ $# -gt 0 ]]
    do
        key="$1"

        case $key in
            -f|--file)
            local file="$2"
            ;;
        esac
        
        shift # past argument
        shift # past value
    done

    alpr -c eu $file | grep -Po '(?<=\s-\s)[\w\d]+(?=\s+confidence:)'
}

take_a_photo()
{
    while [[ $# -gt 0 ]]
    do
        key="$1"

        case $key in
            -d|--device)
            local device="$2"
            ;;
            -f|--file)
            local file="$2"
            ;;
        esac
        
        shift # past argument
        shift # past value
    done
    fswebcam --no-banner --device $device $file
}

hw()
{
    echo "Hello world" >&1
}

if declare -f "$1" > /dev/null
then
  "$@"
else
  echo "'$1' is unknown operation name" >&2
  exit 1
fi
