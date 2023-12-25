%% XCAT_Read
clear
% P1
fileID=fopen('P1_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act1 = reshape(raw, [165,165,175]);
fileID=fopen('P1_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn1 = reshape(raw, [165,165,175]);
% P2
fileID=fopen('P2_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act2 = reshape(raw, [165,165,175]);
fileID=fopen('P2_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn2 = reshape(raw, [165,165,175]);
% P3
fileID=fopen('P3_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act3 = reshape(raw, [165,165,175]);
fileID=fopen('P3_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn3 = reshape(raw, [165,165,175]);
% P4
fileID=fopen('P4_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act4 = reshape(raw, [165,165,175]);
fileID=fopen('P4_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn4 = reshape(raw, [165,165,175]);
% P5
fileID=fopen('P5_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act5 = reshape(raw, [165,165,175]);
fileID=fopen('P5_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn5 = reshape(raw, [165,165,175]);
% P6
fileID=fopen('P6_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act6 = reshape(raw, [165,165,175]);
fileID=fopen('P6_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn6 = reshape(raw, [165,165,175]);
% P7
fileID=fopen('P7_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act7 = reshape(raw, [165,165,175]);
fileID=fopen('P7_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn7 = reshape(raw, [165,165,175]);
% P8
fileID=fopen('P8_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act8 = reshape(raw, [165,165,175]);
fileID=fopen('P8_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn8 = reshape(raw, [165,165,175]);
% P9
fileID=fopen('P9_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act9 = reshape(raw, [165,165,175]);
fileID=fopen('P9_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn9 = reshape(raw, [165,165,175]);
% P10
fileID=fopen('P10_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act10 = reshape(raw, [165,165,175]);
fileID=fopen('P10_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn10 = reshape(raw, [165,165,175]);
% P11
fileID=fopen('P11_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act11 = reshape(raw, [165,165,175]);
fileID=fopen('P11_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn11 = reshape(raw, [165,165,175]);
% P12
fileID=fopen('P12_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act12 = reshape(raw, [165,165,175]);
fileID=fopen('P12_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn12 = reshape(raw, [165,165,175]);
% P13
fileID=fopen('P13_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act13 = reshape(raw, [165,165,175]);
fileID=fopen('P13_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn13 = reshape(raw, [165,165,175]);
% P14
fileID=fopen('P14_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act14 = reshape(raw, [165,165,175]);
fileID=fopen('P14_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn14 = reshape(raw, [165,165,175]);
% P15
fileID=fopen('P15_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act15 = reshape(raw, [165,165,175]);
fileID=fopen('P15_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn15 = reshape(raw, [165,165,175]);
% P16
fileID=fopen('P16_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act16 = reshape(raw, [165,165,175]);
fileID=fopen('P16_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn16 = reshape(raw, [165,165,175]);
% P17
fileID=fopen('P17_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
act17 = reshape(raw, [165,165,175]);
fileID=fopen('P17_atn_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
atn17 = reshape(raw, [165,165,175]);

% Lung_Tumor
fileID=fopen('Lung_Tumor_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
Act_Lung_Tumor = reshape(raw, [165,165,175]);

% Liver_Tumor
fileID=fopen('Liver_Tumor_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
Act_Liver_Tumor = reshape(raw, [165,165,175]);

% Brain_Tumor
fileID=fopen('Brain_Tumor_act_1.bin');
raw=fread(fileID, 165*165*175, 'float32', 'ieee-le');
Act_Brain_Tumor = reshape(raw, [165,165,175]);


% P1
Act_XCAT{1,1}=act1;
Atn_XCAT{1,1}=atn1;
% P2
Act_XCAT{2,1}=act2;
Atn_XCAT{2,1}=atn2;
% P3
Act_XCAT{3,1}=act3;
Atn_XCAT{3,1}=atn3;
% P4
Act_XCAT{4,1}=act4;
Atn_XCAT{4,1}=atn4;
% P5
Act_XCAT{5,1}=act5;
Atn_XCAT{5,1}=atn5;
% P6
Act_XCAT{6,1}=act6;
Atn_XCAT{6,1}=atn6;
% P7
Act_XCAT{7,1}=act7;
Atn_XCAT{7,1}=atn7;
% P8
Act_XCAT{8,1}=act8;
Atn_XCAT{8,1}=atn8;
% P9
Act_XCAT{9,1}=act9;
Atn_XCAT{9,1}=atn9;
% P10
Act_XCAT{10,1}=act10;
Atn_XCAT{10,1}=atn10;
% P11
Act_XCAT{11,1}=act11;
Atn_XCAT{11,1}=atn11;
% P12
Act_XCAT{12,1}=act12;
Atn_XCAT{12,1}=atn12;
% P13
Act_XCAT{13,1}=act13;
Atn_XCAT{13,1}=atn13;
% P14
Act_XCAT{14,1}=act14;
Atn_XCAT{14,1}=atn14;
% P15
Act_XCAT{15,1}=act15;
Atn_XCAT{15,1}=atn15;
% P16
Act_XCAT{16,1}=act16;
Atn_XCAT{16,1}=atn16;
% P17
Act_XCAT{17,1}=act17;
Atn_XCAT{17,1}=atn17;



% P1
Act_XCAT_Bed{1,1}=act1(:,:,1:35);
Act_XCAT_Bed{1,2}=act1(:,:,36:70);
Act_XCAT_Bed{1,3}=act1(:,:,71:105);
Act_XCAT_Bed{1,4}=act1(:,:,106:140);
Act_XCAT_Bed{1,5}=act1(:,:,141:175);
Atn_XCAT_Bed{1,1}=atn1(:,:,1:35);
Atn_XCAT_Bed{1,2}=atn1(:,:,36:70);
Atn_XCAT_Bed{1,3}=atn1(:,:,71:105);
Atn_XCAT_Bed{1,4}=atn1(:,:,106:140);
Atn_XCAT_Bed{1,5}=atn1(:,:,141:175);
% P2
Act_XCAT_Bed{2,1}=act2(:,:,1:35);
Act_XCAT_Bed{2,2}=act2(:,:,36:70);
Act_XCAT_Bed{2,3}=act2(:,:,71:105);
Act_XCAT_Bed{2,4}=act2(:,:,106:140);
Act_XCAT_Bed{2,5}=act2(:,:,141:175);
Atn_XCAT_Bed{2,1}=atn2(:,:,1:35);
Atn_XCAT_Bed{2,2}=atn2(:,:,36:70);
Atn_XCAT_Bed{2,3}=atn2(:,:,71:105);
Atn_XCAT_Bed{2,4}=atn2(:,:,106:140);
Atn_XCAT_Bed{2,5}=atn2(:,:,141:175);
% P3
Act_XCAT_Bed{3,1}=act3(:,:,1:35);
Act_XCAT_Bed{3,2}=act3(:,:,36:70);
Act_XCAT_Bed{3,3}=act3(:,:,71:105);
Act_XCAT_Bed{3,4}=act3(:,:,106:140);
Act_XCAT_Bed{3,5}=act3(:,:,141:175);
Atn_XCAT_Bed{3,1}=atn3(:,:,1:35);
Atn_XCAT_Bed{3,2}=atn3(:,:,36:70);
Atn_XCAT_Bed{3,3}=atn3(:,:,71:105);
Atn_XCAT_Bed{3,4}=atn3(:,:,106:140);
Atn_XCAT_Bed{3,5}=atn3(:,:,141:175);
% P4
Act_XCAT_Bed{4,1}=act4(:,:,1:35);
Act_XCAT_Bed{4,2}=act4(:,:,36:70);
Act_XCAT_Bed{4,3}=act4(:,:,71:105);
Act_XCAT_Bed{4,4}=act4(:,:,106:140);
Act_XCAT_Bed{4,5}=act4(:,:,141:175);
Atn_XCAT_Bed{4,1}=atn4(:,:,1:35);
Atn_XCAT_Bed{4,2}=atn4(:,:,36:70);
Atn_XCAT_Bed{4,3}=atn4(:,:,71:105);
Atn_XCAT_Bed{4,4}=atn4(:,:,106:140);
Atn_XCAT_Bed{4,5}=atn4(:,:,141:175);
% P5
Act_XCAT_Bed{5,1}=act5(:,:,1:35);
Act_XCAT_Bed{5,2}=act5(:,:,36:70);
Act_XCAT_Bed{5,3}=act5(:,:,71:105);
Act_XCAT_Bed{5,4}=act5(:,:,106:140);
Act_XCAT_Bed{5,5}=act5(:,:,141:175);
Atn_XCAT_Bed{5,1}=atn5(:,:,1:35);
Atn_XCAT_Bed{5,2}=atn5(:,:,36:70);
Atn_XCAT_Bed{5,3}=atn5(:,:,71:105);
Atn_XCAT_Bed{5,4}=atn5(:,:,106:140);
Atn_XCAT_Bed{5,5}=atn5(:,:,141:175);
% P6
Act_XCAT_Bed{6,1}=act6(:,:,1:35);
Act_XCAT_Bed{6,2}=act6(:,:,36:70);
Act_XCAT_Bed{6,3}=act6(:,:,71:105);
Act_XCAT_Bed{6,4}=act6(:,:,106:140);
Act_XCAT_Bed{6,5}=act6(:,:,141:175);
Atn_XCAT_Bed{6,1}=atn6(:,:,1:35);
Atn_XCAT_Bed{6,2}=atn6(:,:,36:70);
Atn_XCAT_Bed{6,3}=atn6(:,:,71:105);
Atn_XCAT_Bed{6,4}=atn6(:,:,106:140);
Atn_XCAT_Bed{6,5}=atn6(:,:,141:175);
% P7
Act_XCAT_Bed{7,1}=act7(:,:,1:35);
Act_XCAT_Bed{7,2}=act7(:,:,36:70);
Act_XCAT_Bed{7,3}=act7(:,:,71:105);
Act_XCAT_Bed{7,4}=act7(:,:,106:140);
Act_XCAT_Bed{7,5}=act7(:,:,141:175);
Atn_XCAT_Bed{7,1}=atn7(:,:,1:35);
Atn_XCAT_Bed{7,2}=atn7(:,:,36:70);
Atn_XCAT_Bed{7,3}=atn7(:,:,71:105);
Atn_XCAT_Bed{7,4}=atn7(:,:,106:140);
Atn_XCAT_Bed{7,5}=atn7(:,:,141:175);
% P8
Act_XCAT_Bed{8,1}=act8(:,:,1:35);
Act_XCAT_Bed{8,2}=act8(:,:,36:70);
Act_XCAT_Bed{8,3}=act8(:,:,71:105);
Act_XCAT_Bed{8,4}=act8(:,:,106:140);
Act_XCAT_Bed{8,5}=act8(:,:,141:175);
Atn_XCAT_Bed{8,1}=atn8(:,:,1:35);
Atn_XCAT_Bed{8,2}=atn8(:,:,36:70);
Atn_XCAT_Bed{8,3}=atn8(:,:,71:105);
Atn_XCAT_Bed{8,4}=atn8(:,:,106:140);
Atn_XCAT_Bed{8,5}=atn8(:,:,141:175);
% P9
Act_XCAT_Bed{9,1}=act9(:,:,1:35);
Act_XCAT_Bed{9,2}=act9(:,:,36:70);
Act_XCAT_Bed{9,3}=act9(:,:,71:105);
Act_XCAT_Bed{9,4}=act9(:,:,106:140);
Act_XCAT_Bed{9,5}=act9(:,:,141:175);
Atn_XCAT_Bed{9,1}=atn9(:,:,1:35);
Atn_XCAT_Bed{9,2}=atn9(:,:,36:70);
Atn_XCAT_Bed{9,3}=atn9(:,:,71:105);
Atn_XCAT_Bed{9,4}=atn9(:,:,106:140);
Atn_XCAT_Bed{9,5}=atn9(:,:,141:175);
% P10
Act_XCAT_Bed{10,1}=act10(:,:,1:35);
Act_XCAT_Bed{10,2}=act10(:,:,36:70);
Act_XCAT_Bed{10,3}=act10(:,:,71:105);
Act_XCAT_Bed{10,4}=act10(:,:,106:140);
Act_XCAT_Bed{10,5}=act10(:,:,141:175);
Atn_XCAT_Bed{10,1}=atn10(:,:,1:35);
Atn_XCAT_Bed{10,2}=atn10(:,:,36:70);
Atn_XCAT_Bed{10,3}=atn10(:,:,71:105);
Atn_XCAT_Bed{10,4}=atn10(:,:,106:140);
Atn_XCAT_Bed{10,5}=atn10(:,:,141:175);
% P11
Act_XCAT_Bed{11,1}=act11(:,:,1:35);
Act_XCAT_Bed{11,2}=act11(:,:,36:70);
Act_XCAT_Bed{11,3}=act11(:,:,71:105);
Act_XCAT_Bed{11,4}=act11(:,:,106:140);
Act_XCAT_Bed{11,5}=act11(:,:,141:175);
Atn_XCAT_Bed{11,1}=atn11(:,:,1:35);
Atn_XCAT_Bed{11,2}=atn11(:,:,36:70);
Atn_XCAT_Bed{11,3}=atn11(:,:,71:105);
Atn_XCAT_Bed{11,4}=atn11(:,:,106:140);
Atn_XCAT_Bed{11,5}=atn11(:,:,141:175);
% P12
Act_XCAT_Bed{12,1}=act12(:,:,1:35);
Act_XCAT_Bed{12,2}=act12(:,:,36:70);
Act_XCAT_Bed{12,3}=act12(:,:,71:105);
Act_XCAT_Bed{12,4}=act12(:,:,106:140);
Act_XCAT_Bed{12,5}=act12(:,:,141:175);
Atn_XCAT_Bed{12,1}=atn12(:,:,1:35);
Atn_XCAT_Bed{12,2}=atn12(:,:,36:70);
Atn_XCAT_Bed{12,3}=atn12(:,:,71:105);
Atn_XCAT_Bed{12,4}=atn12(:,:,106:140);
Atn_XCAT_Bed{12,5}=atn12(:,:,141:175);
% P13
Act_XCAT_Bed{13,1}=act13(:,:,1:35);
Act_XCAT_Bed{13,2}=act13(:,:,36:70);
Act_XCAT_Bed{13,3}=act13(:,:,71:105);
Act_XCAT_Bed{13,4}=act13(:,:,106:140);
Act_XCAT_Bed{13,5}=act13(:,:,141:175);
Atn_XCAT_Bed{13,1}=atn13(:,:,1:35);
Atn_XCAT_Bed{13,2}=atn13(:,:,36:70);
Atn_XCAT_Bed{13,3}=atn13(:,:,71:105);
Atn_XCAT_Bed{13,4}=atn13(:,:,106:140);
Atn_XCAT_Bed{13,5}=atn13(:,:,141:175);
% P14
Act_XCAT_Bed{14,1}=act14(:,:,1:35);
Act_XCAT_Bed{14,2}=act14(:,:,36:70);
Act_XCAT_Bed{14,3}=act14(:,:,71:105);
Act_XCAT_Bed{14,4}=act14(:,:,106:140);
Act_XCAT_Bed{14,5}=act14(:,:,141:175);
Atn_XCAT_Bed{14,1}=atn14(:,:,1:35);
Atn_XCAT_Bed{14,2}=atn14(:,:,36:70);
Atn_XCAT_Bed{14,3}=atn14(:,:,71:105);
Atn_XCAT_Bed{14,4}=atn14(:,:,106:140);
Atn_XCAT_Bed{14,5}=atn14(:,:,141:175);
% P15
Act_XCAT_Bed{15,1}=act15(:,:,1:35);
Act_XCAT_Bed{15,2}=act15(:,:,36:70);
Act_XCAT_Bed{15,3}=act15(:,:,71:105);
Act_XCAT_Bed{15,4}=act15(:,:,106:140);
Act_XCAT_Bed{15,5}=act15(:,:,141:175);
Atn_XCAT_Bed{15,1}=atn15(:,:,1:35);
Atn_XCAT_Bed{15,2}=atn15(:,:,36:70);
Atn_XCAT_Bed{15,3}=atn15(:,:,71:105);
Atn_XCAT_Bed{15,4}=atn15(:,:,106:140);
Atn_XCAT_Bed{15,5}=atn15(:,:,141:175);
% P16
Act_XCAT_Bed{16,1}=act16(:,:,1:35);
Act_XCAT_Bed{16,2}=act16(:,:,36:70);
Act_XCAT_Bed{16,3}=act16(:,:,71:105);
Act_XCAT_Bed{16,4}=act16(:,:,106:140);
Act_XCAT_Bed{16,5}=act16(:,:,141:175);
Atn_XCAT_Bed{16,1}=atn16(:,:,1:35);
Atn_XCAT_Bed{16,2}=atn16(:,:,36:70);
Atn_XCAT_Bed{16,3}=atn16(:,:,71:105);
Atn_XCAT_Bed{16,4}=atn16(:,:,106:140);
Atn_XCAT_Bed{16,5}=atn16(:,:,141:175);
% P17
Act_XCAT_Bed{17,1}=act17(:,:,1:35);
Act_XCAT_Bed{17,2}=act17(:,:,36:70);
Act_XCAT_Bed{17,3}=act17(:,:,71:105);
Act_XCAT_Bed{17,4}=act17(:,:,106:140);
Act_XCAT_Bed{17,5}=act17(:,:,141:175);
Atn_XCAT_Bed{17,1}=atn17(:,:,1:35);
Atn_XCAT_Bed{17,2}=atn17(:,:,36:70);
Atn_XCAT_Bed{17,3}=atn17(:,:,71:105);
Atn_XCAT_Bed{17,4}=atn17(:,:,106:140);
Atn_XCAT_Bed{17,5}=atn17(:,:,141:175);

% Lung Tumor
Act_Lung_Tumor_Bed{1,1}=Act_Lung_Tumor(:,:,1:35);
Act_Lung_Tumor_Bed{1,2}=Act_Lung_Tumor(:,:,36:70);
Act_Lung_Tumor_Bed{1,3}=Act_Lung_Tumor(:,:,71:105);
Act_Lung_Tumor_Bed{1,4}=Act_Lung_Tumor(:,:,106:140);
Act_Lung_Tumor_Bed{1,5}=Act_Lung_Tumor(:,:,141:175);

% Liver Tumor
Act_Liver_Tumor_Bed{1,1}=Act_Liver_Tumor(:,:,1:35);
Act_Liver_Tumor_Bed{1,2}=Act_Liver_Tumor(:,:,36:70);
Act_Liver_Tumor_Bed{1,3}=Act_Liver_Tumor(:,:,71:105);
Act_Liver_Tumor_Bed{1,4}=Act_Liver_Tumor(:,:,106:140);
Act_Liver_Tumor_Bed{1,5}=Act_Liver_Tumor(:,:,141:175);

% Brain Tumor
Act_Brain_Tumor_Bed{1,1}=Act_Brain_Tumor(:,:,1:35);
Act_Brain_Tumor_Bed{1,2}=Act_Brain_Tumor(:,:,36:70);
Act_Brain_Tumor_Bed{1,3}=Act_Brain_Tumor(:,:,71:105);
Act_Brain_Tumor_Bed{1,4}=Act_Brain_Tumor(:,:,106:140);
Act_Brain_Tumor_Bed{1,5}=Act_Brain_Tumor(:,:,141:175);


save Act_XCAT.mat Act_XCAT -v7.3
save Act_XCAT_Bed.mat Act_XCAT_Bed -v7.3

save Atn_XCAT.mat Atn_XCAT -v7.3
save Atn_XCAT_Bed.mat Atn_XCAT_Bed -v7.3

save Act_Lung_Tumor.mat Act_Lung_Tumor -v7.3
save Act_Liver_Tumor.mat Act_Liver_Tumor -v7.3
save Act_Brain_Tumor.mat Act_Brain_Tumor -v7.3

%save Act_Lung_Tumor_Bed.mat Act_Lung_Tumor_Bed -v7.3
%save Act_Liver_Tumor_Bed.mat Act_Liver_Tumor_Bed -v7.3
%save Act_Brain_Tumor_Bed.mat Act_Brain_Tumor_Bed -v7.3

