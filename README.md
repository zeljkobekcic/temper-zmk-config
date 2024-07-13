# Temper ZMK Config

This is my personal ZMK config for the [temper](https://github.com/raeedcho/temper).

## Installing

1. Flash all three microcontrollers with the reset firmware which has been build. All three with the same `.uf2` firmware.
2. Flash all microcontrollers with their respective firmware
3. Turn off bluetooth, plug in the dongle and everything should be working out of the box.

## Building locally

Change the paths in the environment variables in the `.build.sh`, then run it.

```shell
./build.sh
```

This will create a directory called `output` and in there are all the `.uf2` files
