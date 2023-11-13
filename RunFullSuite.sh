#!/bin/bash


# DefaultArg
TestConf=${1:-./testConfig.conf}


TestScripts="./testScripts"
source $TestScripts/testRunner.sh


file="$TestConf"
while read -r line; do
    RunTest $line || true 
done <$file