function labels = initByClustering(trainData)
% labels is a cell

X = trainData.patterns;
Y = trainData.labels;
XX = [];
YY = [];
NUM = [];
for i = 1 : length(trainData.patterns)
  x = X{i};
  y = Y{i};
  K = length(x) / trainData.DimX;
  x = reshape(x,trainData.DimX,K);
  XX = [XX,x];
  YY = [YY;y];
  NUM = [NUM;length(y)];
end

XX = XX';

IDX = kmeans(XX,params.numStateZ);
YZ = sub2indYZ(params,YY,IDX);

c = 0;
for i = 1 : length(params.patterns)
    
    labels{i} = YZ(c+1:c+NUM(i));
    c = c+NUM(i);

end

labels = labels';

end