# Open gate

https://www.raspberrypi.org/documentation/usage/gpio/

### How to manipulate GPIO from bash

```bash
echo 17 > /sys/class/gpio/gpio17/export
```

```bash
echo "out" > /sys/class/gpio/gpio17/direction
```
```bash
echo "1" > /sys/class/gpio/gpio17/value
```
```bash
echo "0" > /sys/class/gpio/gpio17/value
```

### Additional tool for GPIO on raspberry pi

http://wiringpi.com

sudo apt-get install git-core
git clone git://git.drogon.net/wiringPi
cd wiringPi
./build
