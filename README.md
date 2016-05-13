# Arduino IDE project skeleton

If you like Arduino, but also like to use your text editor of choice and you're not afraid of the command line, this project is for you! Like many others I started programming micro-controllers using the Arduino IDE. But after a while I started to dislike the default editor. For a while I used a arduino Makefile to compile my code. Until recently I found out that the current version of the Arduino IDE also has a cli interface

# Dependencies

* Arduino IDE
* minicom     (optional)
* git         (optional)

# Usage

To get started clone this repro or download zip and extract on your local machine. To clone using git:

```shell
$ git clone https://github.com/bremme/arduino-project-skeleton
```

Open the `arduino-config.sh` file and set the location of your Arduino binairy, serial port, serial speed, Arduino board and optionally a serial monitor program and editor.


# Structure

```shell
.
├── doc                 Aditional documentation file
├── libraries           Arduino library files
├── main                Main sketch file
│   └── main.ino        Main Arduino sketch
├── LICENCE.txt         Licence file
├── arduino-config.sh   Arduino config file
└── README.md           Project README file
```
