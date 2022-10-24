function [im_level, im_angle, L1] = image_fft(I1)

    L1 = fftshift(fft2(I1));
    im_level = log(1+abs(L1));    
    im_angle = angle(L1);    

end