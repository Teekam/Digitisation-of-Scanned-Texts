dataset=zeros(1024,44*66);   

currfile=[ '0' '1' '.' 'p' 'n' 'g'];

for loop=1:66,


  l=mod(loop,10);
k=floor(loop/10);
     
 currfile=[ 48+k  48+l  '.' 'p' 'n' 'g'];  

%% TAKE THE PATH OF THE IMAGE AS INPUT AND READ THE IMAGE
b = currfile;

img=imread(b);

%% IMAGE PROCESSING
% g=rgb2gray(i);          % CONVERTING THE READ IMAGE TO GRAYSCALE                 
%  img=imadjust(g);          % ADJUSTING THE CONTRAST       
 img=~im2bw(img,0.8);        % CONVERTING TO A INVERTED BINARY IMAGE, LIMIT PARAMETER CHOSEN AS 0.8

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
%        if(num~=44)                       %LINE MATRIX: WHERE EACH LINE STARTS AND ENDS
% num,loop
%        end;
    
    for j=1:44,
    temp=imcrop(img, BB(j,:));
     temp=bresize(temp);
     
     dataset(:,44*(loop-1)+j)=temp(1:end);
    
end;

end;     
