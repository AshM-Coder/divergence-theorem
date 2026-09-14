% Visualisation of a 3D vector field and the unit sphere within it
%
% Plots a vector field F = [x*z^2, x*y, y*z] together with a unit sphere
% and its outward surface normal vectors, as a first step toward
% numerically and symbolically verifying the divergence theorem.
clear
close all
clc
%
r=1; % [m] radius of unit sphere
n_face=30; % determines number of faces on sphere
[x_s,y_s,z_s]=sphere(n_face); % generates coordinates on spherical surface
[n_x,n_y,n_z]=surfnorm(x_s,y_s,z_s); % generates surface normals
%
n_div=20;
x=linspace(-1,1,n_div);
y=linspace(-1,1,n_div);
z=linspace(-1,1,n_div);
[X,Y,Z]= meshgrid(x,y,z);
F_x= X.*(Z.^2);
F_y= X.*Y;
F_z= Y.*Z;
%
% Visualisation of system.
figure(1)
hold on
surf(x_s,y_s,z_s) % plots spherical Gaussian surface
quiver3(x_s,y_s,z_s,n_x,n_y,n_z,'Color','r') % plots surface normals 
quiver3(X,Y,Z,F_x,F_y,F_z,'LineWidth',1.5,'Color','k') % quiver plot of vector field, F
view(-37.5,30) % sets 3D viewpoint
axis equal
axis([-1,1,-1,1,-1,1])
xlabel('x')
ylabel('y')
zlabel('z')
title('A unit sphere, its normal vectors and the vector field F')