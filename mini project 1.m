% Project Title: Geometric imaging model - Depth measurement
% Author: Hesamoddin Hosseini
% Contact: hesamoddin.hosseini@mail.um.ac.ir
% Websit:http://hesamoddin.hosseini.student.um.ac.ir

clear;
%unit: Millimeter
b = 310;
Zo = 2350;
Zk = 1200;
sensor_width = 22.3;

%get first image

img1 = imread('D:/sample1.jpg');

figure
subplot(2,2,1); imshow(img1,[]); title('image 1');
img1_bw = im2bw(img1);

[img_height, img_width] = size(img1_bw);

subplot(2,2,2); imshow(img1_bw,[]); title('image 1 binary');

[row,column] = find(img1_bw == 1);
row_avg_1 = sum(row)/length(row);
col_avg_1 = sum(column)/length(column);

%get second image

img2 = imread('D:/sample2.jpg');
subplot(2,2,3); imshow(img2,[]); title('image 2');
img2_bw = im2bw(img2);
subplot(2,2,4); imshow(img2_bw,[]); title('image 2 binary');

[row,column] = find(img2_bw == 1);
row_avg_2 = sum(row)/length(row);
col_avg_2 = sum(column)/length(column);

%Calculate Parameters
d = abs(col_avg_2 - col_avg_1) * (sensor_width / img_width);

D = ((Zo - Zk) * b) / Zo;

f = (Zk * d) / D

%Depth measurement

img_target = imread('D:/target.jpg');
img_target_bw = im2bw(img_target);
figure
imshow(img_target_bw,[]); title('image target binary');

[row,column] = find(img_target_bw == 1);
row_avg_target = sum(row)/length(row);
col_avg_target = sum(column)/length(column);

%Calculate Parameters

d = abs(col_avg_target - col_avg_2) * (sensor_width / img_width);

Zk = Zo / (1 + ((Zo * d) / (f * b)))