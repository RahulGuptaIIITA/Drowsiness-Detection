# Drowsiness-Detection
Project Developed in MATLAB for detecting drowsiness while driving.
Intelligent Alarm System for detecting driver's Fatigue based on Video Sequences

Current code base has two files
a) new.m
b) HeadLowering.m

a) new.m
It contains code for detecting eyes and mouth in video.

Steps involved :- 
1) Firstly i'd detected face using 'Voila Jones' algorithm which MATLAB provides itself.
2) After detecting face in frame, I made use of the facial symmetry. On the basis of some measurements , I'd cut out mouth and eyes from the image.
3) Converted mouth and eyes image into binary image .
4) On the basis of pixels count , i decided if the eyes is closed or not (blinking if black pixels counts reduces) and mouth is open or not (yawning if black pixels count increases)


b) HeadLowering.m
It contains code for monitoring head movement.

Steps Involved :-
1) Firstly detect face in the frame using 'Voila Jones'
2) Converted image into YCbCr format.
3) Used Skin Segmentation to find out count of pixels whose value lies in the range of defined skin color range. 
4) On the basis of count decided is the head is bent or not  ( if head is bent then skin pixels will reduce in large no) 

