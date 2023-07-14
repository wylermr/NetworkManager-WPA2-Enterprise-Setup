# NetworkManager-WPA2-Enterprise-Setup
How to set up NetworkManager for use on school and other WPA2-Enterprise Networks using only systemctl or nmcli, and the text editor of your choice.

# Backstory
 since moving off of Ubuntu, network setup has been a pain, so here's a how-to and skeleton for a config file for WPA2 Enterprise Networks. This method has been tested on two different university networks and worked for both.

## How To Option 1
1. If you don't have NetworkManager installed, either get it from your package manager or transfer the source from a computer that has network access and go [here](http://www.linuxfromscratch.org/blfs/view/svn/basicnet/networkmanager.html) for instructions on how to install it.
2. Configure WPA2 Enterprise network using `nmcli` command:

   ```bash
   nmcli connection add \
     type wifi \
     connection.id [PROFILE_NAME] \
     wifi.ssid [SSID] \
     wifi.mode infrastructure \
     wifi-sec.key-mgmt wpa-eap \
     802-1x.eap peap \
     802-1x.identity [IDENTITY] \
     802-1x.phase2-auth mschapv2 \
     802-1x.password [PASSWORD]
   ```

   Replace the following placeholders with your network-specific information:

   - `[PROFILE_NAME]`: A name for the network profile.
   - `[SSID]`: The SSID (network name) of the WPA2 Enterprise network.
   - `[IDENTITY]`: Your user ID or username provided by the school.
   - `[PASSWORD]`: Your network password or authentication token.

   Example:

   ```bash
   nmcli connection add \
     type wifi \
     connection.id 'MySchoolNetwork' \
     wifi.ssid 'MySchoolWiFi' \
     wifi.mode infrastructure \
     wifi-sec.key-mgmt wpa-eap \
     802-1x.eap peap \
     802-1x.identity 'john.doe@example.com' \
     802-1x.phase2-auth mschapv2 \
     802-1x.password 'mypassword123'
   ```

   This command creates a new Wi-Fi connection profile with the specified settings. Make sure to keep the backslashes ("\") at the end of each line if you copy the command.

## How To Option 2

1. Write and save the  file using 'skeleton' file in this project root as base, then run the following commands:

   ```bash
   chown root /etc/NetworkManager/system-connections/[CONNECTION-NAME] && \
   chmod 600 /etc/NetworkManager/system-connections/[CONNECTION-NAME]
   ```

4. Restart the NetworkManager service with the following command:

   ```bash
   sudo systemctl restart NetworkManager
   ```

   This restarts the NetworkManager service to apply the new configuration. After restarting, you should have a functioning Wi-Fi connection on the WPA2-Enterprise network.
```
```

