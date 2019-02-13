# nrf52840-gcc-build-scripts
nrf52840 firmware build script using cross arm gcc

Our recipe is almost same with nordic semi's tutorial([Development with GCC and Eclipse](https://devzone.nordicsemi.com/tutorials/7/)) except OpenOCD support

0. install [GCC ARM Embedded toolchain or GNU](https://launchpad.net/gcc-arm-embedded) or [MCU Eclipse ARM Embedded GCC](https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc/releases):

   If your host is MS Window, install [MSYS2](http://www.msys2.org/), or OLD [core utilities](http://gnuwin32.sourceforge.net/packages/coreutils.htm) and [GNU Make](http://gnuwin32.sourceforge.net/packages/make.htm) by GnuWin.

1. download and extract nRF5-SDK 15+ (with s140 softdevice)

2. copy board specific files(in boards directory) to nRF5-SDK
   For Linux,
```shell
    $ cp boards/* {nRF5-SDK directory}/components/boards/
```

3. download firmware uploader/debugging program (nrfjprog/j-link, openocd, or pyocd) as to your debugger (J-Link, STLink-v2, cmsis-dap)

4. install tools/mergehex program as to your host

   For Linux,
```shell
    $ sudo cp tools/mergehex/Linux-i386/mergehex /usr/local/bin
```
   For MS Window, install [nRF5x Command Line Tools](https://www.nordicsemi.com/Software-and-Tools/Development-Tools/nRF5-Command-Line-Tools)

5. create your project

6. copy .cproject, .project, Makefile and linker script file (.ld) to your project directory

7. modify Makefile variables (BOARD OUTPUT_FILENAME, SDT_PATH, LINKER_SCRIPT, FLASHER, C_SOURCE_FILES, INC_PATHS, etc.) in order to suit your project

8. make

9. make erase

10. make flash or make flash_all

11. (optional) install eclipse IDE with CDT and [GNU MCU Eclipse](https://gnu-mcu-eclipse.github.io) plug-in.

12. (optional) import your project onto eclipse and build/upload/debug your application
