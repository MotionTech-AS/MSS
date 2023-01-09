function vessel = vessel2simscape(vessel)
    
    % Author: Sondre Sanden Tørdal
    %
    % This script adds required data to the vessel struct for use with the
    % Simscape MSS library

    % Calculate r_g (inherited from vessel2ss)
    LCG = vessel.main.CG(1);
    VCG = vessel.main.CG(3);
    LCB = vessel.main.CB(1);
    VCB = vessel.main.CB(3);
    T_WL  = vessel.main.T;
    r_g = [LCG 0 T_WL-VCG];
    r_b = [LCB 0 T_WL-VCB];
    
    % Transform MRB from CO to CG (needed by Simscape inertia "MCG")
    MRB = vessel.MRB;
    MCG = inv(Hmtrx(r_g)')*MRB*inv(Hmtrx(r_g));

    Nmax   = length(vessel.freqs);

    WAMIT = 0;
    if vessel.freqs(end) == 10
        WAMIT = 1;
    end

    if WAMIT == 1
        Nf = Nmax-1;    % for WAMIT computations, remove infinite frequency data
    else
        Nf = Nmax;      % for Veres use all frequencies, no infinite frequency data
    end

    % frequencies
    w = vessel.freqs(1:Nf)';   % does not include ininite frequency
    G      = reshape(vessel.C(:,:,Nmax,1),6,6);

    MA     = reshape(vessel.A(:,:,Nmax,1),6,6); 

%     m = 1000 % mass
%     g = 9.81 % acceleration of gravity
%     W = m*g; % weight
%     B = W; % buoyancy

    % Add new required Simscape properties to vessel struct
    vessel.r_g = r_g;
    vessel.r_b = r_b;
    vessel.MCG = MCG;
    vessel.Ixx = MCG(4,4);
    vessel.Iyy = MCG(5,5);
    vessel.Izz = MCG(6,6);
    vessel.Ixy = MCG(4,5);
    vessel.Izx = MCG(4,6);
    vessel.Iyz = MCG(5,6);
    vessel.G = G;
    vessel.MA = MA;
    

end