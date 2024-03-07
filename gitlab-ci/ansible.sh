#!/bin/bash

ansible-playbook -i hosts.cfg -u ubuntu --private-key ~/.ssh/centhis install.yml
