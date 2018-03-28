clc;
clear all;
close all;
warning off;

cats = {'CM', 'CMM', 'P1', 'P2', 'P3', 'P3M1','P4', 'P4G',...
    'P4M', 'P6','P6M', 'P31M','PG', 'PGG','PM', 'PMG', 'PMM' };

% numIters = 5;
dataDir= './data/wallpapers/';
trainDir= './data/wallpapers/train';
testDir = './data/wallpapers/test';
mkdir(dataDir,'train_128');
mkdir(dataDir,'test_128');
train_128Dir = './data/wallpapers/train_128';
test_128Dir = './data/wallpapers/test_128';
for j=1:numel(cats)
%     for i=1:numIters
        currentFdr = cats{j};
        mkdir(train_128Dir,currentFdr);
        sourceFiles_train = dir([trainDir,'/',currentFdr,'/*png']);
        for k=1:length(sourceFiles_train)
            filename = strcat(trainDir,'/',currentFdr,'/',sourceFiles_train(k).name);
            input_im = imread(filename);
            im_out = imresize(input_im,0.5);      
            out_filename = strcat(train_128Dir,'/',currentFdr,'/',currentFdr,'_',num2str(k),'.png');
            imwrite(im_out, out_filename);
        end
%     end
end
fprintf('Done with train Images. Now resizing the test images');
for j=1:numel(cats)
%     for i=1:numIters
        currentFdr = cats{j};
        mkdir(test_128Dir,currentFdr);
        sourceFiles_test = dir([testDir,'/',currentFdr,'/*png']);
        for k=1:length(sourceFiles_test)
            filename = strcat(testDir,'/',currentFdr,'/',sourceFiles_test(k).name);
            input_im = imread(filename);
            im_out = imresize(input_im,0.5);      
            out_filename = strcat(test_128Dir,'/',currentFdr,'/',currentFdr,'_',num2str(k),'.png');
            imwrite(im_out, out_filename);
        end
%     end
end

            