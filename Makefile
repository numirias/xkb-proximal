DEST?=$(DISPLAY)
xkbdst=/usr/share/X11/xkb
xkbsrc=./xkb
kbargs=-rules nius -layout de+nius -option custom:minila -option custom:minila,caps:escape,terminate:ctrl_alt_bksp

build/keymap.xkb:
	setxkbmap $(kbargs) -print > build/keymap.xkb
load: build/keymap.xkb
	xkbcomp -Ixkb/ build/keymap.xkb "$(DEST)"
install:
	cp $(xkbsrc)/rules/nius $(xkbdst)/rules/
	cp $(xkbsrc)/rules/nius.lst $(xkbdst)/rules/
	cp $(xkbsrc)/symbols/nius $(xkbdst)/symbols/
	cp $(xkbsrc)/keycodes/minila $(xkbdst)/keycodes/
persist:
	cp keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
build/nius.map:
	ckbcomp -Ixkb/ $(kbargs) -compact nius > build/nius.map
console: build/nius.map
install-console: console
	cp build/nius.map /usr/share/kbd/keymaps/
persist-console:
	localectl --no-convert set-keymap nius
clean:
	rm -rf build/*
