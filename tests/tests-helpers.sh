#!/bin/bash

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