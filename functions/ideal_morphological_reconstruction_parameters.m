function [ideal_Width_of_Square_Close,ideal_Width_of_Square_Open,psnr_or_ssim_max] = ideal_morphological_reconstruction_parameters(hazy_image,hazy_image_full_path,gamma)
%%finding the ideal morphological reconstruction parameters

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

%%computation of the initial transmission map
initial_transmission_map = 1 - gamma*min_image;


%%for

%%defining the amount of square parameters
length_of_square_parameter = 15;

%%defining the morphological reconstruction parameters values
Width_of_Square_Close = 1:length_of_square_parameter;
Width_of_Square_Open = 1:length_of_square_parameter;

psnr_matrix = []; 
ssim_matrix = []; 

for a = Width_of_Square_Close
    
    psnr_vector = []; 
    ssim_vector = []; 
    
    for b = Width_of_Square_Open
        
        %%using morphological reconstruction to preserve main features as object shapes
        refined_transmission = Morphological_Reconstruction(initial_transmission_map,a,b);

        %%retrieving the image without haze
        J = Image_Retrieval_Without_Haze(hazy_image,A,refined_transmission);

        %%loading the ground truth of the image
        GT_image_full_path = replace(hazy_image_full_path,'hazy','GT');
        GT_image = imread(GT_image_full_path);

        %%calculation of the psnr and the ssim of the image after using morphological reconstruction model
        [peaksnr_morphological_reconstruction_model,snr] = psnr(uint8(J),uint8(GT_image));
        ssim_morphological_reconstruction_model = ssim(uint8(J),uint8(GT_image));

        psnr_vector = [psnr_vector,peaksnr_morphological_reconstruction_model];
        ssim_vector = [ssim_vector,ssim_morphological_reconstruction_model];

    end
    
    psnr_matrix = [psnr_matrix;psnr_vector];
    ssim_matrix = [ssim_matrix;ssim_vector];
    
end

%%choosing the significant parameter in this case - psnr or ssim
psnr_max = max(max(psnr_matrix));
psnr_max_index = find(psnr_matrix == psnr_max);

ssim_max = max(max(ssim_matrix));
ssim_max_index = find(ssim_matrix == ssim_max);

if (psnr_matrix(psnr_max_index) -  psnr_matrix(ssim_max_index)) >  (ssim_matrix(ssim_max_index) -  ssim_matrix(psnr_max_index))

    [ideal_Width_of_Square_Close,ideal_Width_of_Square_Open] = find(psnr_matrix == psnr_max);
    psnr_or_ssim_max = psnr_max;

else
    
    [ideal_Width_of_Square_Close,ideal_Width_of_Square_Open] = find(ssim_matrix == ssim_max);
    psnr_or_ssim_max = ssim_max;

end

ideal_Width_of_Square_Close = ideal_Width_of_Square_Close(1);
ideal_Width_of_Square_Open = ideal_Width_of_Square_Open(1);

end

