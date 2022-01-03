#!/bin/bash
LOG_DIR="../logs"
FILE_NAME=$(date +"%b-%d-%y_%H-%M-%S")
TB_NAME="Baisc Axis Adder"
echo "\e[32m--- Running $TB_NAME Tests: Logging to $LOG_DIR/$FILE_NAME_results.log ---\e[0m"
cocotb-clean -r
pytest -r a -q --forked --num-tests 5 --reruns 3 --reruns-delay 3 --new-first --cache-clear --self-contained-html --html=$LOG_DIR/$FILE_NAME_results.html --log-file=$LOG_DIR/$FILE_NAME_results.log
# -n auto --num-tests 5