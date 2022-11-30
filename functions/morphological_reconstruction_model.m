function [images_array,morph_images_array,J,tEnd_morphological_reconstruction_model] = morphological_reconstruction_model(hazy_image,patch_size,gamma,Width_of_Square_Close,Width_of_Square_Open)
%%implemention of morphological reconstruction model

%%start measuring the time of the morphological reconstruction model
tStart_morphological_reconstruction_model = tic;

%%implemention of the dark channel prior
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

%%using morphological reconstruction to preserve main features as object shapes
[refined_transmission,morph_images_array] = Morphological_Reconstruction(initial_transmission_map,Width_of_Square_Close,Width_of_Square_Open);

%%retrieving the image without haze
J = Image_Retrieval_Without_Haze(hazy_image,A,refined_transmission);

%%calculation of the elapsed time when morphological reconstruction model is used
tEnd_morphological_reconstruction_model = toc(tStart_morphological_reconstruction_model); 

%%creating an array of all the images
images_array = {hazy_image,hazy_image_dcp,normalized_image,min_image,initial_transmission_map,refined_transmission,J};


end

