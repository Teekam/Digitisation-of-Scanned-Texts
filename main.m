   


 
clear ;clc;

  

%% TAKE THE PATH OF THE IMAGE AS INPUT AND READ THE IMAGE
b = input(' Enter the complete path of image\n ','s');
i=imread(b);

%% IMAGE PROCESSING
% g=rgb2gray(i);          % CONVERTING THE READ IMAGE TO GRAYSCALE                 
% img=imadjust(g);          % ADJUSTING THE CONTRAST       
 img=~im2bw(i,0.8);        % CONVERTING TO A INVERTED BINARY IMAGE, LIMIT PARAMETER CHOSEN AS 0.8
temp1=img;
%% EXTRACTING ALL THE CONNECTED COMPONENTS FROM BINARY IMAGE

fprintf('\nLoading Image ...\n');
pause;
fprintf('\nEnhancing image..\n');
fprintf('Converting to grayscale to Binary ...');
pause;
fprintf('\nPress Enter to show the image....\n');
pause;
imshow(img);



CC= bwconncomp(img);
temp2=CC;

 mymean=0;              %FINDING THE MEAN AREA OF ALL CONNECTED COMPONENTS
for i=1:CC.NumObjects,
     mymean=mymean +numel(CC.PixelIdxList{1,i});
end;

mymean=mymean/(3*CC.NumObjects);
                             
                       %REMOVING ALL THE CONNECTED COMPONENTS WITH AREA LESS
   pause;                    %1/5TH OF THE MEAN AREA
 fprintf('\nRemoving Noise....\n');
 pause;
fprintf('\nDots and Commas removed....\n');
fprintf('\nUsing matlab funtion ''bwconncomp'' to find 8 member connected components....\n');

for i=1:CC.NumObjects
    if (numel(CC.PixelIdxList{1,i})<=mymean);
        
        for j=1:numel(CC.PixelIdxList{1,i})
            img(CC.PixelIdxList{1, i}(j))=0;
        end;
    
    end;
end;
%%BOUNDING BOX AND SORTING OF CONNECTED COMPONENTS BY LINE AND WORDS
%  figure,imshow(img)
RP=regionprops(img); %GIVES THE BOUNDING BOX OF EACH CONN.COMPONENTS
Bboxes = {RP(:).BoundingBox}; 

n=size(RP);
num=n(1);
BB1=zeros(num,4); % CREATING A MATRIX OF BOUNDING BOX OF CONN.COMPONENTS

 for i=1:num,
     BB1(i,:)=Bboxes{i};
 end;
 
  [BB1, line]=sortline(BB1, num); %RETURNS THE SORTED MATRIX BB AND

fprintf('\nBounding and indexing each component detected....\n');
fprintf('\nSorting by line then by word....\n');
pause;
fprintf('\nShowing example of a component....\n');
  
  
  
  
  imshow(imcrop(img, BB1(8,:)));   
 fprintf('Program paused... Press enter to continue.\n');
 
 %LINE MATRIX: WHERE EACH LINE STARTS AND ENDS
pause;
 
[num_dots,img_of_dots]=fullstop(temp1,temp2,line,BB1);
%  figure,imshow(img)
img_final=imadd(img,img_of_dots);
%  figure,imshow(img_of_dots)
img_final=logical(img_final);
%     figure,imshow(img_final)
    
RP=regionprops(img_final);
Bboxes = {RP(:).BoundingBox}; 

n=size(RP);
num=n(1);
BB=zeros(num,5); % CREATING A MATRIX OF BOUNDING BOX OF CONN.COMPONENTS

fprintf('Separating fullstop and comma in the image....\n');
fprintf('Appyling MEGATRON-600 :D Dot-filter ...\n');
pause;
 for i=1:num,
     BB(i,1:4)=Bboxes{i};
     BB(i,5)=RP(i,1).Area;
 end;

  [BB, line1]=sortline(BB, num);%GIVES THE BOUNDING BOX OF EACH CONN.COMPONENTS
 




 dotarray=zeros(num_dots,1);
k=1;alphabets=1;
 for i=1:num,
     if BB(i,5)<=mymean
         dotarray(k)=i;
         k=k+1;
     
     else

     
     alphabets=alphabets+1;
     end
 end;
