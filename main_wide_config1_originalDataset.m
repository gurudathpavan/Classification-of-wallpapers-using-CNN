 %% Wide network training
clc;
clear all;
close all; 

dataDir= './data/wallpapers/';
checkpointDir = 'modelCheckpoints_wide_TransferLearning_BC';

rng(1) % For reproducibility
Symmetry_Groups = {'P1', 'P2', 'PM' ,'PG', 'CM', 'PMM', 'PMG', 'PGG', 'CMM',...
    'P4', 'P4M', 'P4G', 'P3', 'P3M1', 'P31M', 'P6', 'P6M'};

train_folder = 'train_128';
test_folder  = 'test_128';

fprintf('Loading Train Filenames and Label Data...'); t = tic;
train_all = imageDatastore(fullfile(dataDir,train_folder),'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
train_all.Labels = reordercats(train_all.Labels,Symmetry_Groups);

%% Creation of Validation dataset

[train, val] = splitEachLabel(train_all,.9);
fprintf('Done in %.02f seconds\n', toc(t));

fprintf('Loading Test Filenames and Label Data...'); t = tic;
test = imageDatastore(fullfile(dataDir,test_folder),'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
test.Labels = reordercats(test.Labels,Symmetry_Groups);
fprintf('Done in %.02f seconds\n', toc(t));

%% Training the model with Learning Rate 0.001

rng('default');
numEpochs = 5;
batchSize = 50;
nTraining = length(train.Labels);

% layers = [
%     imageInputLayer([128 128 1]); % Input to the network is a 256x256x1 sized image 
%     convolution2dLayer(5,40,'Padding',[2 2],'Stride', [1,1]);  % convolution layer with 20, 5x5 filters
%     reluLayer();  % ReLU layer
%     maxPooling2dLayer(2,'Stride',1); % Max pooling layer
%     convolution2dLayer(3,80,'Padding',[1 1],'Stride', [1,1]);  % convolution layer with 40, 3x3 filters
%     reluLayer();  % ReLU layer
%     maxPooling2dLayer(2,'Stride',2); % Max pooling layer
%     fullyConnectedLayer(100); % Fullly connected layer with 50 activations
%     dropoutLayer(.25); % Dropout layer
%     fullyConnectedLayer(17); % Fully connected with 17 layers
%     softmaxLayer(); % Softmax normalization layer
%     classificationLayer(); % Classification layer
%     ];

%% Obtain checkpoint for transfer learning

load('wide_BC_latest_checkpoint.mat');

if ~exist(checkpointDir,'dir'); mkdir(checkpointDir); end
% Set the training options
options = trainingOptions('sgdm','MaxEpochs',20,... 
    'InitialLearnRate',1e-3,...% learning rate
    'CheckpointPath', checkpointDir,...
    'MiniBatchSize', batchSize, ...
    'MaxEpochs',numEpochs);
    % uncommand and add the line below to the options above if you have 
    % version 17a or above to see the learning in realtime
    %'OutputFcn',@plotTrainingAccuracy,... 

% Train the network, info contains information about the training accuracy
% and loss
 t = tic;
[net1,info1] = trainNetwork(train,net.Layers,options);
fprintf('Trained in in %.02f seconds\n', toc(t));

%% Plotting Error Plot

error_plot = figure;
plotTrainingAccuracy_All(info1,numEpochs);
saveas(error_plot, ['BC_LearningTransfer_Wide_Error_plot_',num2str(numEpochs),'.png']);

%% Test on the training data

YTrain = classify(net1,train);
train_acc = mean(YTrain==train.Labels);

con_mat_train = confusionmat(sort(grp2idx(train.Labels)), sort(grp2idx(YTrain)));
class_mat_train = con_mat_train./(meshgrid(countcats(train.Labels))');

filename = ['BC_LearningTransfer_Training_Confusion_Mat_Wide_', num2str(numEpochs), '.xlsx'];
xlswrite(filename, con_mat_train,'Sheet1','A1');

filename = ['BC_LearningTransfer_Training_Classification_Mat_Wide_', num2str(numEpochs), '.xlsx'];
xlswrite(filename, class_mat_train,'Sheet1','A1');

%% Test on the validation data 

YVal = classify(net1,val);
val_acc = mean(YVal==val.Labels);

con_mat_val = confusionmat(sort(grp2idx(val.Labels)), sort(grp2idx(YVal)));
class_mat_val = con_mat_val./(meshgrid(countcats(val.Labels))');

filename = ['BC_LearningTransfer_Validation_Confusion_Mat_Wide_', num2str(numEpochs), '.xlsx'];
xlswrite(filename, con_mat_val,'Sheet1','A1');

filename = ['BC_LearningTransfer_Validation_Classification_Mat_Wide_', num2str(numEpochs), '.xlsx'];
xlswrite(filename, class_mat_val,'Sheet1','A1');

%% Test on the Test data

YTest = classify(net1,test);
test_acc = mean(YTest==test.Labels);

con_mat_test = confusionmat(sort(grp2idx(test.Labels)), sort(grp2idx(YTest)));
class_mat_test = con_mat_test./(meshgrid(countcats(test.Labels))');

filename = ['BC_LearningTransfer_Testing_Confusion_Mat_Wide_', num2str(numEpochs), '.xlsx'];
xlswrite(filename, con_mat_test,'Sheet1','A1');

filename = ['BC_LearningTransfer_Testing_Classification_Mat_Wide_', num2str(numEpochs), '.xlsx'];
xlswrite(filename, class_mat_test,'Sheet1','A1');

%% Visualization using DeepDreamImage

visualize_ddi = net1.Layers(2,1).NumFilters;

cv_layer = deepDreamImage(net1,2,visualize_ddi);

figure;
montage(cv_layer);
title('First Convolutional Layer');