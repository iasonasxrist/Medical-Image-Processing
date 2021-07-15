function [diff] =noise_diff(im, m) 
Central_im=im(2:3,2:3)
Central_m=m(2:3,2:3)
N=size(Central_m,2);
diff=0;
mean_im=mean2(Central_im)
mean_m=mean2(Central_m)
 
sigma_im=std2(Central_im)
sigma_m=std2(Central_m)
 
diff=100*(sigma_im-sigma_m)/sigma_im;
