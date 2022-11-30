function [gamma,gamma_max_psnr_or_ssim] = gamma_selection(hazy_image,hazy_image_full_path)
%%defining gamma value in different ways

find_ideal_gamma = input("Do you want to find the ideal gamma? answer Y/N \n","s");

if find_ideal_gamma == 'Y'
    
    [gamma,gamma_max_psnr_or_ssim] = ideal_gamma(hazy_image,hazy_image_full_path); %%ideal gamma
    
elseif find_ideal_gamma == 'N'
        
    define_gamma = input("Do you want to define gamma? answer Y/N \n","s");

    if define_gamma == 'Y'

        gamma = input("Choose a value between 0 and 1 for gamma \n"); %%selected gamma

    elseif define_gamma == 'N'

        gamma = 0.3; %%default gamma
        
    else
        
        [gamma,gamma_max_psnr_or_ssim] = gamma_selection(hazy_image,hazy_image_full_path);
        
    end
    
gamma_max_psnr_or_ssim = NaN;   

else
    
    [gamma,gamma_max_psnr_or_ssim] = gamma_selection(hazy_image,hazy_image_full_path);
    
end


if gamma<0 || gamma>1
    
    fprintf('Gamma value is invalid. Please enter a new value or choose Gamma in a different way. \n')
    [gamma,gamma_max_psnr_or_ssim] = gamma_selection(hazy_image,hazy_image_full_path);
    
end

end

