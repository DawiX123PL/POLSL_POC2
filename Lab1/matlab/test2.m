

I = [0,1,0,0
    0,0,0,0
    0,0,1,0
    0,0,0,0
    0,1,0,0]

I1(:,:,1) = I;
I1(:,:,2) = I;
I1(:,:,3) = I;

tic
num2cell(I1, [3])
toc

