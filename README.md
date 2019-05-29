# GM1356 for Linux [WIP]

## Description
This driver was written for **Digital Sound Level Meter** with USB (type **GM1356**) serial number: `HA:1303162` ordered from China via Aliexpress. My sonometer works with **SoundLab** `Sound Level Meter v. 1.0.0.20, build 2016-07-20` delivered by [Benetech Poland](https://benetech-poland.pl/) (thank you very much for this). I was trying to run it with SoundLab downloaded from Bogen website, but it couldn't connect to the device. It means my driver may not work with some GM1356 devices.

## Protocol
I used Wireshark with USBPcap to sniff communication between my device and SoundLab on Windows in order to understend the protocol. Protocol is described in [PROTOCOL.md](PROTOCOL.md).

## Supported functionalities
* receiving real time data with `sound level value`, `A/C filter`, `max mode`, `slow/fast mode` and `measured range`
* changing `A/C filter`, `max mode`, `slow/fast mode` and `measured range`

## Unsupported functionalities
* importing recorded data
