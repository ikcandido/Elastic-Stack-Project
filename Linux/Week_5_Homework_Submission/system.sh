#!/bin/bash

free -h > ~/Backups/freemem/free_mem.txt
lsof > ~/Backups/openlist/openlist.txt
du > ~/Backups/diskuse/diskusage.txt
df -h > ~/Backups/freedisk/freedisk.txt
