%%%% a code that builds the Riemann surface of sqrt(z) and its phase
%%%% portrait


clear all


xmin = -0.5;
xmax = 0.5;
ymin = -0.5;
ymax = 0.5;
xres = 800;
yres = 800;

x = linspace(xmin,xmax,xres);
y = linspace(ymin,ymax,yres);
[x,y] = meshgrid(x,y);
z = x+1i*y;
f= sqrt(z);



smoothing_coef = 0.1;
sheet_distance = 0.1;

%%% let us index three domains of interest
%%%% and apply different smoothing functions in each one

mask1 = x<0&y>0;
mask2 = x<0&y<0;

mask3 = x>0;

val_to_plot1 = 0*f;
val_to_plot2 = 0*f;



val_to_plot1(mask1) = -sheet_distance*tanh(y(mask1)/smoothing_coef);
val_to_plot1(mask2) = sheet_distance*tanh(y(mask2)/smoothing_coef);
val_to_plot2(mask1) = sheet_distance*tanh(y(mask1)/smoothing_coef);
val_to_plot2(mask2) = -sheet_distance*tanh(y(mask2)/smoothing_coef);

val_to_plot1(mask3) = -sheet_distance*abs(tanh(sqrt(x(mask3).^2+y(mask3).^2)/smoothing_coef));
val_to_plot2(mask3) = sheet_distance*abs(tanh(sqrt(x(mask3).^2+y(mask3).^2)/smoothing_coef));

%%%% plot a nice Riemann surf fo sqrt(z) taking color coding from Wegert

figure;
p1 = surf(real(z),imag(z),val_to_plot1, angle(-f));
hold all
p2 = surf(real(z),imag(z),val_to_plot2, angle(f));

set(p1,'EdgeColor','none')
set(p2,'EdgeColor','none')
clim([-pi,pi])
colormap hsv(600)
view(-38,12)
axis equal
axis off



%%% was not used
%% build smoothing function
%  x_line =  x(1,:);
% % 
% % 
% % 
%  smoother = 0.01*tanh(x_line/0.1);
% % 
%   figure; 
%  plot(x_line, abs(smoother))


%%
% r_min = 0.1;
% delta = 0.2;
% 

% mask = angle(x+1i*y)<pi- delta|angle(x+1i*y)>pi+delta;
% val_to_plot1(mask) = 0.1;
% val_to_plot2(mask) = 0;
% 
% val_to_plot1(~mask) = real(f(~mask));
% 
% val_to_plot2(~mask) = real(-f(~mask))+0.1;
