clear all; clc; close all;

%% TAKE THE PATH OF THE IMAGE AS INPUT AND READ THE IMAGE
b = input('     Enter the complete path of image\n     ','s');
i=imread(b);

%% IMAGE PROCESSING
g=rgb2gray(i);          % CONVERTING THE READ IMAGE TO GRAYSCALE                 
g=imadjust(g);          % ADJUSTING THE CONTRAST       
b=~im2bw(g,0.4);        % CONVERTING TO A INVERTED BINARY IMAGE, LIMIT PARAMETER CHOSEN AS 0.4

%% EXTRACTING ALL THE CONNECTED COMPONENTS FROM BINARY IMAGE

CC= bwconncomp(b);

mymean=0;              %FINDING THE MEAN AREA OF ALL CONNECTED COMPONENTS
for i=1:CC.NumObjects,
     mymean=mymean +numel(CC.PixelIdxList{1,i});
end;

mymean=mymean/(5*CC.NumObjects);
                             
                       %REMOVING ALL THE CONNECTED COMPONENTS WITH AREA LESS
                       %1/5TH OF THE MEAN AREA

for i=1:CC.NumObjects
    if (numel(CC.PixelIdxList{1,i})<=mymean);
        
        for j=1:numel(CC.PixelIdxList{1,i})
            b(CC.PixelIdxList{1, i}(j))=0;
        end;
    
    end;
end;

%%BOUNDING BOX AND SORTING OF CONNECTED COMPONENTS BY LINE AND WORDS

RP=regionprops(b); %GIVES THE BOUNDING BOX OF EACH CONN.COMPONENTS
Bboxes = {RP(:).BoundingBox}; 

n=size(RP);
num=n(1);
BB=zeros(num,4); % CREATING A MATRIX OF BOUNDING BOX OF CONN.COMPONENTS

for i=1:num,
    BB(i,:)=Bboxes{i};
end;

[BB, line]=sortline(BB, num); %RETURNS THE SORTED MATRIX BB AND
                              %LINE MATRIX: WHERE EACH LINE STARTS AND ENDS
    
