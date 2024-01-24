clc;
clear all;

%% water object
w = Solution('liquidvapor.cti','water');
%% given values of states
P3 = 10E+3;
P4 = 0.8E+6;
P5 = P4;
P6 = 15E+6;                % inlet boiler pressure (in Pa)
P7 = P6;                    
P8 = P6;
P9 = P6;
T9 = 500 + 273.15;
P10 = 3.8E+6;                           % vary
P1 = P10;
T1 = 500+273.15;                        % vary (but less than 500 degree C)
P1_ = P4;
P2 = P3;                    % inlet condensor pressure (in Pa)
%% State 3
setState_Psat(w ,[P3 ,0]);
h3 = enthalpy_mass(w);
s3 = entropy_mass(w);
%% State 4
s4 = s3;
setState_SP(w, [s4 ,P4]);
h4 = enthalpy_mass(w);
%% State 5
setState_Psat(w ,[P5 ,0]);
h5 = enthalpy_mass(w);
s5 = entropy_mass(w);
%% State 6
s6 = s5;
setState_SP(w ,[s5,P6]);
h6 = enthalpy_mass(w);
%% State 7
setState_Psat(w, [P7,0]);
h7 = enthalpy_mass(w);
s7 = entropy_mass(w);
%% State 8
setState_Psat(w ,[P8 ,1]);
h8 = enthalpy_mass(w);
s8 = entropy_mass(w);
%% State 9
set(w,'P',P9,'T',T9);
h9 = enthalpy_mass(w);
s9 = entropy_mass(w);
%% State 10
s10 = s9;
setState_SP(w, [s10,P10]);
h10 = enthalpy_mass(w);
%% State 1
set(w,'P',P1,'T',T1);
h1 = enthalpy_mass(w);
s1 = entropy_mass(w);
%% State 1_
s1_ = s1;
setState_SP(w,[s1_,P1_]);
h1_ = enthalpy_mass(w);
%% State 2
s2 = s1;
setState_SP(w ,[s2 ,P2]);
h2 = enthalpy_mass(w);
setState_Psat(w ,[P2,0]);
hf = enthalpy_mass(w);
setState_Psat(w ,[P2,1]);
hg = enthalpy_mass(w);
hfg = hg-hf;
x = (h2-hf)/hfg;
m4_5 = ((h1_-h5)/(h1_-h4));
qout = m4_5*(h2-h3);
qin = h9-h6+h1-h10;
efficiency = 1-(qout/qin);

fprintf("The quality of the modified rankine cycle is %.4f %%\n", x*100);
fprintf("The efficiency of the modified rankine cycle is %.4f %%\n", efficiency*100);






