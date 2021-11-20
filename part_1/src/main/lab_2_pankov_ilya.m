% Лабораторная работа №2
clc; close all; clear;
load('../../input_1.txt');
load('../../input_2.txt');
load('../../input_3.txt');

%% Задание 1. Преобразование оси и угла в кватернион

axang = input_1;

ax = axang(:, 1 : 3);
ang = axang(:, 4);
q = ax_ang_to_quat(ax, ang);

quat = axang2quat(axang);

% Проверка совпадения результатов
max_error = max(norm(quaternion(quat) - quaternion(q)));

id = fopen('../../output_1.txt', 'wt');
for idx = 1 : size(input_1, 1)
    fprintf(id, '1.%d.\tq    = [ ', idx);
    fprintf(id, '%7.4f, ', q(idx, 1 : end - 1));
    fprintf(id, '%7.4f', q(idx, end));
    fprintf(id, ' ]\n\tquat = [ ');
    fprintf(id, '%7.4f, ', quat(idx, 1 : end - 1));
    fprintf(id, '%7.4f', quat(idx, end));
    fprintf(id, ' ]\n\n');
end
fprintf(id, '\tmax_error = %f', max_error);
fclose(id);

%% Задание 2. Преобразование кватерниона в матрицу поворота

quat = input_2;

q = quat;
r = quat_to_rotm(q);

rotm = quat2rotm(quat);

error = zeros(size(input_2, 1), 1);
for idx = 1 : size(input_2, 1)
    error(idx) = norm(rotm(:, :, idx) - r(:, :, idx));
end
max_error = max(error);

id = fopen('../../output_2.txt', 'wt');
for idx = 1 : size(input_2, 1)
    fprintf(id, '1.%d.\tr    = [ ', idx);
    fprintf(id, '%7.4f ', r(1, :, idx));
    fprintf(id, '\n\t\t ');
    fprintf(id, '%7.4f ', r(2, :, idx));
    fprintf(id, '\n\t\t ');
    fprintf(id, '%7.4f ', r(3, :, idx));
    fprintf(id, ']\n\trotm = [ ');
    fprintf(id, '%7.4f ', rotm(1, :, idx));
    fprintf(id, '\n\t\t ');
    fprintf(id, '%7.4f ', rotm(2, :, idx));
    fprintf(id, '\n\t\t ');
    fprintf(id, '%7.4f ', rotm(3, :, idx));
    fprintf(id, ']\n\n');
end
fprintf(id, '\tmax_error = %f', max_error);
fclose(id);

%% Задание 3. Преобразование матрицы поворота в ось и угол

temp = reshape(reshape(input_3', 3, size(input_3, 1)), 3, 3, size(input_3, 1) / 3);
for idx = 1 : size(input_3, 1) / 3
    rotm(:, :, idx) = temp(:, :, idx)';
end

r = rotm;
[ax, ang] = rotm_to_ax_ang(r);

axang = rotm2axang(rotm);

% Проверка совпадения результатов
max_error = max(norm(axang - [ax, ang]));

id = fopen('../../output_3.txt', 'wt');
for idx = 1 : size(input_3, 1) / 3
    fprintf(id, '1.%d.\tax, ang = [ ', idx);
    fprintf(id, '%7.4f, ', ax(idx, 1 : end - 1));
    fprintf(id, '%7.4f ],%7.4f', ax(idx, end), ang(idx));
    fprintf(id, '\n\taxang   = [ ');
    fprintf(id, '%7.4f, ', axang(idx, 1 : end - 1));
    fprintf(id, '%7.4f', axang(idx, end));
    fprintf(id, ' ]\n\n');
end
fprintf(id, '\tmax_error = %f', max_error);
fclose(id);
