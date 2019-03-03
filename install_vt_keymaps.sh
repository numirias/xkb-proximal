#!/bin/bash

set -e

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CONFIG="/etc/vconsole.conf"
BUILD="$HERE/build"
KEYMAP="$BUILD/pax.map"


main() {
    echo "Building keymap..."
    mkdir -p $BUILD
    ckbcomp -I$HERE -symbols "pax" -compact $HERE/keymap.xkb > $KEYMAP

    echo "Copying keymap to /usr/share/kbd/keymaps ..."
    cp $KEYMAP /usr/share/kbd/keymaps/

    echo "Writing to $CONFIG ..."
    touch $CONFIG
    # Comment out old keymap declarations
    sed -i 's/^KEYMAP=/# KEYMAP=/' $CONFIG
    echo "KEYMAP=pax" >> $CONFIG
}

main "$@"
