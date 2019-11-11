function [news]=strans(s,v)
% Strans procedure                                                        %
% This function will return the value of s {t + 1} = log (S {t + 1})      %
% s {t + 1} = (1-phi) * s_bar + phi * s {t} + lambda (s {t}) * v {t + 1}; %
global s_bar phi debug

news = (1-phi)*s_bar + phi*s + lambda(s) * v;

debug(:,1)=news';
end