alphabets=alphabets-1;

 



    for j=1:alphabets,
    temp=imcrop(img, BB1(j,1:4));
     temp=bresize(temp);
     
     dataset(:,j)=temp(1:end);
    
end;
fprintf('Images with and without fullstops...\n');


fprintf('Program Paused..Press enter to continue...\n');

pause;

fprintf('Sending Image to the neural network for detection.....\n');
pause;

    out=predict(dataset');
    ind=zeros(alphabets,1);
    diff=zeros(alphabets,1);
    for i=1:alphabets-1
        diff(i)=BB1(i+1,1)-BB1(i,1)-BB1(i,3);
    end
    
       pos= find(diff>0);
       check = mean(diff(pos));
       for i = 1:alphabets
            if diff(i)>(check*1.2)
                ind(i) = 1;
            end
            if diff(i) < (check*-5)
                ind(i) = 2;
            end
       end


key = ['A';'B';'C';'D';'E';'F';'G';...
    'H';'I';'J';'K';'L';'M';'N';'O';'P';'o';'R';'S';'T';'U';'V';'W';'X';...
    'Y';'Z';'a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k';'l';'m';'n';'o';...
    'p';'q';'r';'s';'t';'u';'v';'w';'x';'y';'z';'0';'1';'2';'3';'4';'5';'6';'7';'8';'9'];

%% ASK THE USER TO INPUT THE FILE NAME AND WRITE THE FILE AND SAVE

file ='_.txt';

fileID = fopen(file,'w');

strcount=0;count=1;dotcheck=zeros(num_dots,1);
for i = 1:alphabets   
    if ind(i)==0
        fprintf(fileID,'%1s',key(out(i)));
              
    else
        if ind(i) == 1
                fprintf(fileID,'%1s ',key(out(i)));
                strcount=strcount+1;
                while (count<=num_dots&&dotarray(count)==(i+count))
                    dotcheck(count)=strcount;
                    count=count+1;
                end 
        
     else
         fprintf(fileID,'%1s\n',key(out(i)));
         strcount=strcount+1;

                while (count<=num_dots&&dotarray(count)==(i+count))
                    dotcheck(count)=strcount;
                    count=count+1;
                end 
        end
    end
    
end
strcount=strcount+1;

 while (count<=num_dots && dotarray(count)==(i+count))
                    dotcheck(count)=strcount;
                    count=count+1;
 end
fclose(fileID);

fprintf('Writing raw output to ''raw.txt'' file.....\n');
pause;
fprintf('Applying filter for ''i'' and ''l'' and ''1'' .....\n');
pause;
fprintf('Applying filter for ''5'' and ''S''.....\n ');
fprintf('Filtering Capital and Small alike letters w W s S c C.....\n');
pause;
fprintf('Writing enhanced output to ''result.txt'' file.....\n');
fprintf('Including dots.....\n');
pause;
fprintf('Done.....\n');
file='_.txt';
fileID = fopen(file,'r');

myfile=textscan(fileID,'%s','delimiter',' ');
file_len=numel(myfile{1});

str=primilinery_spellcheck(myfile);


str= lichange(str,BB1);


str{1}= lower(str{1});
fp= fopen('result.txt', 'w');
word_pos=0;
j=1; k=1;
str{1}{1}(1)=upper(str{1}{1}(1));
for i = 1:file_len 
    
    n=numel(str{1}{i});
    word_pos=word_pos+n;
    
    if n==1 && str{1}{i}(1)=='i';
            str{1}{i}(1)='I';
    end;
    
    if k~=num_dots+1 && i==dotcheck(k)
             k=k+1;
            if word_pos==line(j,2)

                    fprintf(fp, '%s.\n',str{1}{i});
                    j=j+1;

            else
                fprintf(fp, '%s. ',str{1}{i});
            end
            
            if word_pos~=alphabets
                str{1}{i+1}(1)=upper(str{1}{i+1}(1));   
            end
    else
           if word_pos==line(j,2)

                    fprintf(fp, '%s\n',str{1}{i});
                    j=j+1;

           else
                fprintf(fp, '%s ',str{1}{i});
           end
    end  
    
    
end






    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
