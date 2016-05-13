# Script to clean and liberate memory RAM & Swap.

Task:
 * Liberate Cache memory
 * Liberate Swap if there are RAM available
 * Show output with information
 
You must change the CONFIG section if you want to see messages on your screen.

# Cron settings
You can add this file at your Cron task like (This example execute it each hour):

```sh
$ crontab -e

$ 0 * * * * /bin/sh /home/carlos/Escritorio/memory
```


**Note:**
This script must be executed as ROOT.
