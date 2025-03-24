# Local Config

This repository contains the files I use in my local configuration to be able to easily replicate it across different computers. It assumes `~/bin` is in the `PATH`.



## Usage

Run the following command to get a symlink to all the files in their corresponding location:
```sh
make
```

## List of software to install

* `slock`: OS lock.
* `xautolock`: automatically lock the screen when idle.
* `autocutsel`: for copy from the browser pasting with 3 finger gesture or mouse middle click.
* `pavucontrol`: manage audio settings.
* `blueman`: manage Bluetooth devices.
* `xclip`: several clipboard functionalities.
* `scrot`: for screenshot functionality in DWM.

This programs can all be installed together with the following command:

```sh
apt-get install slock xautolock autocutsel pavucontrol blueman xclip scrot
```

## License

[GPL-3](LICENSE)
