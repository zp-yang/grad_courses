function [E] = kepler_eqn(M,e)
        func = @(E) E - e*sin(E) - M;
        E0 = [0,2*pi];
        E = fzero(func, E0);
end