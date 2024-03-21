# DROID_FARM
Scripts for quick setup of various CLI based tools

It should be noted that if you have the understanding of what to change this can easily be altered to work for you, however this repo is currently specifically for making the setup of a mining android farm my partner and I are working on. Soon enough I'll make a version more catered to the public. 

(To use for yourself just change the 2 variable values in the config file before running the script on your android device)

# Usage
1. To use this script first download & install the latest termux APK<br>
2. Edit the variables in the config.conf file before running script.<br>
3. Then run these commands 1 at a time:<br>
<br>
'pkg update' <br>
'pkg upgrade -y'<br>
'pkg install git'<br>
'git clone https://github.com/Derocious/DROID_FARM.git'<br>
'cd DROID_FARM'<br>
'bash dero_miner.sh'<br>
