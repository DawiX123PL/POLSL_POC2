clear all
close all
clc




destination = "../images_gen";
mkdir(destination);

for i = 1:100;

    translation = (rand(1,2) - .5) * 200
    rotation = rand(1) * 360
    scale = rand(1,2) * .3 + .5

    I1 = g_circles(translation, rotation, scale);

    filename = destination + "/circ" + string(i) + ".png";
    imwrite(I1, filename);

end




















