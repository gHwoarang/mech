clear all
clc
close all
%==========================================================================
%                                DEFINITIONS
%==========================================================================
% 1. PURPOSE: Solving Parachutist Example

% -INPUT PARAMETERS
% g         : gravity
% m         : mass
% cd        : drag coefficient
% ti        : initial time
% tf        : final time

% -OUTPUT PARAMETERS
% v         : velcity of the parachutist

% 2. REFERENCES:
% [1]. David W. Rosen, Georgia Institute of Technology, ME6103 Course Notes

% 3. OTHERS:
% Modifed Date: 01/20/2023
% By : Recep M. Gorguluarslan

% Inputs
g=9.81;
% m=input('mass (kg): ');
m=68.1;
cd=12.5;
ti=0;
tf=12;
vi=0;
dt=2;
t = ti;
v = vi;
h = dt;

% Velocity calculation betwen t=0 to t=tf
inc=1;
while (1)
	if t + dt > tf
		h = tf - t;
    end
	dvdt = g - (cd / m) * v(inc,1);
	v(inc+1,1) = v(inc,1) + dvdt * h;
	t(inc+1,1) = t(inc,1) + h;
    if t(inc+1,1) >= tf 
        disp('velocity (m/s):');
        disp(v(inc+1,1));
        break

    end

    disp('velocity (m/s):');
    disp(v(inc+1,1));
    inc=inc+1;
end

% Plotting the velocity
plot(t,v,'k-o')
xlabel('time (s)')
ylabel('velcity (m/s)')











