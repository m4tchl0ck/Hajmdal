# Read the plates
https://github.com/openalpr/openalpr/wiki/Compilation-instructions-(Ubuntu-Linux)

```
sudo apt-get install -y openalpr openalpr-daemon openalpr-utils libopenalpr-dev
```

Download example photo with car and plates
```
wget http://plates.openalpr.com/h786poj.jpg
```

Get plate number from picture
``` bash
$ alpr -c eu h786poj.jpg
plate0: 10 results
    - H786P0J    confidence: 88.4793
    - HC786P0J   confidence: 85.1835
    - H3786P0J   confidence: 84.8737
    - HG786P0J   confidence: 84.8356
    - HH786P0J   confidence: 83.8431
    - H786PDJ    confidence: 82.4207
    - H786POJ    confidence: 82.3353
    - MH786P0J   confidence: 82.1529
    - H786PQJ    confidence: 81.9309
    - UH786P0J   confidence: 81.8661
```

Use regex to take only plate numbers
``` bash
$ alpr -c eu h786poj.jpg | grep -Po '(?<=\s-\s)[\w\d]+(?=\s+confidence:)'
H786P0J
HC786P0J
H3786P0J
HG786P0J
HH786P0J
H786PDJ
H786POJ
MH786P0J
H786PQJ
UH786P0J
```
