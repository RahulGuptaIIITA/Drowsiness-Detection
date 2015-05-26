clear all;
clc

%................reading video.....................
obj = VideoReader('C:\Users\RAHUL\Documents\MATLAB\Drowsiness Detection\dbase\specs\s1.mp4','Tag','My reader object');
image = read(obj, 1);
binarization_threshold = 10;
nFrames = obj.NumberOfFrames;
nFrames
rate = obj.FrameRate;
rate



%---------using first frame as refrence------------
FDetect = vision.CascadeObjectDetector;
BB = step(FDetect,image);
face=imcrop(image,BB);
figure,imshow(face);
size1 = size(face,1);
size2 = size(face,2);


%.............Cutting out eyes from the frame................
j = int64(.23*size1);
l = int64(.15*size2);
length = int64(.68*size2);
height = int64(.25*size1);
Eyes = imcrop(face,[l,j,length,height]);
figure,imshow(Eyes);


%.............Cutting out mouth from the frame................
j = int64(.67*size1);
l = int64(.27*size2);
length = int64(.45*size2);
height = int64(.20*size1);
mouth = imcrop(face,[l,j,length,height]);
figure,imshow(mouth);


%..........Working on the eyes refrence frame, converting into different color spaces........
Eyes = rgb2ycbcr(Eyes);
Eyes = rgb2gray(Eyes);
val1  = min(Eyes(:));
val1;
counter1=0;

for i = 1:size(Eyes,1)
    for j = 1:size(Eyes,2)
        if Eyes(i,j) <= val1+binarization_threshold;
            Eyes(i,j) = 0;
            counter1=counter1+1;
        else
            Eyes(i,j) = 255;
        end
    end
end

%figure,imshow(Eyes);
%counter1

%--------------finding percentage of black pixels-----------
eyespercentage = (counter1*100)/(size(Eyes,1)*size(Eyes,2));



%----------working on mouth in refrence frame, converting into different color spaces------------------
mouth = rgb2ycbcr(mouth);
mouth = rgb2gray(mouth);
val1  = min(mouth(:));
val1; 
counter2=0;

for i = 1:size(mouth,1)
    for j = 1:size(mouth,2)
        if mouth(i,j) <= val1+binarization_threshold
            mouth(i,j) = 0;
            counter2=counter2+1;
        else
            mouth(i,j) = 255;
        end
    end
end
%figure, imshow(mouth)
%counter2

%---------------finding percentage of black pixels in mouth------------------
mouthpercentage = (counter2*100)/(size(mouth,1)*size(mouth,2));


%-------------finding mouth and eyes features for the next frames of video--------
thresholdnumberofframes = 25;
initial=2;
final = 2;
counter = 0;
thresholdpercentage = 6;
obj.NumberOfFrames;
array2(obj.NumberOfFrames) = zeros;
array3(int64(obj.NumberOfFrames/15)) = zeros;
for t = 2:1:obj.NumberOfFrames - 1;
    t
    image = read(obj, t);
    %figure,imshow(image);
    FDetect = vision.CascadeObjectDetector;
    BB1 = step(FDetect,image);
    bitlevel1=1;
    bitlevel2=1;
    if size(BB1,1)~= 0 && size(BB1,2) ~= 0
        face=imcrop(image,BB1);
        
        %figure,imshow(face);
        
        j = int64(.23*size1);
        l = int64(.15*size2);
        length = int64(.68*size2);
        height = int64(.25*size1);
        Eyes = imcrop(face,[l,j,length,height]);
        
        %figure,imshow(Eyes);
        
        j = int64(.67*size1);
        l = int64(.27*size2);
        length = int64(.45*size2);
        height = int64(.20*size1);
        mouth = imcrop(face,[l,j,length,height]);
        
        %figure,imshow(mouth);

        Eyes = rgb2ycbcr(Eyes);
        Eyes = rgb2gray(Eyes);
        val1  = min(Eyes(:));
        val1;
        counter1=0;
        for i = 1:size(Eyes,1)
            for j = 1:size(Eyes,2)
                if Eyes(i,j) <= val1+binarization_threshold
                    Eyes(i,j) = 0;
                    counter1=counter1+1;
                else
                    Eyes(i,j) = 255;
                end
            end
        end
        
        figure,imshow(Eyes)
        %counter1
        
        %-----------finding percentage of black pixels-------------%
        eyespercentage1 = (counter1*100)/(size(Eyes,1)*size(Eyes,2));
        if eyespercentage1 > eyespercentage-thresholdpercentage && eyespercentage1 < eyespercentage+thresholdpercentage
            bitlevel1=0;
        end;
        
        
        %-----------working on mouth in frame-----------------%
        mouth = rgb2ycbcr(mouth);
        mouth = rgb2gray(mouth);
        val1  = min(mouth(:));
        val1; 
        counter2=0;
        for i = 1:size(mouth,1)
            for j = 1:size(mouth,2)
                if mouth(i,j) <= val1+binarization_threshold
                    mouth(i,j) = 0;
                    counter2=counter2+1;
                else
                    mouth(i,j) = 255;
                end
            end
        end
        %figure,imshow(mouth)
    
        
        %----------finding black pixels in mouth----------%
        mouthpercentage1 = (counter2*100)/(size(mouth,1)*size(mouth,2));
        if mouthpercentage1 > mouthpercentage-thresholdpercentage && mouthpercentage1 < mouthpercentage+thresholdpercentage
            bitlevel2=0;
        end;
    end;

    if bitlevel1 == 0 && bitlevel2 == 0
        bitlevel = 0;
    else
        bitlevel = 1;
    end;

    array(t) = bitlevel;

    if bitlevel == 1
        counter = counter + 1;
    end;

    if t-initial >= 30
        if counter >= 25
            'warning';
            array2(t) = 1;
        end;
        if array(initial) == 1
            counter = counter-1;
        end;
        initial = initial + 1;
    end;
    if mod(t,15) == 0
        c = 0;
        for i = t-15+1:1:t
            if array2(i) == 1
                c = c + 1;
            end;
        end;
        if c >= 5
            'generate warning'
            int64(t/rate)
        end;
    end;
end;