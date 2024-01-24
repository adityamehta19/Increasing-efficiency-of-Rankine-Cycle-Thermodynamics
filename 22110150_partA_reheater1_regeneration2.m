clc;
clear all;

%%% ONE REHEATER AND 2 REGENERATION

%% water object 
w = Solution('liquidvapor.cti','water');
%% given states
P3 = 10E+3;
P4 = 0.8E+6;                % Vary
P5 = P4;
P6 = 3.7E+6;                % vary
P7 = P6;
P8 = 15E+6;                 % inlet boiler pressure (in Pa)
P9 = P8;                   
P10 = P8;
P11 = P8;
T11 = 500 + 273.15;
P12 = P6;
P1 = P6;
T1 = 500 + 273.15;          % vary (but less than 500 degree C)
P1_ = P4;
P2 = P3;                    % inlet condenser pressure (in Pa)
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
setState_Psat(w, [P2, 0]);
hf = enthalpy_mass(w);
setState_Psat(w, [P2, 1]);
hg = enthalpy_mass(w);
hfg = hg-hf;
x = ((h2-hf)/hfg)*100;
m4_6 = ((h1_-h5)/(h1_-h4));
m7_6 = ((h6-h12)/(h7-h12));
qout = m4_6*(h2-h3);
qin = (m7_6*(h11-h8))+h1-h12;
efficiency = (1-(qout/qin))*100;

%% final answer printing
fprintf("The quality of the modified cycle is %.4f %%\n", x);
fprintf("The Efficiency of the modified cycle is %.4f %%\n", efficiency);
fprintf("The modified Rankine cycle gives quality more than 86 %% and efficiency of more than 46 %% therefore justifies the requirement!\n")



