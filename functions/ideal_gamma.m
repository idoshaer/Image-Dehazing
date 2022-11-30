function [gamma,gamma_max_psnr_or_ssim] = ideal_gamma(hazy_image,hazy_image_full_path)
%%finding the ideal gamma

%%implemention of the dark channel prior
patch_size = 13; 
[hazy_image_dcp,m,n] = Dark_Channel_Prior(hazy_image,patch_size);

%%calculation of the atmospheric light
[A,hazy_image_mat] = Atmospheric_Light(hazy_image,hazy_image_dcp,m,n);

%%normalization of the image
normalized_image_mat = double(hazy_image_mat)./double(A);
normalized_image = reshape(normalized_image_mat,[m,n,3]);

%%finding the minimum of the image
min_image_vector = (min(normalized_image_mat'))';
min_image = reshape(min_image_vector,[m,n]);


%%for

%%defining the gamma values
gamma_values = 0.1:0.1:0.9;

%%defining the ideal morphological reconstruction parameters
Width_of_Square_Close = 3;
Width_of_Square_Open = 2;

psnr_vector = []; 
ssim_vector = []; 

for x = gamma_values
    
%%computation of the initial transmission map
initial_transmission_map = 1 - x*min_image;

%%using morphological reconstruction to preserve main features as object shapes
refined_transmission = Morphological_Reconstruction(initial_transmission_map,Width_of_Square_Close,Width_of_Square_Open);

%%retrieving the image without haze
J = Image_Retrieval_Without_Haze(hazy_image,A,refined_transmission);

%%loading the ground truth of the image
GT_image_full_path = replace(hazy_image_full_path,'hazy','GT');
GT_image = imread(GT_image_full_path);

%%calculation of the psnr and the ssim of the image after using morphological reconstruction model
peaksnr_morphological_reconstruction_model = psnr(uint8(J),uint8(GT_image));
ssim_morphological_reconstruction_model = ssim(uint8(J),uint8(GT_image));

psnr_vector = [psnr_vector,peaksnr_morphological_reconstruction_model];
ssim_vector = [ssim_vector,ssim_morphological_reconstruction_model];

end

%%choosing the significant parameter in this case - psnr or ssim
gamma_max_psnr = max(psnr_vector);
gamma_max_psnr_index = find(psnr_vector==gamma_max_psnr);

gamma_max_ssim = max(ssim_vector);
gamma_max_ssim_index = find(ssim_vector==gamma_max_ssim);

if (psnr_vector(gamma_max_psnr_index(1)) -  psnr_vector(gamma_max_ssim_index(1))) >  (ssim_vector(gamma_max_ssim_index(1)) -  ssim_vector(gamma_max_psnr_index(1)))

    gamma = gamma_values(gamma_max_psnr_index(1));
    gamma_max_psnr_or_ssim = gamma_max_psnr;
    
else
    
    gamma = gamma_values(gamma_max_ssim_index(1));
    gamma_max_psnr_or_ssim = gamma_max_ssim;

end


end

