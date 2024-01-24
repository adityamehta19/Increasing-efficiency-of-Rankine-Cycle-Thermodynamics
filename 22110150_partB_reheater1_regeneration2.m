clc;
clear all;

Pb_range = linspace(12E+6, 15E+6, 20); % range of boiler pressures from 12 MPa to 15 MPa
Pc_range = linspace(5E+3, 10E+3, 20);  % range of condenser pressures from 5 kPa to 10 kPa

%% initialize arrays to store results
efficiency_results = zeros(length(Pc_range), length(Pb_range));
w_net_results = zeros(length(Pc_range), length(Pb_range));

%% loop through different values of Pb and Pc
for i = 1:length(Pb_range)
    for j = 1:length(Pc_range)
        P8 = Pb_range(i);
        P2 = Pc_range(j);
        [efficiency, w_net] = calculate_cycle_performance(P2, P8);
        efficiency_results(j, i) = efficiency;
        w_net_results(j, i) = w_net;
    end
end

%% plots
figure;
subplot(2, 1, 1);
contourf(Pc_range, Pb_range, efficiency_results', 20, 'LineColor', 'none');
colorbar;
xlabel('Condenser Pressure (Pa)');
ylabel('Boiler Pressure (Pa)');
title('Effect on Thermal Efficiency');

subplot(2, 1, 2);
contourf(Pc_range, Pb_range, w_net_results', 20, 'LineColor', 'none');
colorbar;
xlabel('Condenser Pressure (Pa)');
ylabel('Boiler Pressure (Pa)');
title('Effect on Net Work done');

%% cycle performance
function [efficiency, w_net] = calculate_cycle_performance(P2, P8)
    %% water object 
    w = Solution('liquidvapor.cti','water');
    %% given state
    P3 = 10E+3;
    P4 = 0.8E+6;                % Vary
    P5 = P4;
    P6 = 3.7E+6;                % vary
    P7 = P6;
    P9 = P8;                   
    P10 = P8;
    P11 = P8;
    T11 = 500 + 273.15;
    P12 = P6;
    P1 = P6;
    T1 = 500 + 273.15;          % vary (but less than 500 degree C)
    P1_ = P4;
    %% State 3
    setState_Psat(w, [P3 ,0]);
    h3 = enthalpy_mass(w);
    s3 = entropy_mass(w);
    %% State 4
    s4 = s3;
    setState_SP(w ,[s4 ,P4]);
    h4 = enthalpy_mass(w);
    %% State 5
    setState_Psat(w ,[P5 ,0]);
    h5 = enthalpy_mass(w);
    s5 = entropy_mass(w);
    %% State 6
    s6 = s5;
    setState_SP(w ,[s6 ,P6]);
    h6 = enthalpy_mass(w);
    %% State 7
    setState_Psat(w, [P7 ,0]);
    h7 = enthalpy_mass(w);
    s7 = entropy_mass(w);
    %% State 8
    s8 = s7;
    setState_SP(w, [s8 ,P8]);
    h8 = enthalpy_mass(w);
    %% State 9
    setState_Psat(w, [P9 ,0]);
    h9 = enthalpy_mass(w);
    %% State 10
    setState_Psat(w, [P10,1]);
    h10 = enthalpy_mass(w);
    %% State 11
    set(w,'P',P11,'T',T11);
    h11 = enthalpy_mass(w);
    s11 = entropy_mass(w);
    %% State 12
    s12 = s11;
    setState_SP(w, [s12,P12]);
    h12 = enthalpy_mass(w);
    %% State 1
    set(w,'P',P1,'T',T1);
    h1 = enthalpy_mass(w);
    s1 = entropy_mass(w);
    %% State 1_
    s1_ = s1;
    setState_SP(w, [s1_,P1_]);
    h1_ = enthalpy_mass(w);
    %% State 2
    s2 = s1;
    setState_SP(w, [s2 ,P2]);
    h2 = enthalpy_mass(w);
    m4_6 = ((h1_ - h5)/(h1_ - h4));
    m7_6 = ((h6 - h12)/(h7 - h12));
    qout = m4_6 * (h2 - h3);
    qin = (m7_6 * (h11 - h8))+ (h1 - h12);
    w_net = qin - qout;
    efficiency = (1-(qout/qin))*100;


end
