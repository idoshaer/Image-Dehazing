close all;
clear all;
clc;

%%choosing a hazy image
[hazy_image_file_name,absPath] = uigetfile('*.tif;*.bmp;*.png;*.jpeg;*.jpg;*.gif','Select a hazy image');
hazy_image_full_path = [absPath hazy_image_file_name];

%%loading the hazy image
hazy_image = imread(hazy_image_full_path);

%%defining the patch size for the dcp
patch_size = 13; 

%%defining gamma value
[gamma,gamma_max_psnr_or_ssim] = gamma_selection(hazy_image,hazy_image_full_path);

%%finding the ideal morphological reconstruction parameters
[Width_of_Square_Close,Width_of_Square_Open,psnr_or_ssim_max] = ideal_morphological_reconstruction_parameters(hazy_image,hazy_image_full_path,gamma);

%%implemention of morphological reconstruction model
[images_array,morph_images_array,J,tEnd_morphological_reconstruction_model] = morphological_reconstruction_model(hazy_image,patch_size,gamma,Width_of_Square_Close,Width_of_Square_Open);

%%calculation of the psnr and the ssim of the image after using morphological reconstruction model
[peaksnr_morphological_reconstruction_model,ssim_morphological_reconstruction_model,GT_image] = psnr_ssim(hazy_image_full_path,J);

%%calculation of the psnr and the ssim of the image after using the function
[J2,peaksnr_function,ssim_function,tEnd_function] = dehaze_function(hazy_image,GT_image); 

%%displaying all the images of the code
display_images(GT_image,images_array,J2,morph_images_array);

