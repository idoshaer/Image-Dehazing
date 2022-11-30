function [peaksnr_morphological_reconstruction_model,ssim_morphological_reconstruction_model,GT_image] = psnr_ssim(hazy_image_full_path,J)
%%calculation of the psnr and the ssim of the image after using morphological reconstruction model

%%loading the ground truth of the image
GT_image_full_path = replace(hazy_image_full_path,'hazy','GT');
GT_image = imread(GT_image_full_path);

%%calculation of the psnr and the ssim of the image after using morphological reconstruction model
peaksnr_morphological_reconstruction_model = psnr(uint8(J),uint8(GT_image));
ssim_morphological_reconstruction_model = ssim(uint8(J),uint8(GT_image));


end

