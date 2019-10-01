#!/bin/bash

. ./tests/tests-helpers.sh

test_is_car_allowed_should_call_is_plate_allowed_with_correct_arguments()
{
    . "$SUT"
 
    declare -a called_take_photo
    called_take_photo[0]=1
    take_a_photo()
    {
        true
    }

    read_the_plates()
    {
        echo "123"
        echo "456"
        echo "789"
    }

    is_plate_allowed()
    {
        assert_equal "--plates" $1
        res=$?
        local plates=( $2 )
        assert_equal "123 456 789" "${plates[*]}"
        res=$(($?+$res))
        assert_equal "--data-file" $3
        res=$(($?+$res))
        assert_equal "some-data-file" $4
        res=$(($?+$res))
        if [ $res -gt 0 ]; then
            false
        fi
    }

    local result="";
    result=$(is_car_allowed --cam some-cam --img some-img-file --data-file some-data-file)

    if [ $? -ne 0 ]; then
        echo "Error $?" >&2
        echo $result >&2
        false
    fi
}

test_is_car_allowed_should_call_read_the_plates_with_correct_arguments()
{
    . "$SUT"

    take_a_photo()
    {
        return 0
    }

    read_the_plates()
    {
        assert_equal "--file" $1
        res=$?
        assert_equal "some-img-file" $2
        res=$(($?+$res))
        if [ $res -gt 0 ]; then
            false
        fi
    }

    is_plate_allowed()
    {
        return 0
    }

    local result="";
    result=$(is_car_allowed --cam some-cam --img some-img-file --data-file some-data-file)

    if [ $? -ne 0 ]; then
        echo "Error $?" >&2
        echo $result >&2
        false
    fi
}

test_is_car_allowed_should_call_take_a_photo_with_correct_arguments()
{
    . "$SUT"

    take_a_photo()
    {
        assert_equal "--device" $1
        res=$?
        assert_equal "some-cam" $2
        res=$(($?+$res))
        assert_equal "--file" $3
        res=$(($?+$res))
        assert_equal "some-img-file" $4
        res=$(($?+$res))
        if [ $res -gt 0 ]; then
            false
        fi
    }

    read_the_plates()
    {
        return 0
    }

    is_plate_allowed()
    {
        return 0
    }

    local result="";
    result=$(is_car_allowed --cam some-cam --img some-img-file --data-file some-data-file)

    if [ $? -ne 0 ]; then
        echo "Error $?" >&2
        echo $result >&2
        false
    fi
}

test_hajmdal_should_not_allow_when_is_plate_not_allowed_is_called()
{
    . "$SUT"
    local result="";
    result=$(is_plate_allowed --plates "SK44444 SK00442" --data-file "tests/data/plates.txt" 2>&1)

    if [ $? -eq 0 ]; then
        echo "Error $?" >&2
        echo $result >&2
        false
    fi
}

test_hajmdal_should_allow_when_is_plate_allowed_is_called()
{
    . "$SUT"
    local result="";
    result=$(is_plate_allowed --plates "SK12345 SK00442" --data-file "tests/data/plates.txt" 2>&1)

    if [ $? -ne 0 ]; then
        echo "Error $?" >&2
        echo $result >&2
        false
    fi
}

test_hajmdal_should_not_return_error_when_open_gate_is_called()
{
    . "$SUT"
    local result=""
    result=$(open_gate --gpio 17 --sleep 0 2>&1)
    
    if [ $? -ne 0 ]; then
        echo "Error $?" >&2
        echo $result >&2
        false
    fi
}

test_read_the_plates_should_return_1_when_plates_not_found()
{
    . "$SUT"
    local result=""
    result=( $(read_the_plates --file "tests/data/none.jpg" 2>&1) )

    if [ $? -ne 1 ]; then
        echo "Error $?" >&2
        echo $result >&2
        false
    fi
}

test_read_the_plates_should_return_0_when_plates_found()
{
    . "$SUT"
    local result=""
    result=( $(read_the_plates --file "tests/data/h786poj.jpg" 2>&1) )

    if [ $? -ne 0 ]; then
        echo "Error $?" >&2
        echo $result >&2
        false
    fi
}

test_read_the_plates_should_return_plates_when_plates_found()
{
    . "$SUT"
    local result=""
    result=( $(read_the_plates --file "tests/data/h786poj.jpg" 2>&1) )

    if [ $? -eq 0 ]; then
        assert_equal "H786P0J" ${result[0]}
        res=$?
        assert_equal "HC786P0J" ${result[1]}
        res=$(($?+$res))
        assert_equal "H3786P0J" ${result[2]}
        res=$(($?+$res))
        assert_equal "HG786P0J" ${result[3]}
        res=$(($?+$res))
        assert_equal "HH786P0J" ${result[4]}
        res=$(($?+$res))
        assert_equal "H786PDJ" ${result[5]}
        res=$(($?+$res))
        assert_equal "H786POJ" ${result[6]}
        res=$(($?+$res))
        assert_equal "MH786P0J" ${result[7]}
        res=$(($?+$res))
        assert_equal "H786PQJ" ${result[8]}
        res=$(($?+$res))
        assert_equal "UH786P0J" ${result[9]}
        res=$(($?+$res))
        if [ $res -gt 0 ]; then
            false
        fi
    else
        echo "Error $?" >&2
        echo ${result[*]} >&2
        false
    fi
}

test_hajmdal_should_create_a_photo_file_when_take_a_photo_is_called()
{
    . "$SUT"
    local result=""
    result=$(take_a_photo --device /dev/video0 --file $RESULTS_PATH/img0.jpg 2>&1)

    if [ -e "$RESULTS_PATH/img0.jpg" ]; then
        true
    else
        echo "File '$RESULTS_PATH/img0.jpg' not exists" >&2
        echo "$result" >&2
        false
    fi
}

test_hajmdal_should_write_hello_world_when_hw_operation_is_called()
{
    . "$SUT"
    local result=""
    result=$(hw)

    assert_equal "Hello world" "$result"
}
