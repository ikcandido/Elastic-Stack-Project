#!/bin/bash

#priorities alert and higher
#Journalctl --list-boots
journalctl -p alert -b
#check size of system disk journal
journalctl --disk-usage -b 0
#remove  except most recent 2 files
journalctl --vacuum-files=2

