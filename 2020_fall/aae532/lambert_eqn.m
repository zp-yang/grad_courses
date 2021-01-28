function [TOF, alpha, beta] = lambert_eqn(mu,a,s,c,type)
    if ~(type == 13 || type == 23)
        alpha = 2*asin(sqrt(s./(2*abs(a))));
        beta = 2*asin(sqrt((s-c)./(2*abs(a))));
    else
        alpha = 2*asinh(sqrt(s./(2*abs(a))));
        beta  = 2*asinh(sqrt((s-c)./(2*abs(a))));
    end
    
    if type == 11 %% 1A
        alpha = alpha;
        beta = beta;
    elseif type == 22 %% 2B
        alpha = 2*pi-alpha;
        beta = -beta;
    elseif type == 12 %% 1B
        alpha = 2*pi-alpha;
        beta = beta;
    elseif type == 21 %% 2A
        alpha = alpha;
        beta = -beta;
    elseif type == 13 %% 1H
        alpha = alpha;
        beta = beta;
    elseif type == 23 %% 2H
        alpha = alpha;
        beta = -beta;
    end
    
    if ~(type == 13 || type == 23)
        TOF = abs(a).^1.5.*((alpha-beta)-(sin(alpha)-sin(beta)))/sqrt(mu); %% in sec
    else
        TOF = abs(a).^1.5.*((sinh(alpha)-alpha)-(sinh(beta)-beta))/sqrt(mu);
    end
end