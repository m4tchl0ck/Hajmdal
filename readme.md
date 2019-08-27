# Hajmdal

The client I work for has a car park for employees and contractors.
The entrance to the parking lot is limited by a barrier, which opens after entering the code on the keyboard.
This solution is not a problem in the summer, but in the winter it gets unpleasant when we have -20 outside and a snowstorm.
In very cold weather, the windows freeze and you have to open the door (brrr it gets cold just by thinking - winter is coming).
A colleague "off the bench" (driving a sports Italian car on F, but old), began to have trouble entering the code.
When he reached the room he said something like:
`It is the 21st century, we work in a company dealing with new technologies, and the parking code must be entered manually`
Wait a minute googling and found [alpr] (https://github.com/openalpr/openalpr) - a ready solution to extract registration numbers from photos.
We have a solution that works on [Raspberry Pi] (https://www.raspberrypi.org/) (I have version 2).
I could use a webcam for USB (actually two - cars come and go :)) - quick question to the IT department and there were 2 old cameras.
Now just implement the simple check of registration numbers from the photo with the database of numbers and put the status on [GPIO] (https://www.raspberrypi.org/documentation/usage/gpio/) when the car can enter / leave the parking lot

## TL; TR;

How to recognize registrations on [Raspberry Pi] (https://www.raspberrypi.org/), check if the registration number is in the file and issue the status on [GPIO] (https://www.raspberrypi.org/documentation/usage / GPIO /)

## To Do

1. Environment configuration
2. We're taking a picture
3. We read the registration from the photo
4. We display the status on GPIO (We open the barrier)
5. Check if the registration is in the file
