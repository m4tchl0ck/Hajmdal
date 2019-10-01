#!/bin/bash

. "$1"
RESULTS_PATH="tests-results"
RESULT="$RESULTS_PATH/results.txt"
SUT=$2
EXT=0;

if [ -d $RESULTS_PATH ]; then
    rm -d -r $RESULTS_PATH
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
    result=$($test_case 2>&1)
    if [ $? -eq 0 ]; then
        write_result "$start_at [PASS] $test_case"
    else
        EXT=1
        write_result "$start_at [FAIL] $test_case"
        write_result "Result:"
        write_result "$result"
    fi
done

echo "$(now) Tests finished" >> $RESULT

exit $EXT