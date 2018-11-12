function GPyr = GSS(im, s1, ns, noctaves)
% Initialize an empty cell array for GSS
GPyr = cell(1, noctaves);

% We must produce s+3 images in the stack of blurred images for each
% octave, so that final extrema detection covers a complete octave.
p = ns + 3;
% Constant factor k
k = 2^(1/ns);

% Iterate over each octave
for octave=1:noctaves
    baseIm = im;
    % Find dimensions for the octave
    [imRow, imCol] = size(baseIm);
    % Iterate over each suboctave
    for suboctave=0:(p-1)
        sigma = s1*k^suboctave;
        max = ceil(sqrt(2*sigma^2*log(100)));
        x = -max:max;
        h = exp(-x.^2/(2*sigma^2));
        h = h/sum(h(:)); % Normalize to unit volume
        blurredImage = conv2(h,h,baseIm,'valid');
        [r,c] = size(blurredImage);
        
        scaleSource = nan(imRow,imCol);
        scaleSource(max+1:imRow-max, max+1:imCol-max) = blurredImage;
        scale(:,:,suboctave+1) = scaleSource;
        % Save scale to GPyr
        GPyr{octave} = scale;
        % Update the base image for the next scale
        if(suboctave == ns)
           im = imresize(scaleSource, 0.5);
        end
    end
end