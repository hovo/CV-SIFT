function kp = SSExtrema(DoGPyr)
% Initialize kp
noctaves = length(DoGPyr);
kp = cell(1, noctaves);

for octaveIdx=1:noctaves
    % Get current octave
    octave = DoGPyr{octaveIdx};
    % Find size of the octave
    [row,col,ns] = size(octave); 
    for dogIdx = 2:(ns-1)
        % Get the 3 DoGs
        currentDog = octave(:,:,dogIdx);
        topDog = octave(:,:,dogIdx+1);
        bottomDog = octave(:,:,dogIdx-1);
        
        % Iterate over the current DoG
        for rowIdx=2:row-1
            for colIdx=2:col-1
                pixel = currentDog(rowIdx, colIdx);
                kernel(1:3,1:3,1) = topDog(rowIdx-1:rowIdx+1, colIdx-1:colIdx+1);
                kernel(1:3,1:3,2) = currentDog(rowIdx-1:rowIdx+1, colIdx-1:colIdx+1);
                kernel(1:3,1:3,3) = bottomDog(rowIdx-1:rowIdx+1, colIdx-1:colIdx+1);
                
                % Find the min and max pixels from the kernel
                minNeighbour = min(kernel,[],'all');
                maxNeighbour = max(kernel,[],'all');
                
                if(pixel == minNeighbour)
                    % TODO: Save
                end
                
                if(pixel == maxNeighbour)
                    % TODO: Save
                end
            end
        end
    end
end