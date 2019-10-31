#! /bin/bash

devName="\"LAZURITE mini series\""
program="bin/test920j.bin"
kernel="/lib/modules/`uname -r`"

echo "devName: "$devName
echo "program: "$program
echo "kernel: "$kernel

echo "######## load program #######"
sudo rmmod ftdi_sio
sudo rmmod usbserial
cmd="sudo ./lib/cpp/bootmode/bootmode $devName"
eval $cmd
sudo insmod $kernel"/kernel/drivers/usb/serial/usbserial.ko"
sudo insmod $kernel"/kernel/drivers/usb/serial/ftdi_sio.ko"
cmd="sudo stty -F /dev/ttyUSB0 115200"
eval $cmd
cmd="sudo sx -b $program > /dev/ttyUSB0 < /dev/ttyUSB0"
eval $cmd
sudo rmmod ftdi_sio
sudo rmmod usbserial
sleep 1

echo "######## reset #######"
cmd="sudo ./lib/cpp/reset/reset $devName"
eval $cmd
sudo insmod $kernel/kernel/drivers/usb/serial/usbserial.ko
sudo insmod $kernel/kernel/drivers/usb/serial/ftdi_sio.ko

exit
