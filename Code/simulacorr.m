function [stsim vtsim lndctsim lnrfsim]=simulacorr(rho)

global ncalc gamma sig g phi beta B s_bar seedval

%% Smulando choques do processo de consumo com correla��o controlada rho

T=ncalc;
randn('seed',seedval);
x = sig*randn(T,1);
y = sig*randn(T,1);

vtsim = rho*x + sqrt(1-rho^2)*y; % Controlando a correla��o dos processos de consumo.
lndctsim = g + vtsim;

%% Simular vari�vel de estado log(S)

stsim = zeros(T+1,1);

stsim(1) = s_bar;          % A economia come�a no seu estado estacion�rio.

for i=2:T+1
    
    stsim(i) = strans(stsim(i-1),vtsim(i-1));

end

%% Log de Rf variante no tempo

lnrfsim = -log(beta)+gamma*g-(gamma*(1-phi)-B)/2-B*(stsim-s_bar); 

end