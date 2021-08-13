{{inventory_hostname}}:
  IP_address: {{hostvars[inventory_hostname]['ansible_facts']['default_ipv4']['address']}}