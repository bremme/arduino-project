#!/bin/sh
################################################################################
# Arduino CLI config script                                                     # author: Bram Harmsen
# date:   19-10-2016
# License:GNU GPLv3                                                             # version:1.1
#
# This script makes it easier to compile and upload arduino code using the Arduino IDE CLI interface (https://github.com/arduino/Arduino/blob/master/build/shared/manpage.adoc)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# ##############################################################################


# Your main sketch
ARDUINO_SKETCH_FILE="main.ino"
ARDUINO_SKETCH="$PWD/main/$ARDUINO_SKETCH_FILE"

################################################################################
# ARDUINO - Configure Arduino binairy and options
################################################################################
ARDUINO_BIN=$HOME/bin/arduino                   # Arduino binairy location
ARDUINO_OPTIONS="--verbose"

################################################################################
# SERIAL PORT - Select your Arduino serial port
###############################################################################
ARDUINO_PORT="/dev/ttyUSB0"                     # Arduino serial port
ARDUINO_BAUD=9600                               # Arduino baud rate

################################################################################
# BOARD CONFIG - Select the board you are using                                #
################################################################################

# due programmign port config #################################################
# ARDUINO_ARCH=sam
# ARDUINO_BOARD=arduino_due_x_dbg

# mega 2560 config #############################################################
ARDUINO_PACKAGE=arduino
ARDUINO_ARCH="avr"
ARDUINO_BOARD="mega:cpu=atmega2560"

# uno config ##################################################################
# ARDUINO_PACKAGE=arduino
# ARDUINO_ARCH="avr"
# ARDUINO_BOARD="uno"

# nano 328 config ##############################################################
# ARDUINO_PACKAGE=arduino
# ARDUINO_ARCH="avr"
# ARDUINO_BOARD="nano:cpu=atmega328"

################################################################################
# SERIAL MONITOR - Configure serial monitor                                    #
################################################################################
# cat as serial monitor (very basic)
ARDUINO_MONITOR_BIN=/bin/cat
ARDUINO_MONITOR_OPTIONS=$ARDUINO_PORT

# minicom as serial monitor (have to install)
# ARDUINO_MONITOR_BIN=minicom
# ARDUINO_MONITOR_OPTIONS="-D $ARDUINO_PORT -b $ARDUINO_BAUD --color=on --statline --noinit"

################################################################################
# EDITOR - Configure your editor                                               #
################################################################################

# ARDUINO_EDIT_BIN=nano
# ARDUINO_EDIT_OPTIONS=""

ARDUINO_EDIT_BIN=atom
ARDUINO_EDIT_OPTIONS=""

# DONT CHANGE THIS #############################################################

if [[ -n "$PS1_BAK" ]]; then
  # reset PS1
  PS1=$PS1_BAK
else
  # backup PS1
  PS1_BAK=$PS1
fi

ARDUINO_PROMPT_TEXT="(Arduino $ARDUINO_BOARD $ARDUINO_PORT $ARDUINO_SKETCH_FILE)"
NEWLINE=$'\n';

case "$SHELL" in
  *zsh* )
    # echo "Setup zsh prompt"
    ARDUINO_PROMPT="%{$fg_bold[blue]%}$ARDUINO_PROMPT_TEXT%{$reset_color%}"
    PS1="$ARDUINO_PROMPT $NEWLINE $PS1";
    ;;
  *bash*)
    # echo "Bash";
    ARDUINO_PROMPT="\e[1;37m\e[1;32m$ARDUINO_PROMPT_TEXT\e[1;37m"
    PS1="$ARDUINO_PROMPT $NEWLINE $PS1";
    ;;
esac

ARDUINO_SKETCHBOOKPATH=$PWD
ARDUINO_BUILD_PATH=$PWD/build

# Export variables
export ARDUINO_SKETCH ARDUINO_SKETCHBOOKPATH ARDUINO_PACKAGE ARDUINO_BIN ARDUINO_BUILD_PATH ARDUINO_OPTIONS ARDUINO_ARCH ARDUINO_BOARD ARDUINO_PORT ARDUINO_BAUD PS1_BAK PS1

# create aliases to verify, upload and monitor
alias verify='$ARDUINO_BIN --verify --board $ARDUINO_PACKAGE:$ARDUINO_ARCH:$ARDUINO_BOARD --port $ARDUINO_PORT --pref sketchbook.path="$ARDUINO_SKETCHBOOKPATH" --pref build.path="$ARDUINO_BUILD_PATH" $ARDUINO_OPTIONS "$ARDUINO_SKETCH"'

alias upload='$ARDUINO_BIN --upload --board $ARDUINO_PACKAGE:$ARDUINO_ARCH:$ARDUINO_BOARD --port $ARDUINO_PORT --pref sketchbook.path="$ARDUINO_SKETCHBOOKPATH" --pref build.path="$ARDUINO_BUILD_PATH" $ARDUINO_OPTIONS "$ARDUINO_SKETCH"'

alias monitor='"$ARDUINO_MONITOR_BIN" "$ARDUINO_MONITOR_OPTIONS"'

alias code='"$ARDUINO_EDIT_BIN" "$ARDUINO_EDIT_OPTIONS" "$PWD"'

alias reload='source $ARDUINO_SKETCHBOOKPATH/arduino-config.sh'

alias deactivate='_deactivate'

echo "Entering Arduino development environent"
echo ""
echo "To make working with arduino easy the following command are available:"
echo ""
echo "verify        Verify a sketch (compilation)"
echo "upload        Upload a sketch"
echo "monitor       Monitor the serial port"
echo "code          Open your text editor"
echo "reload        Reload this file"
echo "deactive      Exit the environment"
echo ""

function _deactivate() {
  echo 'Removing aliases...'
  unalias verify upload monitor code reload deactivate
  echo 'Removing environmental variables...'
  PS1=$PS1_BAK
  unset ARDUINO_SKETCH ARDUINO_SKETCHBOOKPATH ARDUINO_PACKAGE ARDUINO_BIN ARDUINO_BUILD_PATH ARDUINO_OPTIONS ARDUINO_ARCH ARDUINO_BOARD ARDUINO_PORT ARDUINO_BAUD PS1_BAK
  echo 'Thanks for using the Arduino cli environent'
  unset -f _deactivate
}
