function vessel = vessel2simscape(vessel)
    
    % Author: Sondre Sanden Tørdal
    %
    % This script adds required data to the vessel struct for use with the
    % Simscape MSS library

    % Calculate r_g (inherited from vessel2ss)
    LCG   = vessel.main.CG(1);
    VCG   = vessel.main.CG(3);
    T_WL  = vessel.main.T;
    r_g = [LCG 0 T_WL-VCG];
    
    % Transform MRB from CO to CG (needed by Simscape inertia "MCG")
    MRB = vessel.MRB;
    MCG = inv(Hmtrx(r_g)')*MRB*inv(Hmtrx(r_g));

    % Add new required Simscape properties to vessel struct
    vessel.r_g = r_g;
    vessel.MCG = MCG;
    vessel.Ixx = MCG(4,4);
    vessel.Iyy = MCG(5,5);
    vessel.Izz = MCG(6,6);
    vessel.Ixy = MCG(4,5);
    vessel.Izx = MCG(4,6);
    vessel.Iyz = MCG(5,6);

end