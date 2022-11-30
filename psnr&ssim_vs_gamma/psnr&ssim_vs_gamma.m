close all;
clear all;
clc;

%%choosing a hazy image
[hazy_image_file_name,absPath] = uigetfile('*.tif;*.bmp;*.png;*.jpeg;*.jpg;*.gif','Select a hazy image');
hazy_image_full_path = [absPath hazy_image_file_name];

%%loading the hazy image
hazy_image = {};
hazy_image{1} = imread(hazy_image_full_path);

%%defining the patch size for the dcp
patch_size = 13; 

%%defining the ideal morphological reconstruction parameters
Width_of_Square_Close = 3;
Width_of_Square_Open = 2;

%%defining the gamma values
gamma_values = 0.1:0.1:0.9;

hazy_image{2} = imresize(hazy_image{1},2);
hazy_image{3} = imresize(hazy_image{1},3);
hazy_image{4} = imresize(hazy_image{1},4);

%%loading the ground truth of the image
GT_image_full_path = replace(hazy_image_full_path,'hazy','GT');
GT_image = imread(GT_image_full_path);

psnr_matrix = [];
ssim_matrix = [];

i = 1;


for y = hazy_image
    
    z = y{1};

    GT_image_after_resize = imresize(GT_image,i);

    
    psnr_vector = []; 
    ssim_vector = []; 

    for x = gamma_values

        %%implemention of morphological reconstruction model
        [images_array,morph_images_array,J,tEnd_morphological_reconstruction_model] = morphological_reconstruction_model(z,patch_size,x,Width_of_Square_Close,Width_of_Square_Open);

        %%calculation of the psnr and the ssim of the image after using morphological reconstruction model
        peaksnr_morphological_reconstruction_model = psnr(uint8(J),uint8(GT_image_after_resize));
        ssim_morphological_reconstruction_model = ssim(uint8(J),uint8(GT_image_after_resize));

        psnr_vector = [psnr_vector,peaksnr_morphological_reconstruction_model];
        ssim_vector = [ssim_vector,ssim_morphological_reconstruction_model];

    end
    
    psnr_matrix = [psnr_matrix;psnr_vector];
    ssim_matrix = [ssim_matrix;ssim_vector];

    i = i + 1;
    
end

%%

figure(1)
psnr_plot = plot(gamma_values,psnr_matrix(1,:),'-og');
xlim([0 1]);
ylim([11 23]);
xlabel('gamma');
ylabel('PSNR');
title('PSNR as a function of gamma')
grid on;

hold on
psnr_plot2 = plot(gamma_values,psnr_matrix(2,:),'-ob');
psnr_plot3 = plot(gamma_values,psnr_matrix(3,:),'-oy');
psnr_plot4 = plot(gamma_values,psnr_matrix(4,:),'--or');

legend('284 x 466','568 x 932','852 x 1398','1136 x 1864');

%%

figure(2)
ssim_plot = plot(gamma_values,ssim_matrix(1,:),'-og');
xlim([0 1]);
ylim([0.5 0.9]);
xlabel('gamma');
ylabel('SSIM');
title('SSIM as a function of gamma')
grid on;

hold on
ssim_plot2 = plot(gamma_values,ssim_matrix(2,:),'-ob');
ssim_plot3 = plot(gamma_values,ssim_matrix(3,:),'-oy');
ssim_plot4 = plot(gamma_values,ssim_matrix(4,:),'--or');

legend('284 x 466','568 x 932','852 x 1398','1136 x 1864');

