clc;
clear all;
close all;
warning off;

cats = {'CM', 'CMM', 'P1', 'P2', 'P3', 'P3M1','P4', 'P4G',...
    'P4M', 'P6','P6M', 'P31M','PG', 'PGG','PM', 'PMG', 'PMM' };

% numIters = 5;
dataDir= './data/wallpapers/';
trainDir= './data/wallpapers/train_aug';
testDir = './data/wallpapers/test_aug';
mkdir(dataDir,'train_alex');
mkdir(dataDir,'test_alex');
train_alexDir = './data/wallpapers/train_alex';
test_alexDir = './data/wallpapers/test_alex';
for j=1:numel(cats)
%     for i=1:numIters
        currentFdr = cats{j};
        mkdir(train_alexDir,currentFdr);
        sourceFiles_train = dir([trainDir,'/',currentFdr,'/*png']);
        for k=1:length(sourceFiles_train)
            filename = strcat(trainDir,'/',currentFdr,'/',sourceFiles_train(k).name);
            input_im = imread(filename);
            im_out = imresize(input_im,[227, 227]); 
            im_out_rgb = repmat(im_out,[1,1,3]);
            
            out_filename = strcat(train_alexDir,'/',currentFdr,'/',currentFdr,'_',num2str(k),'.png');
            imwrite(im_out_rgb, out_filename);
        end
%     end
end
fprintf('Done with train Images. Now resizing the test images');

for j=1:numel(cats)
%     for i=1:numIters
        currentFdr = cats{j};
        mkdir(test_alexDir,currentFdr);
        sourceFiles_test = dir([testDir,'/',currentFdr,'/*jpg']);
        for k=1:length(sourceFiles_test)
            filename = strcat(testDir,'/',currentFdr,'/',sourceFiles_test(k).name);
            input_im = imread(filename);
            
            im_out = imresize(input_im,[227, 227]); 
            im_out_rgb = repmat(im_out,[1,1,3]);
            
            out_filename = strcat(test_alexDir,'/',currentFdr,'/',currentFdr,'_',num2str(k),'.png');
            imwrite(im_out_rgb, out_filename);
        end
%     end
end
fprintf('Done');
 





            