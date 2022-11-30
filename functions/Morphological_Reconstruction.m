function [refined_transmission,morph_images_array] = Morphological_Reconstruction(t_1,Width_of_Square_Close,Width_of_Square_Open)
%%using morphological reconstruction to preserve main features as object shapes

%%closing by reconstruction operation
se_close = strel("square",Width_of_Square_Close);
t_2 = imclose(t_1,se_close);

%%opening by reconstruction operation
se_open = strel("square",Width_of_Square_Open);
t_3 = imopen(t_2,se_open);

R = t_1 - t_3;

r = (max(t_1)-min(t_1))/(max(t_3)-min(t_3));

t_3_tag = t_3 - min(t_3)*r + min(t_1);

%%refined transmission of the image
refined_transmission = R + t_3_tag;

%%creating an array of all the images in the morphological process 
morph_images_array = {t_1,t_2,t_3,R,t_3_tag,refined_transmission};

end

