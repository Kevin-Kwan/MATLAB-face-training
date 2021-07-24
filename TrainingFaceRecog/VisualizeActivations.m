%% Visualize Activations of the network

load trainedNet48_test.mat
load testIm.mat

figure;
imshow(testIm(120:end,:,:));
title('Test Image');
%% Here is the output after the first convolution in the network
act1 = activations(net,testIm,'conv1','OutputAs','channels');
visActivations(act1);
title('after convolutions with filters');

%% Here is the output after the second or third (or more) convolution in the network
% simply change the third input to 'conv2' 'conv3' 'conv4' or 'conv5'
act2 = activations(net,testIm,'conv4','OutputAs','channels');
visActivations(act2);
title('after later convolutions');

%% Search for a feature that's being activated 
% for example, let's find a channel that activates the wheels
figure;
act2 = activations(net,testIm,'relu4','OutputAs','channels');
subplot(1,2,2);
visActivations(act2,73);
title('Specific activation output');
subplot(1,2,1);
imshow(testIm);
title('Test image');

%% And Finally, we can test on a new image to verify our 
% assumption that this is looking for wheels
% try this on a new image
figure;
act2 = activations(net,newIm,'relu4','OutputAs','channels');
subplot(1,2,2);
visActivations(act2,73);
title('Specific activation output');
subplot(1,2,1);
imshow(newIm);
title('Different image');

%% This type of exploration is great for convolutions, 
% but tends to break down as the layers get more complex...
deep_layer = activations(net,testIm,'fc6','OutputAs','channels');
visActivations(deep_layer);
title('Activation after deeper layer');

%% Show deep dream doc - first 
doc nnet
%% Try out on our images!
figure;

tic
for ii = 1:5
    I = deepDreamImage(net,25,ii,'verbose',false);
    subplot(2,3,ii);
    imshow(I);
    title(net.Layers(27).ClassNames{ii});
    drawnow;
end
toc

