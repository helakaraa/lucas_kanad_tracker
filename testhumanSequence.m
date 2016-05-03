
clc
close all

load('trainperson.mat')

rect=[157 43 222 196];
% rect1=[254 62 279 153];
[m,n,channels,frames] = size(sequence);

width = abs(rect(1)-rect(3));
height = abs(rect(2)-rect(4));

% width1 = abs(rect1(1)-rect1(3));
% height1 = abs(rect1(2)-rect1(4));

coordinates=zeros(frames-1,4);

for i=1:frames-1
    img = im2double(sequence(:,:,:,i));

    imshow(img);
    hold on;
    rectangle('Position',[rect(1),rect(2),width ,height], 'LineWidth',2, 'EdgeColor', 'r')  
%     rectangle('Position',[rect1(1),rect1(2),width1 ,height1], 'LineWidth',2, 'EdgeColor', 'r')    

    hold off;
    pause(0.01); % 30 fps
    
    Itcurr = rgb2gray(im2double(sequence(:,:,:,i)));
    Itnext = rgb2gray(im2double(sequence(:,:,:,i+1)));
    [u,v] = LucasKanade(Itcurr,Itnext,rect);
%     [u1,v1] = LucasKanade(Itcurr,Itnext,rect1);
    rect=[rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
%     rect1=[rect1(1)+u rect1(2)+v rect1(3)+u rect1(4)+v];

%     coordinates1(i,:) = rect1;
    coordinates(i,:) = rect;
    %disp(['Frame ',num2str(i)]);
    rect = round(coordinates(i,:));
%     rect1=round(coordinates1(i,:));
end

close