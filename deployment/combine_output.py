#
import yaml
import os
from argparse import ArgumentParser

parser = ArgumentParser(description='YAML Output Concatinator 666')
parser.add_argument('--input-dir', dest='input_dir', required=False, default='./output', help='Directory with input files to merge')
parser.add_argument('--output-file', dest='output_file', required=False, default='audit_results.yaml', help='Path of merged output file')

args = parser.parse_args()


files = os.listdir(args.input_dir)
output = {}
for seq in range(len(files)):
    with open(args.input_dir + '/' + files[seq]) as f:
        l = yaml.load(f, Loader=yaml.FullLoader) 
        output = {**output, **l}

with open(args.output_file, 'w') as f:
    yaml.dump(output, f)