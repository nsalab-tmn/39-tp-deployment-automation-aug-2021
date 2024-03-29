import yaml
import json
import io
import pprint
import os

from pyats.easypy import run
from pyats.easypy import Task
from genie import testbed
from yamlinclude import YamlIncludeConstructor
from argparse import ArgumentParser, Namespace
from assessment import update_dict, setenv


def main(runtime):
    
    parser = ArgumentParser(description='pyATS job wrapper')
    parser.add_argument('--topology-file', dest='TOPOLOGY', required=False, default='testbed.yaml', help='Testbed topology')
    parser.add_argument('--marking-file', dest='DATAFILE', required=False, default='marking.yaml', help='Marking datafile')
    parser.add_argument('--include-basedir', dest='BASEDIR', required=False, default='./testcases.d', help='Testcases basedir')
    parser.add_argument('--internal-params', dest='PARAMS', required=False, default='params.yaml', help='Internal parameters')
    parser.add_argument('--static-params', dest='TFS', required=False, default='tf-static-params.json', help='Terraform static parameters')
    parser.add_argument('--dynamic-params', dest='TFD', required=False, default='tf-dynamic-params.json', help='Terraform dynamic parameters')
    parser.add_argument('--unit-test', dest='UT', required=False, default='ut.py', help='Unit test script')
    args = parser.parse_args()

    
    try:
        YamlIncludeConstructor.add_to_loader_class(loader_class=yaml.FullLoader, base_dir=args.BASEDIR)        
        with open(args.DATAFILE) as f:
            df = yaml.load(f, Loader=yaml.FullLoader)        
        with open(args.PARAMS) as f:
            params = yaml.load(f, Loader=yaml.FullLoader)
        with open(args.TFS) as f:
            tfs = json.load(f)
        with open(args.TFD) as f:
            tfd = json.load(f)
    except Exception as e:
        print('Exception occured: ' + str(e))
        exit(1)

    update_dict(params, tfs)   

    tasks = []
    seq = 0
    for prefix in tfd:
        update_dict(params, tfd[prefix])
        setenv(params)
        tb = testbed.load(args.TOPOLOGY) 
        tasks.append(Task(
            testscript = args.UT,
            testbed=tb,
            datafile=df,
            runtime = runtime,
            taskid = "Competitor {:02d}".format(seq + 1),
            params = params))
        tasks[seq].start()
        tasks[seq].wait()
        seq += 1
