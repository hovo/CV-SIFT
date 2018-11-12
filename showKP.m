function showKP(DoGPyr,ns, kp, nkp)
%Display nkp most extreme max and min keypoints kp over DoG Pyramid 
%representation of image with ns subbands per octave.  Maxima are red and
%minima are cyan.

noctave = length(DoGPyr);
k = 2^(1/ns);

figure;
p = 1;
for octave = 1:noctave
   imo = DoGPyr{octave};
   kpo = kp{octave};
   for suboctave = 2:(ns+1) %keypoints detected on inner ns scales
       subplot(noctave,ns,p);
       imagesc(imo(:,:,suboctave));axis image;axis off;colormap gray;
       hold on;
       kpso = kpo{suboctave-1};
       [m,idx] = maxk(kpso.max(:,3),nkp); %Top nkp maxima
       plot(kpso.max(idx,1),kpso.max(idx,2),'r.','MarkerSize',24);
       [m,idx] = mink(kpso.min(:,3),nkp); %Top nkp minima
       plot(kpso.min(idx,1),kpso.min(idx,2),'c.','MarkerSize',24);
       title(sprintf('Scale = %0.1f',2^(octave-1)*k^(suboctave - 1)),'FontSize',18);
       p = p + 1;
   end
end
