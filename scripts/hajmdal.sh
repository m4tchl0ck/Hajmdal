#!/bin/bash

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
