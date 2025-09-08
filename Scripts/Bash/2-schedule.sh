#!/bin/bash

(echo "0 0 * * * bash ./1-ETL_script.sh") | crontab -

