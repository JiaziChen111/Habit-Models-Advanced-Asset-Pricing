function [alndctsim astsim alnpctsim alnrtsim alnrfsim asdlnrtsim alnchpsim ...
    alnysim aelnrcbsim asdlnrcbsim atesterf]=annvars(dc,lnpc,er,elnr,sdr,sdlnr,elnrcb,sdlnrcb,lny,lnrf1)

% Este programa trabalha sobre os dados vindos de simvars quando estes s�o
% simulados fora dos dados reais, isto �, ncalc dados. Ser�o anualizados
% os retornos esperados. Falta anualizar os retornos dos t�tulos (bonds)
% simulados.

global tsc bondsel ann ncalc

%% Rodando as s�ries temporais artificiais
[stsim vtsim lndctsim lnpctsim lnrtsim lnrfsim ertsim elnrtsim sdrtsim...
    sdlnrtsim elnrcbsim sdlnrcbsim lnysim lnrcbsim testerf]=simvars(dc,lnpc,er,elnr,sdr,sdlnr,elnrcb,sdlnrcb,lny,lnrf1);

T = size(stsim,1);

%% Consumo
if ann == 1
    alndctsim=lndctsim;
else
    alnctsim = cumsum(lndctsim);    
    % Torna mensal a evolu��o do log do
   alnctsim = log(chgfreq(exp(alnctsim),tsc,tsc,0));
    %alnctsim = log(exp(alnctsim));
    alndctsim = alnctsim(2:size(alnctsim,1))-alnctsim(1:(size(alnctsim,1)- 1));
    
end

%% Vari�vel de estado do modelo
if T > 1
    astsim = chgfreq(stsim(2:T),1,tsc,0);
    %astsim = stsim(2:T);
    astsim = astsim(2:size(astsim,1)); end

%% Raz�o P/C

if size(lnpctsim,1) > 1
    alnpctsim = chgfreq(lnpctsim(2:T),1,tsc,0)-log(tsc);
    %alnpctsim = lnpctsim(2:T)-log(tsc);
    alnpctsim = alnpctsim(2:size(alnpctsim,1));
end

%% Vamos multiplicar os retornos para anualiz�-los if size(lnrtsim,1) > 1
if size(lnrtsim,1) > 1
    alnrtsim = chgfreq(lnrtsim,tsc,tsc,0);
    %alnrtsim = lnrtsim;
    alnrtsim = alnrtsim(2:size(alnrtsim,1));
end

% Retorno livre de risco
% Simulado

if size(lnrfsim,1) > 1
    
    alnrfsim = chgfreq(lnrfsim(1:T-1),tsc,tsc,0);
    %alnrfsim = lnrfsim(1:T-1);
    alnrfsim = alnrfsim(2:size(alnrfsim,1));
end
% Interpolado
if size(testerf,1) > 1
    atesterf = chgfreq(testerf(1:T-1),tsc,tsc,0);
   % atesterf = testerf(1:T-1);
    atesterf = atesterf(2:size(atesterf,1));
end
%% Desvios condicionais dos retornos
if size(sdlnrtsim,1) > 1
    asdlnrtsim = chgfreq(sdlnrtsim,tsc,tsc,0);
    %asdlnrtsim = sdlnrtsim;
    asdlnrtsim = asdlnrtsim(2:size(asdlnrtsim,1)); end
%% Evolu�ao dos pre�os
if size(lnpctsim,1) > 1
    lnchpsim = lnpctsim(2:T)-lnpctsim(1:T-1)+lndctsim;
    alnchpsim = chgfreq(lnchpsim,tsc,tsc,0);
    %alnchpsim = lnchpsim;
    alnchpsim = alnchpsim(2:size(alnchpsim,1));
end
%% Yields
if size(lnysim,1) > 1
    for i=1:length(bondsel)+1
     alnysim(:,i) = chgfreq(lnysim(1:T-1,i),tsc,tsc,0);
  %   alnysim(:,i) = lnysim(1:T-1,i);
    end
    alnysim = alnysim(2:size(alnysim,1),:); end
%% Bonds
% Retorno m�dio
if size(elnrcbsim,1) > 1
    for i=1:length(bondsel)+1
       aelnrcbsim(:,i) = chgfreq(elnrcbsim(1:T-1,i),tsc,tsc,0);
      % aelnrcbsim(:,i) = elnrcbsim(1:T-1,i);
    end
    
    aelnrcbsim = aelnrcbsim(2:size(aelnrcbsim,1),:);
end

% Desvio
if size(sdlnrcbsim,1) > 1
    for i=1:length(bondsel)
        asdlnrcbsim(:,i) = chgfreq(sdlnrcbsim(1:T-1,i+1),tsc,tsc,0);
    %   asdlnrcbsim(:,i) = sdlnrcbsim(1:T-1,i);
    end
    
    asdlnrcbsim = asdlnrcbsim(2:size(asdlnrcbsim,1),:);
end
end