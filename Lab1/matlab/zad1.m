clear all
close all
clc


images = [
        "baboon_512x512.bmp" ,      "img_1.png"
        "bangko_13_512x512.png",    "img_2.png"
        "frymire_512x512.png",      "img_3.png"
        "kodim23_512x512.png",      "img_4.png"
        "lena_512x512.bmp",         "img_5.png"
        "peppers3_512x512.bmp" ,    "img_6.png"
        ];

images_path = "../images/"

mkdir("../zad1");
mkdir("../zad1/gray");
mkdir("../zad1/rgb");


for image_name = images'

    convert_image(images_path, image_name, 0)
    convert_image(images_path, image_name, 0.01)
    convert_image(images_path, image_name, 0.02)
    convert_image(images_path, image_name, 0.10)

end



function convert_image(images_path, image_names, d)

    src = image_names(1);
    dst = image_names(2);

    I = imread(images_path + src);

    I_rgb = imnoise(I,"salt & pepper", d);
    I_gray = imnoise( rgb2gray(I),"salt & pepper", d);

    rbg_path = "../zad1/rgb/" + string(d) + "/"
    gray_path = "../zad1/gray/" + string(d) + "/"

    mkdir(rbg_path);
    mkdir(gray_path);

    name = rbg_path + dst;
    imwrite(I_rgb,name);

    name = gray_path + dst;
    imwrite(I_gray,name);


end
















