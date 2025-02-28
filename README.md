# Automated Pi Config

This project was my attempt to have some kind of control and robustness around my Pi config. I recently lost an SD card that had everything I manually configured on it. You would think that a tech person would be better at backups 🙃.

In this project there are two files. The first one is the automated config that DietPi uses on first boot to configure the system. I have customized it to my liking but you can change whatever you want and its fairly extensive. Right now it has the default formatting and a lot of the options wasn't used. My second pass will be to clean this up and only include what I modified.

One thing to note is that on line 125 is where you set the password. I let my the default and I just change it after its all setup. You don't need the ticks, be sure to remove them

```bash
AUTO_SETUP_GLOBAL_PASSWORD='YOUR-PASSWORD-HERE'
```

I also have it set to auto install some additional software I need. There is a list that [DietPi maintaines](https://github.com/MichaIng/DietPi/wiki/DietPi-Software-list) and each software package that you want installed has to be on its own line. Again, this was just want I wanted and you can have it install what ever is on that list.

```
# Software to automatically install
# - Requires AUTO_SETUP_AUTOMATED=1
# - List of available software IDs: https://github.com/MichaIng/DietPi/wiki/DietPi-Software-list
# - Add as many entries as you wish, one each line.
# - DietPi will automatically install all dependencies, like ALSA/X11 for desktops etc.
# - E.g. the following (without the leading "#") will install the LXDE desktop automatically on first boot:
AUTO_SETUP_INSTALL_SOFTWARE_ID=17 #Git
AUTO_SETUP_INSTALL_SOFTWARE_ID=134 #Docker Compose
AUTO_SETUP_INSTALL_SOFTWARE_ID=162 #Docker
AUTO_SETUP_INSTALL_SOFTWARE_ID=185 #Portainer
```



The second file used is a script that will run AFTER networking is setup.

```
# Custom Script (post-networking and post-DietPi install)
# - Allows you to automatically execute a custom script at the end of DietPi install.
# - Option 0 = Copy your script to /boot/Automation_Custom_Script.sh and it will be executed automatically.
# - Option 1 = Host your script online, then use e.g. AUTO_SETUP_CUSTOM_SCRIPT_EXEC=https://myweb.com/myscript.sh and it will be downloaded and executed automatically.
# - Executed script log: /var/tmp/dietpi/logs/dietpi-automation_custom_script.log
AUTO_SETUP_CUSTOM_SCRIPT_EXEC=ADDNEWLINK/Automation_Custom_Script.sh
```
As you can see I have the script pointing to a [snippet](UPDATE) that runs some tasks outside of the normal automated DietPi config. This script is a part of this project so you can configure it to your needs as well. ITs nice becasue I can just host the file as part of this project and not have to maintain a copy somewhere. This script will finish the Pi setup by disabling Bluetooth and Wifi as well as creates some folders for me for my compose files. I hope to automate adding them as well so this is as close to zero touch as possible.


## Installation

After you flash the [DietPi image](https://dietpi.com/#home) to any SD Card/SSD etc, you need to put the ```dietpi.txt``` file in ```/boot/dietpi.txt``` before you detach whatever device you flashed the image too.

## License

[MIT](https://choosealicense.com/licenses/mit/)
