function display_model_images(images_array)
%%displaying the different stages of the image when morphological
%%reconstruction model is used

figure(2)
imshow(uint8(images_array{1}));
title("The Hazy Image");
figure(3)
imshow(uint8(images_array{2}));
title("Dark Channel Prior of The Image");
figure(4)
imshow(images_array{3});
title("Normalized Image by Atmospheric Light");
figure(5)
imshow(images_array{4});
title("Minimum of The Image");
figure(6)
imshow(images_array{5});
title("Initial Transmission Map of The Image");
figure(7)
imshow(images_array{6});
title("Refined Transmission of The Image");
figure(8)
imshow(uint8(images_array{7}));
title("Reconstructed Image Without Haze");


end

