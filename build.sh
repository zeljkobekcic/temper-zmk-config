#!/usr/bin/env zsh

ZMK_APP_PATH="$HOME/Projects/Private/zmk/app"
ZMK_CONFIG_ROOT_PATH="$HOME/Projects/Private/temper-zmk-config"
OUTPUT_DIRECTORY="$HOME/Projects/Private/temper-zmk-config/outputs/"

rm -rf "$OUTPUT_DIRECTORY"
mkdir -p "$OUTPUT_DIRECTORY"

cd "$ZMK_APP_PATH"
source ../.venv/bin/activate

yq '.include | map(.board + " " + .shield)' "$ZMK_CONFIG_ROOT_PATH/build.yaml" | while read line; do
	board=$(echo $line | awk '{ print $2 }')
	shield=$(echo $line | awk '{ print $3 }')

	west build -d "build/$shield-$board" -b $board --pristine -- -DZMK_CONFIG="$ZMK_CONFIG_ROOT_PATH/config" -DSHIELD=$shield 
	cp "build/$shield-$board/zephyr/zmk.uf2" "$OUTPUT_DIRECTORY/$shield-$board.uf2"
done

deactivate

rm -rf build

cd -
