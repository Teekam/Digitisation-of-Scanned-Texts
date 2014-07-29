function str=lichange(str,BB)

len=numel(str{1});
tot=0;
 maxi=max(BB(:,4));
for i=1:len;
    
    len2= numel(str{1}{i});
    
    
    if len2==1
        pos=1;
       if str{1}{i}(pos)=='l'||str{1}{i}(pos)=='i'||str{1}{i}(pos)=='1'||str{1}{i}(pos)=='I'
        str{1}{i}(pos)='I';
        
       end
    end
    
    if(len2~=1)
       
                
        for pos=1:len2,
            

             if  str{1}{i}(pos)=='i'||str{1}{i}(pos)=='l'||str{1}{i}(pos)=='I'||str{1}{i}(pos)=='1'

                  if BB(tot+pos,4)<=.7*maxi
                            
                            str{1}{i}(pos)='i';
                            
                  else      
                           
                            str{1}{i}(pos)='l';
                           
                  end
            end
        end
    end
 tot=tot+len2;   
end
