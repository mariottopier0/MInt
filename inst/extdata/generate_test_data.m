rng('default')
old = cd(fileparts(mfilename('fullpath')));

n = 80;
P = [1 0.8 0; 0.8 1 -0.4; 0 -0.4 1];
w = precSim(0.8*P,n);
b = [0.5 -0.25 0; 0 0.25 0.125];
intercept = [2 2 2];
feature1_vals = {'included', 'excluded'}';
feature2_vals = {'black', 'white'}';

f2 = feature2_vals( round(rand(n,1)) + 1);
onames = strtrim(cellstr(num2str([1:n]')));
x1 = cell2dataset( [feature1_vals( round(rand(n,1)) + 1), f2], 'ObsNames', onames, 'VarNames', {'feature1', 'feature2'});

y1 = poissrnd(exp( ones(n,3)*3.4 + oneHotEncode(x1, 'intercept', false)*b + w ));

Y = mat2dataset( y1, 'ObsNames', onames, 'VarNames', {'y1', 'y2', 'y3'});

export(x1, 'file', 'x.txt', 'delimiter', '\t');

export(Y, 'file', 'y.txt', 'delimiter', '\t');

dlmwrite('b_true.txt', [intercept; b]);
dlmwrite('w_true.txt', w);
dlmwrite('P_true.txt', P);


cd(old)