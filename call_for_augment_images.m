clc;
clear all;
close all;
warning off;

cats = {'CM', 'CMM', 'P1', 'P2', 'P3', 'P3M1','P4', 'P4G',...
    'P4M', 'P6','P6M', 'P31M','PG', 'PGG','PM', 'PMG', 'PMM' };

numIters = 5;
dataDir= './data/wallpapers/';
trainDir= './data/wallpapers/train';
mkdir(dataDir,'train_aug');
train_augDir = './data/wallpapers/train_aug';

for j=1:numel(cats)
    for i=1:numIters
        currentFdr = cats{j};
        mkdir(train_augDir,currentFdr);
        sourceFiles = dir([trainDir,'/',currentFdr,'/*png']);
        for k=1:length(sourceFiles)
            filename = strcat(trainDir,'/',currentFdr,'/',sourceFiles(k).name);
            input_im = imread(filename);
            [im_out,output_imgDetails(k).(cats{j}).rot(i),output_imgDetails(k).(cats{j}).scale(i),...
                output_imgDetails(k).(cats{j}).tran{i}] = augmentImage(input_im);      
            out_filename = strcat(train_augDir,'/',currentFdr,'/',currentFdr,'_',num2str(k),'_',num2str(i),'.png');
            imwrite(im_out, out_filename);
        end
    end
    j
end

rotation_data = ([]);
scaling_data = ([]);
translation_data = ([]);

for j = 1:length(cats)
    for k = 1:1000
        rotation_data = cat(2,rotation_data,output_imgDetails(k).(cats{j}).rot);
        scaling_data = cat(2,scaling_data,output_imgDetails(k).(cats{j}).scale);
        translation_data = cat(2,translation_data,output_imgDetails(k).(cats{j}).tran);
    end
end
%% Plotting Histograms
for i = 1:length(translation_data)
    X(i,1) = translation_data{i}(1);
    X(i,2) = translation_data{i}(2);
end
h=figure(1);
hist3(X);
title('Histogram of Translation');
xlabel('X-axis'); ylabel('Y-axis');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
saveas(h,'Histogram_of_Translation.png');

h=figure(2);
hist(rotation_data);
title('Histogram of Rotation');
xlabel('Rotation Data');
saveas(h,'Histogram_of_Rotation.png');

h=figure(3);
hist(scaling_data);
title('Histogram of Scaling');
xlabel('Scaling Data');
saveas(h,'Histogram_of_Scaling.png');            