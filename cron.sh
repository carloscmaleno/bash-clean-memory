#!/bin/sh
 
## Bash Script to clear Swap memory and clean other cache
## see http://github.com/carloscmaleno/bash-clean-memory

####################### CONFIG ################################
############## CHANGE WITH YOUR VALUES ########################
DISPLAY=:0.0
export XAUTHORITY=/home/your_user_name/.Xauthority
###############################################################

## Make S.O. ready to operations
sync

# Calculate RAM
mem=`cat /proc/meminfo | grep "MemTotal" | tr -s ' ' | cut -d ' ' -f2`
mem=`echo "$mem/1024.0" | bc`

mem_free=`cat /proc/meminfo | grep "MemFree" | tr -s ' ' | cut -d ' ' -f2`
mem_free=`echo "$mem_free/1024.0" | bc`

# Calculate RAM Cache
cached_before=`cat /proc/meminfo | grep "^Cached" | tr -s ' ' | cut -d ' ' -f2`
cached_before=`echo "$cached_before/1024.0" | bc`


# Calculate Swap size
swapmem_total=`cat /proc/meminfo | grep "SwapTotal" | tr -s ' ' | cut -d ' ' -f2`
swapmem_free=`cat /proc/meminfo | grep "SwapFree" | tr -s ' ' | cut -d ' ' -f2`
swapmem=$(( $(( $swapmem_total - $swapmem_free)) / 1024))


# Liberate RAM Cache
echo 3 > /proc/sys/vm/drop_caches

# Wait to O.S.
sleep 5

# Calculate RAM Caché liberated
cached_after=`cat /proc/meminfo | grep "^Cached" | tr -s ' ' | cut -d ' ' -f2`
cached_after=`echo "$cached_after/1024.0" | bc`
cached_liberate=$(( $(( $cached_before - $cached_after)) / 1024))


# Liberate Swap memory
if [ "$swapmem" -gt 0 ] && [ "$swapmem" -lt "$mem_free" ]; then
  swapoff -a 
  swapon -a
fi


## Show output
zenity --info \
    --text="Memory has been clear \n
     - Memory: $mem MB
     - Free: $mem_free MB
     - Cache: $cached_before MB 
     - Liberate: $cached_liberate MB
     - Swap: $swapmem MB" \
    --timeout="3"
    
