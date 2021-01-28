function [coords]=plot_orbit_3d(e,a, RAAN, AOP, I, seg, LOA)
    set(0,'defaultTextInterpreter','latex');
    
    if ~exist('seg','var')
        seg = [0 2*pi]; %% default segment is 0 to 2pi, full orbit
    end
    
    if ~exist('LOA','var')
        LOA = 0; %% don't plot line of apsides
    end
    
    if e < 1 % ellipses
        p = a*(1-e^2);
        rp = a*(1-e);
        ra = a*(1+e);
        rp_xyz = C313(RAAN,AOP,I)*[rp 0 0]';
        ra_xyz = C313(RAAN,pi+AOP,I)*[ra 0 0]';
     
        Pvec = [ra_xyz rp_xyz]';
    elseif e >= 1 % hyperbolas and parabolas
        p = a*(e^2-1);
        rp = a*(e-1);
        rp_xyz = C313(RAAN,AOP,I)*[rp 0 0]';
        
        Pvec = [zeros(3,1) rp_xyz]'; 
    end
    
    
    TA = linspace(seg(1),seg(2),1e5);
    coords = zeros(3,length(TA));
    for i = 1:length(TA)
        TAi = TA(i);
        r = [p/(1+e*cos(TAi)) 0 0]';
        coords(:,i) = C313(RAAN, AOP+TAi, I)*r;
    end
    
    plot3(coords(1,:),coords(2,:),coords(3,:))
    hold on;
    
    if LOA == 1 %% plot line of apsides
        plot3(Pvec(:,1),Pvec(:,2),Pvec(:,3),'k')
    end
    
    axis equal;
    grid on;
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    function C = C313(omega,theta,i)
    C = [cos(omega)*cos(theta)-sin(omega)*cos(i)*sin(theta) -cos(omega)*sin(theta)-sin(omega)*cos(i)*cos(theta) sin(omega)*sin(i);
        sin(omega)*cos(theta)+cos(omega)*cos(i)*sin(theta) -sin(omega)*sin(theta)+cos(omega)*cos(i)*cos(theta) -cos(omega)*sin(i);
        sin(i)*sin(theta) sin(i)*cos(theta) cos(i)];
    end
end