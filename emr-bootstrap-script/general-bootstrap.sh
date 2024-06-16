#!/bin/bash
set -x
sudo pip3 install --upgrade pip
sudo python3 -m pip install --upgrade redshift_connector
sudo python3 -m pip install --upgrade boto3
sudo python3 -m pip install requests
sudo python3 -m pip install pandas
sudo python3 -m pip install numpy
sudo python3 -m pip install scikit-learn