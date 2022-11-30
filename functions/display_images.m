function display_images(GT_image,images_array,J2,morph_images_array)
%%displaying all the images of the code

%%displaying the ground truth of the image
figure(1)
imshow(GT_image);
title("The Ground Truth of The Image");

%%displaying the different stages of the image when morphological 
%%reconstruction model is used
display_model_images(images_array);

%%displaying the image after using the function
figure(9)
imshow(J2);
title("Reconstructed Image by Using The Function");

%%displaying the different stages of the image when in the morphological process.
display_morph_images(morph_images_array);


figure(16)
subplot(1,3,1)
imshow(GT_image);
title("The Ground Truth of The Image");
subplot(1,3,2)
imshow(uint8(images_array{1}));
title("The Hazy Image");
subplot(1,3,3)
imshow(uint8(images_array{7}));
title("Reconstructed Image Without Haze");


figure(17)
subplot(1,3,1)
imshow(uint8(images_array{1}));
title("The Hazy Image");
subplot(1,3,2)
imshow(uint8(images_array{7}));
title("Reconstructed Image Without Haze");
subplot(1,3,3)
imshow(J2);
title("Reconstructed Image by Using The Function");


figure(18)
subplot(1,8,1)
imshow(uint8(GT_image));
subplot(1,8,2)
imshow(uint8(images_array{1}));
subplot(1,8,3)
imshow(uint8(images_array{2}));
subplot(1,8,4)
imshow(images_array{3});
subplot(1,8,5)
imshow(images_array{4});
subplot(1,8,6)
imshow(images_array{5});
subplot(1,8,7)
imshow(images_array{6});
subplot(1,8,8)
imshow(uint8(images_array{7}));


end

