%% Load combos
clc, clear
CLoad = 1.8500;
LL = 3.11;
WL = 1.843;
DL = (((CLoad*1.48816*9.81)*4)/1000)+.007+.082+.196;
% Combos
G1 = DL+LL;
G2 = (DL+WL)/1.25;
G3 = (DL+LL+(.3*WL))/1.25;
% Solve for Max tension
vec = [G1 G2 G3];
if max(vec) == G1
    W0 = G1;
elseif max(vec) == G2
    W0 = G2;
elseif max(vec) == G3
    W0 = G3;
end

W0 = (3/4)*W0; % There are 4 cables, and a factor of safety of 3.
 
% Chosing correct root for x value 

Eq1 = [((-2.36/8.976)*W0) 64*W0 (-2048*W0)];
rvec = roots(Eq1);
rpos = rvec(rvec>=0);
if rpos(1) > 0 && rpos(1) < 64
    x = rpos(1);
elseif rpos(2) > 0 && rpos(2) < 64
    x = rpos(2);
end
% Solving for Tmax
Tmax = sqrt(((W0*x)^2)+(((W0*(x^2))/8.970)^2));
Tmax = (Tmax*1000)/9.81; % convert KN to kg
Tmax = double(Tmax*2.20462);
disp(Tmax)
%% Length of Cable
% Section 1
T0 = (W0*(x^2))/8.976; %in KN

s1 = ((x/2)*sqrt(1+((W0*x/T0)^2))) + ((.5*(T0/W0))*log((W0*x/T0)+(sqrt(1+((W0*x/T0)^2)))));

x2 = (64-x);
s2 = ((x2/2)*sqrt(1+((W0*x2/T0)^2))) + ((.5*(T0/W0))*log((W0*x2/T0)+(sqrt(1+((W0*x2/T0)^2)))));
Lngth = s1+s2;
disp(Lngth)