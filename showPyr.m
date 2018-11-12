function showPyr(Pyr,ns)
%Display Pyramid representation of image, with ns subband scales per octave
noctave = length(Pyr);
k = 2^(1/ns);

figure;
p = 1;
for octave = 1:noctave
   oim = Pyr{octave};
   n = size(oim,3);
    for suboctave = 1:n
       subplot(noctave,n,p);
       imagesc(oim(:,:,suboctave));axis image;axis off;colormap gray;
       title(sprintf('Scale = %0.1f',2^(octave-1)*k^(suboctave - 1)),'FontSize',18);
       p = p + 1;
   end
end
