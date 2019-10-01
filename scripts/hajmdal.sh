#!/bin/bash

is_plate_allowed(){
    while [[ $# -gt 0 ]]
    do
        key="$1"

        case $key in
            --plates)
            local plates=( $2 )
            ;;
            --data-file)
            local data_file="$2"
            ;;
        esac
        
        shift # past argument
        shift # past value
    done

    for plate in "${plates[@]}"
    do
        if grep -q $plate $data_file; then
            return 0
        fi
    done

    return 1
}

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

    plates=( $(alpr -c eu $file | grep -Po '(?<=\s-\s)[\w\d]+(?=\s+confidence:)') )
    if [ ${#plates[@]} -eq 0 ]; then
        false
    else
        echo "${plates[@]}"
    fi
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
