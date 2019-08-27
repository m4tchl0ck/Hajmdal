#!/bin/bash

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

test_hajmdal_should_read_the_plates_when_read_the_plates_is_called()
{
    . "$SUT"
    local result=""
    result=( $(read_the_plates --file "tests/data/h786poj.jpg" 2>&1) )

    if [ $? -eq 0 ]; then
        assert_equal "H786P0J" ${result[0]}
        assert_equal "HC786P0J" ${result[1]}
        assert_equal "H3786P0J" ${result[2]}
        assert_equal "HG786P0J" ${result[3]}
        assert_equal "HH786P0J" ${result[4]}
        assert_equal "H786PDJ" ${result[5]}
        assert_equal "H786POJ" ${result[6]}
        assert_equal "MH786P0J" ${result[7]}
        assert_equal "H786PQJ" ${result[8]}
        assert_equal "UH786P0J" ${result[9]}
    fi
    
    if [ $? -ne 0 ]; then
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

########################################

assert_equal()
{
    expected_value=$1
    value=$2

    if [ "$value" = "$expected_value" ]; then
        true
    else
        echo "expected: '$expected_value', but was '$value'" >&2
        false
    fi
}

########################################

RESULTS_PATH="tests-results"
RESULT="$RESULTS_PATH/results.txt"
SUT=scripts/hajmdal.sh
EXT=0;

if [ -d $RESULTS_PATH ]; then
    rm -d $RESULTS_PATH
fi
mkdir $RESULTS_PATH

now()
{
    echo $(date +"%T")
}

write_result()
{
    echo "$1" >&1
    echo "$1" >> $RESULT
}

echo "$(now) Tests started" > $RESULT

TEST_CASES=( $(compgen -A function | grep test_) )

for test_case in ${TEST_CASES[@]}; do
    start_at=$(now)
    result=$($test_case)
    if [ $? -eq 0 ]; then
        write_result "$start_at [PASS] $test_case"
    else
        EXT=1
        write_result "$start_at [FAIL] $test_case"
    fi
done

echo "$(now) Tests finished" >> $RESULT

exit $EXT