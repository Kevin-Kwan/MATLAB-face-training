function Iout = readAndPreprocessImage(filename)

I = imread(filename);

I = imresize(I,[114 227]);
altered_h = 227 - 114;

Iout = padarray(I,[altered_h 0],'pre');
end