function act1 = visActivations(input,number)

if nargin == 1
number = -1;
end

sz = size(input);
if number < 0 
    act1 = reshape(input,[sz(1) sz(2) 1 sz(3)]);
    figure; montage(imresize(mat2gray(act1(:,:,:,:)),[48 48]))
else
    
    act1 = reshape(input,[sz(1) sz(2) 1 sz(3)]);
    montage(imresize(mat2gray(act1(:,:,:,number)),[48 48]))
end



end