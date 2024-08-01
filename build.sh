ZMK_APP_PATH="$HOME/Projects/Private/zmk/app"
ZMK_CONFIG_ROOT_PATH="$HOME/Projects/Private/temper-zmk-config"
OUTPUT_DIRECTORY="$ZMK_CONFIG_ROOT_PATH/outputs/"

rm -rf "$OUTPUT_DIRECTORY"
mkdir -p "$OUTPUT_DIRECTORY"

(
	cd "$ZMK_APP_PATH"
	source ../.venv/bin/activate

	# format to json lines then read ech json object per loop iterationn
	yq -o=json -I=0 '.include[]' "$ZMK_CONFIG_ROOT_PATH/build.yaml" | while read -r line; do
		board=$(echo "$line" | yq -p=json '.board')
		shield=$(echo "$line" | yq -p=json '.shield')

		west build -d "build/$shield-$board" -b "$board" --pristine -- -DZMK_CONFIG="$ZMK_CONFIG_ROOT_PATH/config" -DSHIELD="$shield" > "$OUTPUT_DIRECTORY/$shield-$board.log"

		cp "build/$shield-$board/zephyr/zmk.uf2" "$OUTPUT_DIRECTORY/$shield-$board.uf2"
	done

	deactivate

	rm -rf build
)
