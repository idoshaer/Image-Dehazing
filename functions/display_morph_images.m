function display_morph_images(morph_images_array)
%%displaying the different stages of the image when in the morphological process.

figure(10)
imshow(morph_images_array{1});
title("Initial Transmission Map of The Image");
figure(11)
imshow(morph_images_array{2});
title("The Image After Closing by Reconstruction Operation");
figure(12)
imshow(morph_images_array{3});
title("The Image After Opening by Reconstruction Operation");
figure(13)
imshow(morph_images_array{5});
title("R");
figure(14)
imshow(morph_images_array{4});
title("t'_3");
figure(15)
imshow(morph_images_array{6});
title("Refined Transmission of The Image");


end

