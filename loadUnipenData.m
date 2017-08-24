function [DATA LABEL] = loadUnipenData(filename)
fid=fopen(filename,'r');
line = fgets(fid);
n = 1;
while ischar(line)
    line = strtrim(line);
    if regexp(line, '.SEGMENT.*\?.*"(\d)"')
        num = str2num(regexprep(line,'.SEGMENT.*\?.*"(\d)"','$1'));
        disp([num2str(num) ':' line]);
        line = fgets(fid);
        trace=[];
        while ischar(line) & (length(regexp(line, '.SEGMENT.*\?.*"(\d)"')) == 0)
            line = strtrim(line);
            if length(sscanf(line,'%d %d')) == 2
                p = sscanf(line, '%d %d');
                trace = [trace p(:)];
            elseif (strcmp(line, '.PEN_DOWN') == 1)
                trace=[trace [-1; 1]];
            elseif (strcmp(line, '.PEN_UP') == 1)
                trace=[trace [-1; -1]];
            end
            line = fgets(fid);
        end
        DATA{n} = trace;
        LABEL(n) = num;
        n = n + 1; 
    else
        line = fgets(fid);
    end
end
fclose(fid);
end
        
        
            
    
    
