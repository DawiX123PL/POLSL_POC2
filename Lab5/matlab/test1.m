clear all
close all
clc

I = imread("..\tarcza\z3.jpg");
I = rgb2gray(I);
I = adapthisteq(I);
I = imfilter(I, fspecial("gaussian", 5, 1));
I = imbinarize(I, 0.9);
I = ~I;

imshow(I);

I1 = bwlabel(I);
props = find_props_with_max(regionprops(I, "All"));
center = props.Centroid;

count = find_teeth_count(I, center, props)




imshow(label2rgb(I1));
hold on
viscircles(center, props.MinorAxisLength/2);
viscircles(center, props.MajorAxisLength/2);
viscircles(center, props.MajorAxisLength/2 * 0.96);


function prop = find_props_with_max(props)
    [~, index] = max([props.Area]);
    prop = props(index);
end


function prop = find_props(I)
    [~, index] = max([props.Area]);
    prop = props(index);
end


function count = find_teeth_count(I, center, props)
    
   big_r = (props.MajorAxisLength/2)
   small_r = big_r * 0.96;

   [X,Y] = meshgrid(1:size(I,2),1:size(I,1));
   X = X - center(1);
   Y = Y - center(2);
   Circle = (X.^2 + Y.^2) < (small_r^2);
   I1 = I & ~Circle;

   count = length(regionprops(I1));

end















