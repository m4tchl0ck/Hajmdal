#!/bin/bash

TEST_CASES=( )

TEST_CASES[${#TEST_CASES[@]}]=hajmdal_should_create_a_photo_file_when_take_a_photo_is_called
hajmdal_should_create_a_photo_file_when_take_a_photo_is_called()
{
    local result=$($SUT take_a_photo --device /dev/video0 --file $RESULTS_PATH/img0.jpg 2>&1)

    if [ -e "$RESULTS_PATH/img0.jpg" ]; then
        true
    else
        echo "File '$RESULTS_PATH/img0.jpg' not exists" >&2
        echo "$result" >&2
        false
    fi
}

TEST_CASES[${#TEST_CASES[@]}]=hajmdal_should_write_error_when_not_know_operation_is_called
hajmdal_should_write_error_when_not_know_operation_is_called()
{
    local result=$($SUT blah 2>&1)

    assert_equal "'blah' is unknown operation name" "$result"
}

TEST_CASES[${#TEST_CASES[@]}]=hajmdal_should_write_hello_world_when_hw_operation_is_called
hajmdal_should_write_hello_world_when_hw_operation_is_called()
{
    local result=$($SUT hw)

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
SUT="scripts/hajmdal.sh"
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