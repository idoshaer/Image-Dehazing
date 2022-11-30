function [hazy_image_dcp,m,n] = Dark_Channel_Prior(hazy_image,patch_size)
%%implemention of the dark channel prior

%%finding the dimensions of the hazy image 
[m,n,c] = size(hazy_image);

%%padding the image
padded_image = padarray(hazy_image,[(patch_size-1)/2 (patch_size-1)/2],'replicate');

%%creating the matrix of the dark channel
hazy_image_dcp = zeros(m,n);

for i = 1:m
    
    for k = 1:n
        
        %%defining the indexes of the patch
        patch = padded_image(i:(i+patch_size-1), k:(k+patch_size-1),:);
        
        %%choosing the minimum value of the patch for each color
        min_red = min(min(patch(:,:,1)));
        min_green = min(min(patch(:,:,2)));
        min_blue = min(min(patch(:,:,3)));

        %%defining the index as the minimum value of all colors
        hazy_image_dcp(i,k) = min([min_red,min_green,min_blue]);

    end
     
end


end

