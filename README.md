# Temper ZMK Config

This is my personal ZMK config for the [temper](https://github.com/raeedcho/temper). This repository contains zmk configuration for the Temper keyboard using two microcontrollers and additionally on configuration using a dongle which is connected to your computer via cable.

## How to build locally

1. Setup ZMK for local development first. Follow therfore precisely the documentation: <https://zmk.dev/docs/development/setup/native>
2. Additional requirements: [`yq`](https://mikefarah.gitbook.io/yq)
3. Change the paths in the environment variables in the `build.sh` file to match your paths.
4. Run the script

   ```shell
   ./build.sh
   ```

   This will create a directory called `output` and in there are all the `.uf2` files

5. Flash your microcontrollers with the resulting `.uf2` files

## Extra notes on the dongle part

1. Flash all three microcontrollers with the reset firmware which has been build. All three with the same `.uf2` firmware. More information about this step can be found in the official documentation of ZMK <https://zmk.dev/docs/troubleshooting/connection-issues#acquiring-a-reset-uf2>.
2. Flash all microcontrollers with their respective firmware
3. Turn off bluetooth, plug in the dongle and everything should be working out of the box.
