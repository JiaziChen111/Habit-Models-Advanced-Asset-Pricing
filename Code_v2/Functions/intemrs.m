function [out]=intemrs(v)

% Retornar� a taxa marginal de substitui��o de tal forma que possa ser    %
% utilizada na integra��o do ponto fixo.                                  %
% ----------------------------------------------------------------------- %

global sig
out = (1/(sig*(2*pi)^(.5)))*exp(-.5*(v/sig).^2).*mrsinsd(v);
end