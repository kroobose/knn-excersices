function true = is_matlab();

% true if matlab is running

if exist('OCTAVE_VERSION')
  true = 0;
else
  true = 1;
end
