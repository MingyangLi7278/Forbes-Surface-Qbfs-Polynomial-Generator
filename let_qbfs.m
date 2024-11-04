%该文档用于生成Qbfs多项式，并将其保存方便以后直接调用
% 清理环境
clear; clc;

% 模型参数
n = 10; % 与 m 相同

% 定义符号变量
syms x;

% 递归函数初始条件
P = cell(n, 1); % P_n(x)
P{1} = 2;
P{2} = 6 - 8*x;

% 递归关系生成 P
for m = 3:n
    P{m} = (2 - 4*x) * P{m-1} - P{m-2};
end

% 初始向量
f = [2, sqrt(19)/2];
g = [-1/2];
h = [];

% 计算 f, g, h
for m = 3:n
    h = [h, -((m - 1) * (m - 2)) / (2 * f(m - 2))];
    g = [g, -(1 + g(m - 2) * h(m - 2)) / f(m - 1)];
    f = [f, sqrt((m - 1) * m + 3 - g(m - 1)^2 - h(m - 2)^2)];
end

% 生成 Q1
Q1 = cell(1, n); 
Q1{1} = 1;
Q1{2} = (13 - 16*x) / sqrt(19);
for m = 3:n
    Q1{m} = simplify((P{m} - g(m-1) * Q1{m-1} - h(m-2) * Q1{m-2}) / f(m));
end
disp(Q1)
% 保存 Q1 为 .mat 文件
save('Q1_polynomialshei.mat', 'Q1');
