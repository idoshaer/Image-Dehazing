function [J2,peaksnr_function,ssim_function,tEnd_function] = dehaze_function(hazy_image,GT_image)
%%calculation of the psnr and the ssim of the image after using the function

%%start measuring the time of the function
tStart_function = tic; 

%%using the function "imreducehaze" for dehazing
J2 = imreducehaze(uint8(hazy_image));

%%calculation of the elapsed time when the function is used
tEnd_function = toc(tStart_function); 

%%calculation of the psnr and the ssim of the image after using the function
peaksnr_function = psnr(uint8(J2),uint8(GT_image));
ssim_function = ssim(uint8(J2),uint8(GT_image));

end

