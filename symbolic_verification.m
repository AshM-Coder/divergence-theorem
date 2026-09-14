% Symbolic verification of the divergence theorem
%
% Uses the MATLAB Symbolic Math Toolbox to evaluate both sides of the
% divergence theorem for a unit sphere in the vector field
% F = [x*z^2, x*y, y*z]: the volume integral of div(F) and the surface
% integral of F . n_hat, both computed analytically in spherical
% coordinates.
clear
close all
clc
%
% Considering a unit sphere at origin [0,0,0] with r=1
%
% Symbolic declaration.
syms x y z r theta phi
assume(x,'real');
assume(y,'real');
assume(z,'real');
assume(r,'real');
assume(theta,'real');
assume(phi,'real');
%
% Defining the vector field F in terms of x,y, and z
F_x= x*(z^2);
F_y= x*y;
F_z= y*z;
F=[F_x,F_y,F_z];
%
% LHS Volume Integral
% Defines Cartesian coordinates in terms of spherical coordinates.
x=r*cos(theta)*sin(phi);
y=r*sin(theta)*sin(phi);
z=r*cos(phi);
%
% Puts coordinates in vector form for use in the jacobian function.
cart=[x,y,z];
sph=[r,phi,theta];
%
J=jacobian(cart,sph); % computes Jacobian matrix
detJ=det(J); % computes Jacobian determinant
%
% Divergence of F in cartesian coordinates
DivF_cart= (z^2)+x+y;
DivF_sph= r^2*cos(phi)^2 + r*cos(theta)*sin(phi) + r*sin(phi)*sin(theta);
%
% Performs triple integral.
integral1=int(DivF_sph*detJ,r,0,1); % integrates w.r.t. r from 0 to 1
integral2=int(integral1,theta,0,2*pi); % integrates w.r.t. theta from 0 to 2*pi
integral3=int(integral2,phi,0,pi); % integrates w.r.t. phi from 0 to pi
%
% RHS Surface Integral
n=[x,y,z];
unit_n= n./norm(n);
dot_cart= dot(F,unit_n);
%dot_cart = ((x*z)^2 + x*y^2 +y*z^2)/norm(n);
dot_sph= (r^3*sin(phi)*(r*cos(phi)^2*cos(theta)^2*sin(phi) + cos(phi)^2*sin(theta) + cos(theta)*sin(phi)^2*sin(theta)^2))/abs(r);
a= dot_cart*detJ;
b=simplify(a);
% Substitute r=1 in b to get integrand
integrand=sin(phi)^2*(cos(phi)^2*cos(theta)^2*sin(phi) + cos(phi)^2*sin(theta) + cos(theta)*sin(phi)^2*sin(theta)^2);
integral4= int(integrand,theta,0,2*pi);
integral5= int(integral4,phi,0,pi);
%
%Conditional Statement
if integral3==integral5
    sentence1='The 2 integrals are equal, with a value of %.4f : Divergence Theorem shown.\n';
    fprintf(sentence1,integral3);
else
    sentence2='The volume integral is %.4f while the surface integral is %.4f. There is a mistake somewhere.\n';
    fprintf(sentence2,integral3,integral5)
end