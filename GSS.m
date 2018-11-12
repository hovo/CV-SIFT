function GPyr = GSS(im, s1, ns, noctaves)
% Initialize an empty cell array for GSS
GPyr = cell(1, noctaves);


% We must product s+3 images in the stack of blurred images for each
% octave, so that final extrema detection covers a complete octave.
p = ns + 3;
% Constant factor
k = 2^(1/ns);

% Iterate over each octave
for octave=1:noctaves
    % Iterate over each suboctave
    for suboctave=1:p
        sigma = s1*k^suboctave;
        max = ceil(sqrt(2*sigma^2*log(100)));
        x = -max:max;
        h = exp(-x.^2/(2*sigma^2));
        h = h/sum(h(:)); % Normalize to unit volume
        scale(:,:,suboctave) = conv2(h,h,im,'valid');
    end
    
    % Save the scale to GPyr
    GPyr{octave} = scale;
    
    % Resample image for the next octave
    if(octave < nooctaves)
        
    end
end