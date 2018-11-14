function kp = SSExtrema(DoGPyr)
% Initialize kp
noctaves = length(DoGPyr);
kp = cell(1, noctaves);

% find number of DoG at each octave
[~,~,ns] = size(DoGPyr{1}); 

for octaveIdx=1:noctaves
    octave = DoGPyr{octaveIdx};
    for dogIdx = 2:(ns-1)
        currentDog = octave(:,:,dogIdx);
        topDog = octave(:,:,dogIdx+1);
        bottonDog = octave(:,:,dogIdx-1);
    end
end