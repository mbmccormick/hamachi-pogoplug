# hamachi-pogoplug

Install Hamachi VPN on the PogoPlug USB Device.


## Requirements

The hamachi-pogoplug package has been tested on the Seagate DockStar Pogoplug device. You will need to obtain SSH access to your networked USB device and have root permissions on the device in order for this package to function properly.


## Installation

Installation for this package is very simple. First, you will need to enable write access to your device. 

    $ mount -o rw,remount /

Next, copy the files in each directory of this package to the corresponding directories on the device.

    $ cp etc /etc
    $ cp root /root
    $ cp sbin /sbin
    $ cp usr /usr
    $ cp var /var

Next, we need to link some of the libraries together and modify permissions.

    $ ln -sf /usr/lib/libcrypto.so.0.9.8 /usr/lib/libcrypto.so.0.9.7
    $ ln -sf /usr/bin/hamachi /usr/bin/hamachi-init
    $ ln -sf /bin/ifconfig /sbin/ifconfig
    $ chmod 755 /usr/bin/hamachi
    $ chmod 700 /sbin/tuncfg

Now we need to prepare our VPN drivers and start Hamachi.

    $ tuncfg
    $ hamachi-init
    $ hamachi start
    $ hamachi login

Lastly, we need to setup our device to enable write access and start Hamachi on boot.

    $ chmod 777 hamachi.sh
    $ echo "/etc/init.d/hamachi.sh start" >> /etc/init.d/rcS


## Usage

After succesful installation, you will be able to use Hamachi on your Pogoplug just like you would with any legacy Linux installation of Hamachi.


## Disclaimer

Use this software at your own risk. While this package has been tested thoroughly, on the above requirements, your mileage may vary. I take no responsibility for any harmful actions this package might cause.


## License

This software, and its dependencies, are distributed free of charge and licensed under the GNU General Public License v3. For more information about this license and the terms of use of this software, please review the LICENSE.txt file.

Not affiliated with Hamachi, LogMeIn, PogoPlug, Seagate, or the developers of the underlying libraries. This license does not apply to the included libraries and packages.
