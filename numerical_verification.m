% Numerical verification of the divergence theorem
%
% Approximates both sides of the divergence theorem for a unit sphere in
% the vector field F = [x*z^2, x*y, y*z] using discrete summation: the
% volume integral of div(F) over a 3D grid, and the surface integral of
% F . n_hat over a discretised sphere. Provides a numerical cross-check
% against the analytical (symbolic) result.
clear
close all
clc
%
% Considering a unit sphere at origin [0,0,0] with r=1
%
% LHS Volume Integral
% Setting up a 3D grid
n_div= 100;
x=linspace(-1,1,n_div);
y=linspace(-1,1,n_div);
z=linspace(-1,1,n_div);
[X,Y,Z]=meshgrid(x,y,z);
% Components of vector field F at each point within the 3D grid
F_x= X.*(Z.^2);
F_y= X.*Y;
F_z= Y.*Z;
% Divergence of F at each point within the 3D grid
% divergence_of_F= (Z.^2) + Y + Y;
div_F= divergence(X,Y,Z,F_x,F_y,F_z);
% Determines volume of volume element, DV.
Dx=2/(n_div-1); %  x-length of a volume element
Dy=2/(n_div-1); %  y-length of a volume element
Dz=2/(n_div-1); %  z-length of a volume element
DV=Dx*Dy*Dz; % volume of a volume element
% 
% Unwrap X, Y, and Z prior to entering the loop.
X=X(:);
Y=Y(:);
Z=Z(:);
%
lhs=0; % initialisation 
%
% Loop across all positions in 3D grid. If position is enclosed by the unit
% sphere (r<1), the volume element there contributes to our volume
% approximation.
for i=1:length(X)
    pos_curr=[X(i),Y(i),Z(i)]; % extracts x, y, and z-coordinates of current position
    r_curr=norm(pos_curr); % calculates distance of current position from origin
    if r_curr<1 % if distance is within boundaries of unit sphere (r<1)
        DiverF= Z(i)^2 +X(i) + Y(i);
        lhs= lhs+ (DiverF*DV);
    else
    end
end
    

%
% RHS Surface Integral
r=1; % radius of sphere
n_face=30; % number of faces on sphere
[x_s,y_s,z_s]=sphere(n_face); % generates coordinates on spherical surface
[n_x,n_y,n_z]=surfnorm(x_s,y_s,z_s); % generates surface normals
%
% Components of vector field F, at each point on the surface of the sphere
x_comp= x_s.*(z_s.^2);
y_comp= x_s.*y_s;
z_comp= y_s.*z_s;
%
% Surface area elements.
Surf_sph=4*pi*r^2; % surface area of sphere
DS=Surf_sph/(n_face^2); % assume each surface area element has the same area, we have n_face^2 faces
%
% Unwraps all matrices prior to entering the for loop.
x_comp=x_comp(:); % unwraps Fx
y_comp=y_comp(:); % unwraps Fy
z_comp=z_comp(:); % unwraps Fz
n_x=n_x(:); % unwraps n_x
n_y=n_y(:); % unwraps n_y
n_z=n_z(:); % unwraps n_z
%
% Uses for loop to compute discrete sum of (F.unit_n)*(delta S).
rhs=0; % initialises running sum for LHS
for i=1:length(x_comp)
    F_curr=[x_comp(i),y_comp(i),z_comp(i)]; % current component vectors of F
    n_curr=[n_x(i),n_y(i),n_z(i)]; % current surface normal vector
    Fdotn=dot(F_curr,n_curr); % calculates F dot ncap
    FdotnDS=Fdotn*DS; % calculates (F dot ncap)*(delta S)
    rhs=rhs+FdotnDS; % adds current FdotnDS to running sum    
end

sentence1='The volumetric sum of div(F) is %.4f .\n';
fprintf(sentence1,lhs)
sentence2='The surface area sum of F dot ncap is %.4f .\n';
fprintf(sentence2,rhs)