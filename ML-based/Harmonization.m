% multi-site SSM
clc,clear

%% load data
site1_struct = get_file_info('E:\MultiSiteProgramSVD\ADNI\AV45\MultiSite_CN_032_AV45_n');
site2_struct = get_file_info('E:\MultiSiteProgramSVD\TianTan\CN\Aβ_n');
first_image_info = spm_vol([site1_struct(1).folder,'\',site1_struct(1).name]);
mask_name = 'F:\MATLAB\MultiSite-SSM\mask.nii';
[dim_x,dim_y,dim_z] = size(spm_read_vols(first_image_info));
site1_image_num = length(site1_struct);
image_num = site1_image_num+length(site2_struct);
harmonize_data = zeros(image_num,prod([dim_x,dim_y,dim_z]));

%% covariate_info
% load F:\MATLAB\MultiSite-SVD\age.mat;
% load F:\MATLAB\MultiSite-SVD\sex.mat;
% load F:\MATLAB\MultiSite-SVD\TIV.mat;
% x_age = age;
% x_tiv = TIV;
% x_age = mapminmax(age',0,1)';
% x_tiv = mapminmax(TIV',0,1)';
% x_sex = dummyvar(sex);
load E:\SVD\cov\A.mat;
covariate_info = A;

%% SVD
% [subject_data,subject_score,gismatrix,mask_up0] = ssm_pca(site1_struct,site2_struct,0.1,covariate_info);
[~,subject_data,subject_score,gismatrix,mask_up0] = ssm_pca(site1_struct,site2_struct,0.1);

%% Harmonization
Ttest = harmonize_image(subject_score,gismatrix,site1_image_num);
subject_score = subject_score(:,Ttest(:,1));
gismatrix = gismatrix(:,Ttest(:,1));
subject_score_har = harmonize_score(subject_score,site1_image_num,Ttest,1,0.001);    % Abeta 0.001  Tau 0.05

%% Write image
P = 0.001;
gismatrix_n = sum(Ttest(:,2)<P);
% site_score = subject_score(:,1:gismatrix_n);    %1:gismatrix_n);
% site_gismatrix = gismatrix(:,1:gismatrix_n);    %1:gismatrix_n);
% site_data = site_score*site_gismatrix';
% har_data = subject_data'-site_data;
% non_negative = any(har_data(:)<0);
% if ~non_negative

% % % % har_data = subject_score*gismatrix';
% % % % for site_gismatrix_i = 1:gismatrix_n
% % % %     site_data = subject_score(:,site_gismatrix_i)*gismatrix(:,site_gismatrix_i)';
% % % %     har_data = har_data-site_data;
% % % %     har_data(har_data<0.2) = har_data(har_data<0.2)+site_data(har_data<0.2);   %  A:0.2    FDG:0    Tau:1
% % % % end

har_data = subject_score_har*gismatrix'+subject_data';
% subject_score(:,2) = [];
% gismatrix(:,2) = [];
% har_data = subject_score*gismatrix';
% har_data(har_data<0) = har_data(har_data<0)+site_data(har_data<0);
harmonize_data(:,mask_up0==1) = har_data;

% for subject_i = 1:site1_image_num
%     first_image_info.fname = ['E:\IXIOASIS1\IXI' '\' site1_struct(subject_i).name];
%     spm_write_vol(first_image_info,reshape(harmonize_data(subject_i,:),dim_x,dim_y,dim_z));
% end

for subject_i = site1_image_num+1:image_num
    first_image_info.fname = ['E:\SVD\Tiantan_A_nocov' '\' site2_struct(subject_i-site1_image_num).name];
    spm_write_vol(first_image_info,reshape(harmonize_data(subject_i,:),dim_x,dim_y,dim_z));
end

% first_image_info.fname = ['E:\IXIOASIS1' '\' 'MASK.nii'];
% spm_write_vol(first_image_info,reshape(mask_up0,dim_x,dim_y,dim_z));


% for site_gismatrix_i = 1:gismatrix_n
%     mask_up0(mask_up0~=0) = gismatrix(:,site_gismatrix_i)';
%     first_image_info.fname = ['E:\IXIOASIS1' '\' 'site_gismatrix_' num2str(site_gismatrix_i) '.nii'];
%     spm_write_vol(first_image_info,reshape(mask_up0,dim_x,dim_y,dim_z));
% end
%
% end