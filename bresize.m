function image1= bresize(binaryimg)
%% FUNCTION TO RESIZE A BINARY IMAGE INTO 32x32 WITHOUT CHANGING THE ASPECT RATIO OF THE ORIGINAL RATIO
s=size(binaryimg);
width=s(2);
height =s(1);

if height>width        %say height=16 and width=10
    ratio=32/height;   %32/16=2
    image1=imresize(binaryimg, ratio); %new size = 32X20
    s=size(image1);
    numcol=32-s(2);    % No. of columns to add in image 32-20=10
    if mod(numcol, 2)==0,
        image1=[zeros(32,numcol/2), image1 , zeros(32,numcol/2)];
                       %5-5 columns of zeros on each side
    else 
        image1=[zeros(32,(numcol+1)/2), image1 , zeros(32,(numcol-1)/2)];
        
    
    end;

else
     ratio=32/width;   
     image1=imresize(binaryimg, ratio);
     s=size(image1);
     numrows=32-s(1);
     if mod(numrows, 2)==0,
        image1=[zeros(numrows/2,32); image1 ; zeros(numrows/2, 32)];
    
    else 
        image1=[zeros((numrows+1)/2,32);image1 ;zeros((numrows-1)/2,32)];
        
    
    end;
     

end;



