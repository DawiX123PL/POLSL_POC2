clear all
close all
clc



destination = "../images_gen";
mkdir(destination);

for i = 1:20;

    translation = (rand(1,2) - .5) * 100
    rotation = rand(1) * 360
    scale = rand(1,2) * .5 + 2

    I1 = g_xd(translation, rotation, scale);

    
    filename = destination + "/xD" + string(i) + ".png";
    imwrite(I1, filename);

end



















