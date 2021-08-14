#!/usr/bin/python3
from argparse import ArgumentParser   
import json
import os

def setenv(params):
  for p in params:
    print('export ' + p.replace("-","_") + '=' + str(params[p]))
    os.environ[p.replace("-","_")] = str(params[p])

parser = ArgumentParser(description='pyATS job wrapper')
parser.add_argument('--prefix', dest='prefix', required=False, default='gfd-39-comp-01', help='Competitor prefix | default gfd-39-comp-01')
parser.add_argument('--file', dest='file', required=False, default='../provisioning/tf-dynamic-params.json', help='tf-dynamic-params.json')
args = parser.parse_args()

with open(args.file) as f: 
    tfd = json.load(f) 

setenv(tfd[args.prefix])

# to run
# eval $(./setenv.py)