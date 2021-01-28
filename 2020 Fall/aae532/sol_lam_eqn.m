%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Secant method to solve for Lambert's Equation
%   @mu: gravitational constant (km^3/s^2)
%   @TOF: time of flight (sec)
%   @s: semi-perimeter of space triangle (km)
%   @c: chord of space triangle (km)
%   @a0: initial guess of a, two values, (km)
%   @type: type of transfer, 11-1A; 22-2B; 12-1B; 21-2A

function a = sol_lam_eqn(mu,TOF,s,c,a0,type,method)
    epsilon = 1e-6;
    x0 = a0(1);
    x1 = a0(2);
    err=abs(x1-x0);
    f = @(a) lambert_eqn(mu,a,s,c,type)-TOF;
    
    if ~exist('method','var')
        method = 0;
    end
    ct = 0;
    
    if method == 1 %% secant method
        while err > epsilon && ct < 100
            f1 = f(x1);
            f0 = f(x0);
            x2 = x1-f1*(x1-x0)/(f1-f0);
            x0 = x1;
            x1 = x2;
            err = abs(x1-x0);
            ct=ct+1;
            if ct >= 100
                error('max iteration reached fucktard')
            end
        end
    elseif method == 0 %% bisection method
        while err > epsilon && ct < 100
            x2 = (x1+x0)/2;
            f0 = f(x0);
            f1 = f(x1);
            f2 = f(x2);
            if f0*f2>0
                x0 = x2;
            elseif f1*f2>0
                x1 = x2;
            end
            err = abs(x0-x1)/2;
            ct = ct+1;
        end
    end
    ct
    a = x2;
end