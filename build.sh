ZMK_APP_PATH="$HOME/Projects/Private/zmk/app"
ZMK_CONFIG_PATH="$HOME/Projects/Private/temper-zmk-config/config"
ZMK_EXTRA_MODULES_PATH="$HOME/Projects/Private/temper-zmk-config"
OUTPUT_DIRECTORY="$HOME/Projects/Private/temper-zmk-config/outputs/"

rm -rf "$OUTPUT_DIRECTORY"
mkdir -p "$OUTPUT_DIRECTORY"

cd "$ZMK_APP_PATH"
source ../.venv/bin/activate

# format to json lines then read ech json object per loop iterationn
yq -o=json -I=0 '.include[]' "$ZMK_EXTRA_MODULES_PATH/build.yaml" | while read line; do
	board=$(echo $line | jq -r '.board')
	shield=$(echo $line | jq -r '.shield')

	west build -d "build/$shield-$board" -b $board --pristine -- -DZMK_CONFIG="$ZMK_CONFIG_PATH" -DSHIELD=$shield # -DZMK_EXTRA_MODULES="$ZMK_EXTRA_MODULES_PATH"
	cp "build/$shield-$board/zephyr/zmk.uf2" "$OUTPUT_DIRECTORY/$shield-$board.uf2"
done

deactivate

rm -rf build

cd -
