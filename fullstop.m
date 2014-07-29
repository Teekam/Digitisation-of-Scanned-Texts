
function [num_dots, temp1]=fullstop(temp1,temp2,line,BB)
   
hello=temp1;
 mymean=0;              %FINDING THE MEAN AREA OF ALL CONNECTED COMPONENTS
for i=1:temp2.NumObjects,
     mymean=mymean +numel(temp2.PixelIdxList{1,i});
end;

mymean=mymean/(5*temp2.NumObjects);
                             
                       %REMOVING ALL THE CONNECTED COMPONENTS WITH AREA
                       %MORE
                       %1/5TH OF THE MEAN AREA

for i=1:temp2.NumObjects
    if (numel(temp2.PixelIdxList{1,i})>mymean);
        
        for j=1:numel(temp2.PixelIdxList{1,i})
            temp1(temp2.PixelIdxList{1, i}(j))=0;
        end;
    
    end;
end;
 figure(2),imshow(temp1)
CC2=bwconncomp(temp1);

RP2=regionprops(temp1); %GIVES THE BOUNDING BOX OF EACH CONN.COMPONENTS
Bboxes = {RP2(:).BoundingBox}; 

n=size(RP2);
num_dots=n(1);
BB2=zeros(num_dots,5); % CREATING A MATRIX OF BOUNDING BOX OF CONN.COMPONENTS

 for i=1:num_dots,
     BB2(i,1:4)=Bboxes{i};
     BB2(i,5)=RP2(i,1).Area;
 end;

  
delta=mymean/3;
dots=zeros(num_dots,1);
for i=1:numel(line)/2
    bottom=min([ BB(line(i,1),2)+BB(line(i,1),4), BB(line(i,2),2)+BB(line(i,2),4)]);
    for j=1:num_dots
        if bottom-delta<=BB2(j,2)&&BB2(j,2)<=bottom+delta
            dots(j)=1;
            
        end
    end
end
area_check=mean(BB2(:,5))/3;
for j=1:num_dots
    if dots(j)~=1
        for k=1:numel(CC2.PixelIdxList{1,j})
            temp1(CC2.PixelIdxList{1, j}(k))=0;
        end
    
            else if  dots(j)==1&&BB2(j,5)<=area_check   
              for k=1:numel(CC2.PixelIdxList{1,j})
            temp1(CC2.PixelIdxList{1, j}(k))=0; 
              end
                end
    end;
end   

num=bwconncomp(temp1);
num_dots=num.NumObjects ;
figure(1),imshow(hello)
figure(3),imshow(temp1)
