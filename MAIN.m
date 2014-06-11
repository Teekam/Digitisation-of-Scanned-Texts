clc,clear all;
  

%% TAKE THE PATH OF THE IMAGE AS INPUT AND READ THE IMAGE
b = input(' Enter the complete path of image\n ','s');
i=imread(b);

%% IMAGE PROCESSING
 g=rgb2gray(i);          % CONVERTING THE READ IMAGE TO GRAYSCALE                 
  img=imadjust(g);          % ADJUSTING THE CONTRAST       
 img=~im2bw(im,0.8);        % CONVERTING TO A INVERTED BINARY IMAGE, LIMIT PARAMETER CHOSEN AS 0.8

%% EXTRACTING ALL THE CONNECTED COMPONENTS FROM BINARY IMAGE

CC= bwconncomp(img);
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
            img(CC.PixelIdxList{1, i}(j))=0;
        end;
    
    end;
end;

%%BOUNDING BOX AND SORTING OF CONNECTED COMPONENTS BY LINE AND WORDS

RP=regionprops(img); %GIVES THE BOUNDING BOX OF EACH CONN.COMPONENTS
Bboxes = {RP(:).BoundingBox}; 

n=size(RP);
num=n(1);
BB=zeros(num,4); % CREATING A MATRIX OF BOUNDING BOX OF CONN.COMPONENTS

 for i=1:num,
     BB(i,:)=Bboxes{i};
 end;

  [BB, line]=sortline(BB, num); %RETURNS THE SORTED MATRIX BB AND
                              %LINE MATRIX: WHERE EACH LINE STARTS AND ENDS


    
    for j=1:num,
    temp=imcrop(img, BB(j,:));
     temp=bresize(temp);
     
     dataset(:,j)=temp(1:end);
    
end;
%% Creates the target matrix for training
  tarmat=zeros(66,44*66);
for i=1:66
    for j=1:44
        tarmat(i,44*(i-1)+j)=1;
    end
end   
    
    
    
    
