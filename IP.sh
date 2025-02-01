#!/bin/bash

echo "IP:$(ip address | grep "inet " | awk '{print $2}' )" 
