function str= primilinery_spellcheck(str)
%load 'dictionary.mat';



file_len=numel(str{1});

for t=1:file_len
    
    len=numel(str{1}{t});
    
    for pos=1:len,

    if  str{1}{t}(pos)=='5'

        if(len==1)


        else if (pos~=1 && pos~=len)

                if (str{1}{t}(pos-1)>'0' && str{1}{t}(pos-1)<'9' && str{1}{t}(pos+1)>'0' && str{1}{t}(pos+1)<'9')
                 
                else str{1}{t}(pos)='s';
             
                end;

            else if (pos==len)

                        if (str{1}{t}(pos-1)>'0' && str{1}{t}(pos-1)<'9')
                               
                        else str{1}{t}(pos)='s';
                              
                        end;
                else 
                        if (str{1}{t}(pos+1)>'0' && str{1}{t}(pos+1)<'9')
                               
                        else str{1}{t}(pos)='s';
                            
                        end;
                end;
             end;
       end;
    end;  

  end;

    
end;  
    
    





for t=1:file_len
    
    len=numel(str{1}{t});
    
    for pos=1:len,

    if  str{1}{t}(pos)=='0'

        if(len==1)


        else if (pos~=1 && pos~=len)

                if (str{1}{t}(pos-1)>'0' && str{1}{t}(pos-1)<'9' && str{1}{t}(pos+1)>'0' && str{1}{t}(pos+1)<'9')
                 
                else str{1}{t}(pos)='o';
             
                end;

            else if (pos==len)

                        if (str{1}{t}(pos-1)>'0' && str{1}{t}(pos-1)<'9')
                               
                        else str{1}{t}(pos)='o';
                              
                        end;
                else 
                        if (str{1}{t}(pos+1)>'0' && str{1}{t}(pos+1)<'9')
                               
                        else str{1}{t}(pos)='o';
                            
                        end;
                end;
             end;
       end;
    end;  

  end;

    
end;  
