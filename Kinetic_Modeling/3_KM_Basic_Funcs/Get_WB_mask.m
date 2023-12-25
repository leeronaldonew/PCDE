function [WB_mask, WB_mask_vector]=Get_WB_mask()

load('Vol_WB.mat');

size_origin=size(Vol_WB.Pass_1{1, 1});
vol=imresize3(Vol_WB.Pass_1{1, 1}, [round(size_origin(1)/2), round(size_origin(2)/2), round(size_origin(3)/2)], 'method', 'cubic');
Size_WB=size(vol);

msg = msgbox('Computing WB Mask! Wait a couple of minutes!');
initial_mask=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3)));
initial_mask(round(Size_WB(1)/4):(end-round(Size_WB(1)/4)), round(Size_WB(2)/4):(end-round(Size_WB(2)/4)), 60:(end-60))=1;

WB_mask = activecontour(vol,initial_mask, 400, 'Chan-Vese'); % using the first Pass WB data to make WB contours (256x256)
%WB_mask = activecontour(vol,initial_mask, 200, 'Chan-Vese'); % using the first Pass WB data to make WB contours (128x128)
%WB_mask = activecontour(vol,initial_mask, 1, 'Chan-Vese'); % using the first Pass WB data to make WB contours (256x256)

WB_mask_vector=reshape(WB_mask, 1,Size_WB(1)*Size_WB(2)*Size_WB(3));
% close the dialog box
close(msg);


end