function I1 = image_ifft(L1)

    I1 = ifft2(ifftshift(L1));
    I1 = abs(I1);

end