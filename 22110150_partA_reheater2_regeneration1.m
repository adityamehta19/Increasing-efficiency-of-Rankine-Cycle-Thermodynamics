%% 2 reheater and 1 regenration
clc;
clear all;
%% water object
w = Solution('liquidvapor.cti','water');
%% given states
P3 = 10E+3;
P4 = 0.7E+6;                                       % Vary
P5 = P4;
P6 = 15E+6;                      % inlet boiler pressure (in Pa)         
P7 = P6;                         
P8 = P6;                         
P9 = P6;                         
T9 = 499 + 273.15;               % vary (but less than 500 degree C)
P10 = 6.5E+6;                                      % vary
P11 = P10;
T11 = 500 + 273.15;
P12 = 2E+6;                                        % vary
P1 = P12;
T1 = 500 + 273.15;               % vary (but less than 500 degree C)
P1_ = P4;
P2 = P3;                         % inlet condensor pressure (in Pa)
%% State 3
setState_Psat(w, [P3, 0]);
h3 = enthalpy_mass(w);
s3 = entropy_mass(w);
%% State 4
s4 = s3;
setState_SP(w, [s4, P4]);
h4 = enthalpy_mass(w);
%% State 5
setState_Psat(w, [P5,0]);
h5 = enthalpy_mass(w);
s5 = entropy_mass(w);
%% State 6
s6 = s5;
setState_SP(w, [s6, P6]);
h6 = enthalpy_mass(w);
%% State 7
setState_Psat(w, [P7, 0]);
h7 = enthalpy_mass(w);
s7 = entropy_mass(w);
%% State 8
setState_Psat(w, [P8, 1]);
h8 = enthalpy_mass(w);
%% State 9
set(w,'P',P9,'T',T9);
h9 = enthalpy_mass(w);
s9 = entropy_mass(w);
%% State 10
s10 = s9;
setState_SP(w, [s10, P10]);
h10 = enthalpy_mass(w);
%% State 11
set(w,'P',P11,'T',T11);
h11 = enthalpy_mass(w);
s11 = entropy_mass(w);
%% State 12
s12 = s11;
setState_SP(w, [s12, P12]);
h12 = enthalpy_mass(w);
%% State 1
set(w,'P',P1,'T',T1);
h1 = enthalpy_mass(w);
s1 = entropy_mass(w);
%% State 1_
s1_ = s1;
setState_SP(w, [s1_, P1_]);
h1_ = enthalpy_mass(w);
%% State 2
s2 = s1;
setState_SP(w, [s2, P2]);
h2 = enthalpy_mass(w);
setState_Psat(w, [P2,0]);
sf = entropy_mass(w);
hf = enthalpy_mass(w);

setState_Psat(w, [P2, 1]);
sg = entropy_mass(w);
hg = enthalpy_mass(w);

hfg = hg-hf;
sfg = sg-sf;
%% calculations
x = (h2 - hf)/hfg;
m4_5 = ((h1_ - h5)/(h1_ - h4));
qout = m4_5 * (h2 - h3);
qin = h9 - h6 + h11 - h10 + h1 - h12;
efficiency = 1 - (qout/qin);

%% Final answers
fprintf("The quality is %.4f %%\n", x*100);
fprintf("The efficiency is %.4f %%\n", efficiency*100);
