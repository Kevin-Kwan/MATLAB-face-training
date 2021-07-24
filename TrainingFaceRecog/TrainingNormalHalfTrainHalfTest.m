%% Fine Tuning A Deep Neural Network
% This example shows how to fine tune a pre-trained deep convolutional
% neural network (CNN) for a new recognition task.
%
% Copyright 2017 The MathWorks, Inc.
%% Load Image Data
% Data is 5 different categories of automobiles. How do we read in all ofnumel(pristineImages.Files)
% these images?
% Create an imageDataStore to read images. Label all images based on their
% foldernames and include all subfolders in the directory

% Load in input images
imds = imageDatastore('../Faces/', 'IncludeSubfolders',true,...
    'LabelSource','FolderNames');

imds.countEachLabel

%% Visualize random images from the set
% We can visually inspect individual images
visImds = splitEachLabel(imds,1,'randomize');

for ii = 1:6
    
    subplot(2,3,ii);
    imshow(visImds.readimage(ii));
    title(char(visImds.Labels(ii)));
    
end

%% Partition the data into a train and test set
% We can specify a custom read function which is great for non-standard
% datatypes, and to do any preprocessing of data we wish to do on each
% image
imds.ReadFcn = @readAndPreprocessImage;
% We will use 50% of images per category to train, and specify 50% as a
% validation set to test our network after it has been trained. We want to
% see how accurate our network is on data it has never seen before.
[trainDS,testDS] = splitEachLabel(imds,.5,'randomize',true);

tbl = countEachLabel(trainDS);
%display each label and the number of images in each category
tbl %#ok

%% Look at structure of pre-trained network
net = alexnet;
% Notice the last layer performs 1000 object classification
layers = net.Layers %#ok

%% Or even inspect the types of object this network was trained on
layers(25).ClassNames' %#ok we want to display this in command window

%% Alter network to fit our desired output
% The pre-trained layers at the end of the network are designed to classify
% 1000 objects. But we need to classify different objects now. So the
% first step in transfer learning is to replace alter just two of the layers of the
% pre-trained network with a set of layers that can classify 5 classes.

% Get the layers from the network. The layers define the network
% architecture and contain the learned weights. Here we only alter two of
% the layers. Everything else stays the same.

num_objects = height(trainDS.countEachLabel);

layers(23) = fullyConnectedLayer(num_objects, 'Name','fc8');
layers(25) = classificationLayer('Name','myNewClassifier')


%% Setup learning rates for fine-tuning
% For fine-tuning, we want to changed the network ever so slightly. How
% much a network is changed during training is controlled by the learning
% rates. Here we do not modify the learning rates of the original layers,
% i.e. the ones before the last 3. The rates for these layers are already
% pretty small so they don't need to be lowered further. You could even
% freeze the weights of these early layers by setting the rates to zero.
%
% Instead we boost the learning rates of the new layers we added, so that
% they change faster than the rest of the network. This way earlier layers
% don't change that much and we quickly learn the weights of the newer
% layer.

% fc 8 - bump up learning rate for last layers
layers(end-2).WeightLearnRateFactor = 10;
layers(end-2).BiasLearnRateFactor = 20;


% We want the last layer to train faster than the other layers because 
% bias the training proces to quickly improve the last layer and keep the
% other layers relatively unchanged
%% When the network is training, how can we see inside?
% CNNs are historically fairly black box solutions, but we want insight into
% the training

% Let's look at some options:

% Plot the accuracy as we are training

% Stop training based on certain criteria


%% Visualize training in progress
% Set up a callback that will show the progress of training and allow for a
% custom halting condition

functions = { ...
    @plotTrainingAccuracy, ...
    @(info) stopTrainingAtThreshold(info,99.5)};


%% Fine-tune the Network

miniBatchSize = 16; % number of images it processes at once
maxEpochs = 20; % one epoch is one complete pass through the training data
% lower the batch size if your GPU runs out of memory

opts = trainingOptions('sgdm', ...
    'Verbose', true, ...
    'LearnRateSchedule', 'none',...
    'InitialLearnRate', 0.0001,... 
    'MaxEpochs', maxEpochs, ...
    'MiniBatchSize', miniBatchSize,...
    'OutputFcn',functions);

figure;
tic
disp("Initialization may take up to a minute before training begins")
net = trainNetwork(trainDS, layers, opts);
toc
 
%% Test new classifier on validation set
% Now run the network on the test data set to see how well it does

% If you get an out of memory error for the GPU, please lower the
% 'MiniBatchSize' to a lower value. 

% Please note: this will take a while to run. 
testNetwork = false;

if testNetwork
    % If you want, you can slim down the test set
    % testDS = testDS.splitEachLabel(5);
    
    tic
    [labels,err_test] = classify(net, testDS, 'MiniBatchSize', 64);
    toc
else % all of the test images have been classified and saved in a mat file:
    load savedLabels
    
randNum = randi(length(testDS.Files));
im_display = imread(testDS.Files{randNum});

im = readAndPreprocessImage(testDS.Files{randNum}) ;
[label,conf] = classify(net,im); % classify with deep learning 
imshow(im_display);
title(sprintf('%s %.2f', char(label),max(conf)));

end