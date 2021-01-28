function [x,y]=plot_orbit(e, a)
    set(0,'defaultTextInterpreter','latex');
    
    p = a*(1-e^2);
    rp = a*(1-e);
    ra = a*(1+e);
    if e == 1 %parabola
        theta = deg2rad(linspace(-140,140));
    elseif e<1 %ellipse
        theta = linspace(0,2*pi);
        xc = a*cos(theta)-a*e;
        yc = a*sin(theta);
        %plot([rp,-ra],[0,0],'k-');hold on;
    else  %hyperbola
        theta = deg2rad(linspace(-100,100));
    end
    
    r = p./(1+e*cos(theta));
    x = r.*cos(theta);
    y = r.*sin(theta);   
    
    plot(x,y);
    hold on;
    plot(0,0,'ok')
        
%     if e<1
%         plot(xc,yc,'--')
%         plot(-a*e,0,'x')
%     end
    
    axis equal
    grid on
    title('Orbit View');
    xlabel('$\hat{e}$')
    ylabel('$\hat{p}$')
end