clc;
clear all;

filename = 'naloga1_1.txt';

t = importdata(filename, ' ', 2);

file_id = fopen('naloga1_2.txt');
line = fgetl(file_id);

n = split(line, ': ');
n = str2double(n(2));

P = [];
for i  = 2:1:n+1
    P = [P, str2double(fgetl(file_id))];
end

plot(t.data, P)
title('P(t)');
xlabel('t[s]');
ylabel('P[w]');


integral = P(1)+P(length(P));

for i = 2:1:length(P)
    integral = integral + 2 * P(i);
end

dt = t.data(2)-t.data(1);

integral = integral*dt*0.5;

trapez = trapz(P)*dt;

fprintf('Lasten izračunan integral je %f. \n', integral)
fprintf('Integral izračunan s trapezno metodo pa je %f.', trapez)