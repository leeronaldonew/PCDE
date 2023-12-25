% Converting XCAT Phantom into Input data for dPETSTEP

function [data_XCAT,frame_XCAT,scaleFactor_XCAT]=XCAT_to_dPETSTEP(Act_XCAT,Atn_XCAT,Pixs,PI_Times)


load data_ex_dPETSTEP_dynamicImage.mat

s=data;

% Attenuation Map Info
s(1).data=Atn_XCAT;
s(1).dataInfo.grid1Units=Pixs(1);
s(1).dataInfo.grid2Units=Pixs(2);
s(1).dataInfo.grid3Units=Pixs(3);
s(1).dataInfo.sizeOfDimension1=size(Atn_XCAT,1);
s(1).dataInfo.sizeOfDimension2=size(Atn_XCAT,2);
s(1).dataInfo.sizeOfDimension3=size(Atn_XCAT,3);

% PET True Image Info
s(3).data=Act_XCAT;
s(3).dataInfo.grid1Units=Pixs(1);
s(3).dataInfo.grid2Units=Pixs(2);
s(3).dataInfo.grid3Units=Pixs(3);
s(3).dataInfo.sizeOfDimension1=size(Act_XCAT,1);
s(3).dataInfo.sizeOfDimension2=size(Act_XCAT,2);
s(3).dataInfo.sizeOfDimension3=size(Act_XCAT,3);
s(3).dataInfo.sizeOfDimensionTime=size(PI_Times,1)-1;

% data 
data_XCAT=s;

% scaleFactor
scaleFactor_XCAT=100000;
% Frames [sec]
frame_XCAT=PI_Times;

% PostFilter Z
%Postfilter_Z=[1 2 1]/4;


end

