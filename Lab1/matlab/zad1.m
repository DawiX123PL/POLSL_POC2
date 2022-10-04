clear all
close all
clc


images = [
        "baboon_512x512.bmp"
        "bangko_13_512x512.png"
        "frymire_512x512.png"
        "kodim23_512x512.png"
        "lena_512x512.bmp"
        "peppers3_512x512.bmp" 
        ];

images_path = "../images/"

mkdir("../zad1");
mkdir("../zad1/gray");
mkdir("../zad1/rgb");


for image_name = images'

    convert_image(images_path, image_name, 0.01)
    convert_image(images_path, image_name, 0.02)
    convert_image(images_path, image_name, 0.10)

end



function convert_image(images_path, image_name, d)

    I = imread(images_path + image_name);

    I_rgb = imnoise(I,"salt & pepper", 0.01);
    I_gray = imnoise( rgb2gray(I),"salt & pepper", 0.01);

    rbg_path = "../zad1/rgb/" + string(d) + "/"
    gray_path = "../zad1/gray/" + string(d) + "/"

    mkdir(rbg_path);
    mkdir(gray_path);

    name = rbg_path + image_name
    imwrite(I_rgb,name);

    name = gray_path + image_name
    imwrite(I_gray,name);


end
















