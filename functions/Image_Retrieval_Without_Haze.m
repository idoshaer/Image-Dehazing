function J = Image_Retrieval_Without_Haze(hazy_image,A,refined_transmission)
%%retrieving the image without haze

hazy_image = double(hazy_image);

A = double(A);

J(:,:,1) = (hazy_image(:,:,1) - A(1))./refined_transmission + A(1); 
J(:,:,2) = (hazy_image(:,:,2) - A(2))./refined_transmission + A(2); 
J(:,:,3) = (hazy_image(:,:,3) - A(3))./refined_transmission + A(3);

end

