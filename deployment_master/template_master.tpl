Distribution: {{hostvars[inventory_hostname]['ansible_facts']['distribution']}} {{hostvars[inventory_hostname]['ansible_facts']['distribution_version']}}
Kernel: {{hostvars[inventory_hostname]['ansible_facts']['kernel']}}
vCPUs: {{hostvars[inventory_hostname]['ansible_facts']['processor_vcpus']}}
RAM_MB: {{hostvars[inventory_hostname]['ansible_facts']['memtotal_mb']}}
Boot_image: {{hostvars[inventory_hostname]['ansible_facts']['proc_cmdline']['BOOT_IMAGE']}}
Python: {{hostvars[inventory_hostname]['ansible_facts']['python_version']}}