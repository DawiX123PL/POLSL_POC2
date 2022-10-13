clear all
close all
clc



images = [
    "img1", "img_1.png"
]

convert_image(images(1,:));


function convert_image(names)

    dst_path = names(1);
    name = names(2)

    I1 = imread("../zad1/rgb/0/" + name);
    I1 = double(I1) / 255;

    I1_1 = imread("../zad1/rgb/0.01/" + name);
    I1_1 = double(I1_1) / 255;

    I1_2 = imread("../zad1/rgb/0.02/" + name);
    I1_2 = double(I1_2) / 255;

    I1_3 = imread("../zad1/rgb/0.1/" + name);
    I1_3 = double(I1_3) / 255;
    
    I2_1 = filter_VMF(I1_1,1); % 
    I2_2 = filter_VMF(I1_2,1); % 
    I2_3 = filter_VMF(I1_3,1); % 

    I3_1 = filter_VMF(I1_1,1); % 
    I3_2 = filter_VMF(I1_2,1); % 
    I3_3 = filter_VMF(I1_3,1); % 


    mkdir("../zad3b/" + dst_path);

    imwrite(I1, "../zad3b/" + dst_path + "/I1.png");

    imwrite(I1_1, "../zad3b/" + dst_path + "/I1_1.png");
    imwrite(I1_2, "../zad3b/" + dst_path + "/I1_2.png");
    imwrite(I1_3, "../zad3b/" + dst_path + "/I1_3.png");
    
    imwrite(I2_1, "../zad3b/" + dst_path + "/I2_1.png");
    imwrite(I2_2, "../zad3b/" + dst_path + "/I2_2.png");
    imwrite(I2_3, "../zad3b/" + dst_path + "/I2_3.png");
    
    imwrite(I3_1, "../zad3b/" + dst_path + "/I3_1.png");
    imwrite(I3_2, "../zad3b/" + dst_path + "/I3_2.png");
    imwrite(I3_3, "../zad3b/" + dst_path + "/I3_3.png");

end







