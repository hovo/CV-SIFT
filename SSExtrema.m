function kp = SSExtrema(DoGPyr)
% Initialize kp
noctaves = length(DoGPyr);
kp = cell(1, noctaves);

% find number of DoG at each octave
[~,~,ns] = size(DoGPyr{1}); 

for octave=1:noctaves
   for dog = 2:(ns-1)
       dog
   end
end