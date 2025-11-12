clear;
clc;

data = readmatrix('vozlisca_temperature_dn2_23.txt', 'NumHeaderLines', 4);

x = data(:,1); % x-koodrinate vozlisc
y = data(:,2); % y-koordinate vozlisc
T = data(:,3); % TEMPERATURA

% Preberemo celice
cells = readmatrix('celice_dn2_23.txt', 'NumHeaderLines', 2);

tic;
%interpoliramo celice
T_xy = scatteredInterpolant(x, y, T);

%izpis 1. interpolacije
T_xy(0.403, 0.503);

CasPrveInterpolacije=toc
%----------------------------
tic
%Intepolacija po 2. metodi


x_center=0.403;
y_center = 0.503; % Define the y-coordinate for interpolation

dx=0.05;
dy=0.05;

idx= (x >= x_center - dx) & (x <= x_center + dx) & (y >= y_center - dy) & (y <= y_center + dy);

x_manj=x(idx);
y_manj=y(idx);
T_manj=T(idx);

unique_x = unique(x_manj);
unique_y = unique(y_manj);
nx=numel(unique_x);
ny=numel(unique_y);

[X, Y]=meshgrid(unique_x, unique_y);
Tgrid=reshape(T_manj, [ny, nx]);
Txy2=griddedInterpolant(X', Y', Tgrid');

Txy2(0.403, 0.503);

CasDrugeInterpolacije=toc

%}

%----------------------------

%3. interpolacija

tic;

xx=0.403;
yy=0.503;

for i = 1:size(cells, 1)
    cell=cells(i, :);

    cell_point1 = cell(1);
    cell_point2 = cell(2);
    cell_point3 = cell(3);
    cell_point4 = cell(4);

    x1 = x(cell_point1);
    x2 = x(cell_point2);
    x3 = x(cell_point3);
    x4 = x(cell_point4);

    y1 = y(cell_point1);
    y2 = y(cell_point2);
    y3 = y(cell_point3);
    y4 = y(cell_point4);

    T1=T(cell_point1);
    T2=T(cell_point2);
    T3=T(cell_point3);
    T4=T(cell_point4);

    if x1 < xx & x2 > xx & y1 < yy & y3 > yy
        break
    end

end

K1 = ((x2 - xx)/(x2 - x1)) * T1 + ((xx - x1)/(x2 - x1)) * T2;
K2 = ((x2 - xx)/(x2 - x1)) * T3 + ((xx - x1)/(x2 - x1)) * T4;

Txy = ((y3 - yy)/(y3 - y1)) * K1 + ((yy - y1)/(y3 - y1)) * K2;

CasTretjeInterpolacije=toc




[max_T, idx] = max(T);  % idx is the index of the max
max_x = x(idx);
max_y = y(idx);

fprintf('Najvišja temperatura v polju je %.2f v točki (%.2f, %.2f)\n', max_T, max_x, max_y);
