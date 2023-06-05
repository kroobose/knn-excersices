function true = is_octave();

% true if octave is running.
%  2: development version
%  1: stable version
%  0: not octave

if exist('OCTAVE_VERSION')
  true = 1;
else
  true = 0;
end
