numStateZ = 1;

C = 0.3;
E = 0.25;
W = 3;
tfeat = 'tfeat_on';
thres = 1;
initStrategy = 'clustering';
iter = 3;

disp('Z1')
Z1 = [];
for corruptPercentage = 0.2:0.1:0.8
  filebase = sprintf('Z%d_cp_%02f_C%.2f_E%.2f_W%d_%s_Thre%.1f_%s_iter%d.mat',numStateZ,corruptPercentage,C,E,W,tfeat,thres,initStrategy,iter);
  load(filebase)
  fscore = 2*prec.*recall./(prec+recall);
  m = nanmean(fscore(:));
  s = nanstd(fscore(:));
  a = results.meanTest;
  Z1 = [Z1;[m,s,a]];
end

disp('Z2')
numStateZ = 2;
Z2 = [];
for corruptPercentage = 0.2:0.1:0.8
  filebase = sprintf('Z%d_cp_%02f_C%.2f_E%.2f_W%d_%s_Thre%.1f_%s_iter%d.mat',numStateZ,corruptPercentage,C,E,W,tfeat,thres,initStrategy,iter);
  load(filebase)
  fscore = 2*prec.*recall./(prec+recall);
  m = nanmean(fscore(:));
  s = nanstd(fscore(:));
  a = results.meanTest;
  Z2 = [Z2;[m,s,a]];
end

hold off
% errorbar(Z1(:,1),Z1(:,2));
plot(0.2:0.1:0.8,Z1(:,1)*100)
hold on
% errorbar(Z2(:,1),Z2(:,2),'r')
plot(0.2:0.1:0.8,Z2(:,1)*100,'r')
axis([0,1,0,100])
legend('Z1','Z2')