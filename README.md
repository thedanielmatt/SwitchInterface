## SwitchInterface

****
###NOTE: 
This is a Script Written by: Unknown 
I found it on the Web a year ago and just modified it for fitting in Our environment
****

#####Functionality:
When Ethernet cable is plugged in Wi-Fi is disabled. When Cable is disconnected Wi-Fi will turn on again.



#####Hot to Use:
######Method 1: Download the zip file, extract it and run the .pkg file

######Method 2: Build it on your own. 
switchInterface.sh should be copied to /Library/Scripts/
com.mine.switchinterface.plist should be copied to /Library/LaunchAgents/

Service must be load with sudo launchctl load /Library/LaunchAgents/com.mine.switchinterface.plist



#####Works on:
tested and working on MBP 13" Retina and MBP 15" Non-Retina.
Not working on iMac.

