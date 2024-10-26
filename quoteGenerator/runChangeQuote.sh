#!/bin/bash

# get parent directory of script
parent_dir=$(cd "$(dirname "$0")" && pwd)

# change the quote
python3 $parent_dir/changeQuote.py