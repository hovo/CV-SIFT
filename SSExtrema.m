function kp = SSExtrema(DoGPyr)
% Initialize kp octave cells
noctaves = length(DoGPyr);
kp = cell(1, noctaves);

for octaveIdx=1:noctaves
    % Get current octave
    octave = DoGPyr{octaveIdx};
    % Find size of the octave
    [row,col,ns] = size(octave);
    
    % Init empty cells
    kp{octaveIdx} = cell(1,ns-2);
        
    for dogIdx = 2:(ns-1)
        % Initialize max/min fields
        kp{octaveIdx}{dogIdx-1} = struct('max',[NaN NaN NaN],'min',[NaN NaN NaN]);
        
        % Get the 3 DoGs
        topDog = octave(:,:,dogIdx+1);
        middleDog = octave(:,:,dogIdx);
        bottomDog = octave(:,:,dogIdx-1);
        
        % Iterate over the current DoG
        for rowIdx=2:row-1
            for colIdx=2:col-1
                pixel = middleDog(rowIdx, colIdx);
                
                % Get the 3x3 neighbours
                kernel(1:3,1:3,1) = topDog(rowIdx-1:rowIdx+1, colIdx-1:colIdx+1);
                kernel(1:3,1:3,2) = middleDog(rowIdx-1:rowIdx+1, colIdx-1:colIdx+1);
                kernel(1:3,1:3,3) = bottomDog(rowIdx-1:rowIdx+1, colIdx-1:colIdx+1);
                
                % Find the min and max pixels from the kernel
                minNeighbour = min(kernel,[],'all');
                maxNeighbour = max(kernel,[],'all');
                
                % Create min/max entry
                entry = [colIdx rowIdx pixel];
                
                % Save entry to the min field
                if(pixel == minNeighbour)
                    kpMin = kp{octaveIdx}{dogIdx-1}.min;
                    kp{octaveIdx}{dogIdx-1}.min = [kpMin; entry];
                end
                
                % Save entry to the max field
                if(pixel == maxNeighbour)
                    kpMax = kp{octaveIdx}{dogIdx-1}.max;
                    kp{octaveIdx}{dogIdx-1}.max = [kpMax; entry];
                end
                
            end
        end
    end
end