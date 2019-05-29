# GM1356 digital sound level meter USB protocol description

## Interface description

Interface is recognised as a **HID** with **two endpoints**. One *in* and one **out**. Both work via **URB interruptions** with **8 bytes packet data length**.

## Ask for current state

To ask for current state, send `URB_INTERRUPT out` to endpoint **2** with capture data `b35902fb00000000`. Then you will receive `URB_INTERRUPT in` from endpoint **1** with data described below.

NOPE, this message for getting current state change. Now I have `b331eb4d00000000`. So probably 3 bytes are dynamic. I have to figure out why and where do they come from. It's unique for each SoundLab instance. It's not dependent on connecting / disconnecting device and reconnecting it to other ports. It looks that SoundLab doesn't send it to the device before, so it may be irrelevant.

## Decode current state

`URB_INTERRUPT in` have leftover capture data with this structure:
`[value:16bits][settings:4bits][range:4bits][unknown:40bits]` - 64bits

### Decode sound level `value`
Convert 16bits to decimal, then add point before last digit.

### Decode `settings`
Settings have this structure:
`[unused:1bit][slow/fast mode:1bit][max mode:1bit][a/c filter:1bit]` - 4 bits

```
a, not max, slow  |   0
c, not max, slow  |   1
a, max, slow      |   2
c, max, slow      |   3
a, not max, fast  |   4
c, not max, fast  |   5
a, max, fast      |   6
c, max, fast      |   7
```

### Decode `range`
Convert 4bits to decimal.

```
30-130  |   0
30-60   |   1
50-100  |   2
60-110  |   3
80-130  |   4
```

### Example
#### data:
`0292749b90ddc0ff`
#### meaning:
 * `value`: 
   * `0292` is `658` decimal, add point before last digit and it is `65.8`dB
 * `settings`:
   * `7` is `0111` binary, so it is `fast mode`, `max mode`, `filter c` 
 * `range`:
   * `4` means `80-130`dB range

## Change settings and range

To change settings sent `INTERRUPT out` to endpoint *2* with such format:

### Data format
`56[settings:4bits][range:4bits]000000000000`

`settings` and `range` are the same as described in previous section.

### Example
#### data:
`5621000000000000`
#### meaning:
Set state to `a filter`, `max mode`, `slow mode` with `30-60`dB range.
