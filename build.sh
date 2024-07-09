#!/usr/bin/env zsh

ZMK_CONFIG_PATH="/Users/zeljkobekcic/Projects/Private/temper-zmk-config/config"
ZMK_EXTRA_MODULES_PATH="/Users/zeljkobekcic/Projects/Private/temper-zmk-config"
OUTPUT_DIRECTORY="/Users/zeljkobekcic/Projects/Private/temper-zmk-config/outputs/"

rm -rf "$OUTPUT_DIRECTORY"
mkdir -p "$OUTPUT_DIRECTORY"

(
	cd ~/Projects/Private/zmk
	source .venv/bin/activate
	cd app
	west build -d build/temper_left -b nice_nano_v2 --pristine -- -DZMK_CONFIG="$ZMK_CONFIG_PATH" -DSHIELD=temper_left -DZMK_EXTRA_MODULES="$ZMK_EXTRA_MODULES_PATH"
	west build -d build/temper_right -b nice_nano_v2 --pristine -- -DZMK_CONFIG="$ZMK_CONFIG_PATH" -DSHIELD=temper_right -DZMK_EXTRA_MODULES="$ZMK_EXTRA_MODULES_PATH"
	west build -d build/temper_dongle -b nice_nano_v2 --pristine -- -DZMK_CONFIG="$ZMK_CONFIG_PATH" -DSHIELD=temper_dongle -DZMK_EXTRA_MODULES="$ZMK_EXTRA_MODULES_PATH"
	deactivate

	cp build/temper_dongle/zephyr/zmk.uf2 "$OUTPUT_DIRECTORY/temper_dongle.uf2"
	cp build/temper_right/zephyr/zmk.uf2 "$OUTPUT_DIRECTORY/temper_right.uf2"
	cp build/temper_left/zephyr/zmk.uf2 "$OUTPUT_DIRECTORY/temper_left.uf2"

	rm -rf build
)
