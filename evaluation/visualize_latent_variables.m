
segShift = 0;
segWidth = 20;

baseFile = 'uniform_20_0';
baseFolder = fullfile(pwd,'CAD120/segmentation_lists');
path = fullfile(baseFolder,baseFile);
[trainData,testData] = load_CAD120('tfeat_on',train_sid,path);

data = trainData;

pred_labels = cell(size(data.patterns)); % predicted labels
pred_Zlabels = cell(size(data.patterns)); % predicted labels
X = data.patterns;
for j = 1 : length(data.patterns)
  x = X{j};
  [yhat,zhat] = ssvm_classify(params, model, x);
  pred_labels{j} = yhat';
  pred_Zlabels{j} = zhat';
end

%%
v = 28;

vid = data.vidID(v);
gtlabels = data.labels{v};
labels = pred_labels{v};
zlabels = pred_Zlabels{v};
numSegments = length(labels);

imDir = '~/Downloads';
cmd = sprintf('ls -v %s/Subject*/*/%010d/RGB*.png',imDir,vid);
[~,str] = system(cmd);
images = textscan(str,'%s');
images = images{1};
len = length(images);

sampledFrame = images(segShift + round(segWidth / 2) : segWidth : end);
sampledFrame{end+1} = images{end};

% activity string for uniform segmentation
strLabels = {'reaching', 'moving', 'pouring', 'eating', 'drinking', 'opening', 'placing', 'closing', 'null', 'scrubbing'};

numSegments 
length(sampledFrame)

for i = 1 : length(labels)
  
  imshow(sampledFrame{i})
  title([strLabels{labels(i)},' ',num2str(zlabels(i)),' ',strLabels{gtlabels(i)}])
  drawnow
  waitforbuttonpress
  
end


