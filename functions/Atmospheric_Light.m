function [A,hazed_image_mat] = Atmospheric_Light(hazed_image,hazed_image_dcp,m,n)
%%calculation of the atmospheric light

hazed_image_dcp_vec = reshape(hazed_image_dcp,m*n,1);
hazed_image_mat = reshape(hazed_image,m*n,3);

%%finding the indices of the top 10 percent in the dcp
[hazed_image_dcp_vec_sorted,indices] = sort(hazed_image_dcp_vec);
num_of_pixels_top_percentage = floor(length(hazed_image_dcp_vec_sorted)/1000);
indices_top_percentage = indices(length(hazed_image_dcp_vec_sorted)-num_of_pixels_top_percentage+1:end);

maxx = 0;

for i = 1:length(indices_top_percentage)
    
      %%sum of all colors values in the selected indices
      color_sum = sum(hazed_image_mat(indices_top_percentage(i),:));
      
      %%finding the index with the highest sum
      if color_sum > maxx
        maxx = color_sum; 
        indices_top_percentage_max = indices_top_percentage(i);
      end
   
end

%%defining the atmospheric light according to the selected index values
A = hazed_image_mat(indices_top_percentage_max,:);

end

