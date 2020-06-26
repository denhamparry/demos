#!/bin/bash

mkdir -p merged
mkdir -p work

mount -t overlay -o lowerdir=./lower,upperdir=./upper,workdir=./work overlay ./merged