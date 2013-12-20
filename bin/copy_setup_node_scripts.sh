#!/bin/bash

for node in node{1..4}
do
	scp bin/setup_new_node.sh root@$node:
done
