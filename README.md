# Intelligent System to Prevent Accidents By Analyzing Facial Expression And Head Movements
The prime objective of this project was to use technology to curb the major problems in the world. According to the statistics, drowsy driving alone causes over 1,550 fatal accidents and 40,000 non-fatal accidents annually in the United States and a similar scenario persists across the globe.

The project is developed in MATLAB for detecting drowsiness while driving. On detecting the signs of fatigue or distraction from random sources around, it would generate an alarm to notify driver.

Current code base has two files
a) new.m
b) HeadLowering.m

a) new.m
It contains code for detecting eyes and mouth in video, process the ROI to extract features for taking the final decission.

Steps involved :- 
1) Firstly, used 'Voila Jones' algorithm for detecting face in the video frames.
2) Rather than extracting mouth and eyes from this detected face, we decided to use the concept of 'Facial Symmetry' to cut out mouth and eyes from the image.
3) Once we have the desired components(eyes, mouth), processed the image; performed 'Binarization', 'Dialation' and 'Erosion'.
4) To figure out if the eyes were closed or mouth is opened, wrote an algorithm to detect 'Blinking' and 'Yawning'. Took the change in pixel numbers and concentration in a region of consecutive frames into consideration for taking the final decision. 


b) HeadLowering.m
It contains code for monitoring head movement.

Steps Involved :-
1) Firstly, used 'Voila Jones' algorithm for detecting face in each frames.
2) Used 'Color Space' conversion technique, converted image from RGB into YCbCr format.
3) Used 'Skin Segmentation' to find out the exposed face (facing forward). Calculated the percentage of skin using the defined skin color range.  
4) On the basis of percentage of skin exposed, decided if the head is bent or facing sideways.
