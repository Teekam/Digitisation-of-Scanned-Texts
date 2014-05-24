
function [BB, line]= sortline (BB, num)
%% FUNCTION FOR SORTING THE MATRIX BB CONTAINING CONNECTED COMPONENTS %%


BB=sortrows(BB, 2); %SORTING MATRIX Y-WISE 

ywidth=max(BB(:,4)); %MAX HEIGHT FOR A CHARACTER IN THE IMAGE
down= BB(1,2)+1.4*ywidth; % HEIGHT USED TO SEPARATE COMPONENTS OF DIFFERENT HEIGHT
                          % 1.4*YWIDTH USED TO INCLUDE LETTERS LIKE 'g'
%% FINDING START-END POINTS OF A LINE
j=1; k=2;
line(1,1)=1;

for i=1:num,
    
        if(i==num)
            line(j,k)=num;
        end;
        if (BB(i,2)>=down )
            line(j,k)=i-1;
            j=j+1;
            line(j,1)=i;
            down=BB(i+1,2)+1.5*ywidth;
        end;
        
  
end;

%% SORTING OF WORDS OF EACH LINE BY X-AXIS 
num=numel(line)/2;
for i=1:num,
    
    BB(line(i,1):line(i,2), :)=sortrows(BB(line(i,1):line(i,2), :), 1);
    
end;    
