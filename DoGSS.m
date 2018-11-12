function DoGPyr = DoGSS(GPyr)
% Number of Octaves
noctaves = length(GPyr);
% Initialize DoGPyr cell
DoGPyr = cell(1, noctaves);

for idx=1:noctaves
    octave = GPyr{idx};
    [~,~,suboctaves] = size(octave);
    for k=1:(suboctaves-1)
        oct1 = octave(:,:,k);
        oct2 = octave(:,:,k+1);
        dog(:,:,k) = oct2 - oct1;
    end
    DoGPyr{idx} = dog;
    dog = [];
end


