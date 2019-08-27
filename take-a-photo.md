# Take a photo
Device [Microsoft LifeCam HD-3000](https://www.microsoft.com/accessories/pl-pl/d/lifecam-hd-3000).

After connecting the camera to raspberrypi we run `dmesc`
```
[81789.123025] usb 1-1.5: USB disconnect, device number 5
[81793.257262] usb 1-1.5: new high-speed USB device number 10 using dwc_otg
[81793.403714] usb 1-1.5: New USB device found, idVendor=045e, idProduct=0779
[81793.403734] usb 1-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[81793.403748] usb 1-1.5: Product: Microsoft® LifeCam HD-3000
[81793.403759] usb 1-1.5: Manufacturer: Microsoft
[81793.406671] uvcvideo: Found UVC 1.00 device Microsoft® LifeCam HD-3000 (045e:0779)
[81793.420401] uvcvideo 1-1.5:1.0: Entity type for entity Extension 5 was not initialized!
[81793.420428] uvcvideo 1-1.5:1.0: Entity type for entity Processing 4 was not initialized!
[81793.420442] uvcvideo 1-1.5:1.0: Entity type for entity Selector 3 was not initialized!
[81793.420454] uvcvideo 1-1.5:1.0: Entity type for entity Camera 1 was not initialized!
[81793.421052] input: Microsoft® LifeCam HD-3000: Mi as /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.5/1-1.5:1.0/input/input1
```

The camera has been detected and the device is available as `/dev/video0`.

From the first [result](https://www.raspberrypi.org/documentation/usage/webcams/) in [google](http://lmgtfy.com/?q=raspberry+pi+usb+camera) we will learn how to install the necessary application (`sudo apt-get install fswebcam`) and how to use the application to take photos.

Quick check
``` 
fswebcam --no-banner --device /dev/video0 ./img.jpg
```