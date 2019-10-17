# GM1356 for Linux

## Description
This driver was written for **Digital Sound Level Meter** with USB (type **GM1356**) serial number: `HA:1303162` ordered from China via Aliexpress. My sonometer works with **SoundLab** `Sound Level Meter v. 1.0.0.20, build 2016-07-20` delivered by [Benetech Poland](https://benetech-poland.pl/) (thank you very much for this). I was trying to run it with SoundLab downloaded from Bogen website, but it couldn't connect to the device. It means my driver may not work with some GM1356 devices.

![Benetech GM1356](https://benetech-poland.pl/844-large_default/sonometr-benetech-gm1356-decybelomierz-z-interfejsem-usb.jpg)

## Installation
First make sure you have `ruby` interpreter installed. Then run:

```gem install gm1356```

Now make sure that `users` have access to your device. In my case I had to create `/etc/udev/rules.d/90-usbpermission.rules` with such content:

```SUBSYSTEMS=="usb",ATTRS{idProduct}=="74e3",ATTRS{idVendor}=="64bd",GROUP="users",MODE="0666"```

Then run:

```sudo udevadm control --reload```

And after all reconnect your device if it was already connected.

## Usage
If you want to print real time data from your sonometer, run:

```gm1356```

For more options:

```gm1356 --help```

## Protocol
I used Wireshark with USBPcap to sniff communication between my device and SoundLab on Windows in order to understend the protocol. Protocol is described in [PROTOCOL.md](PROTOCOL.md).

## Supported functionalities
* receiving real time data with `sound level value`, `A/C filter`, `max mode`, `slow/fast mode` and `measured range`
* changing `A/C filter`, `max mode`, `slow/fast mode` and `measured range`

## Unsupported functionalities
* importing recorded data
