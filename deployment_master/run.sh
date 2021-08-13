#!/bin/bash
ansible-inventory --graph --yaml --vars
ansible -m ping all 
ansible-playbook deploy_master.yaml
ansible-playbook audit.yaml
python3 combine_output.py --input-dir ./output --output-file ./audit_results.yaml