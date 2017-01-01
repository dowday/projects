function define_f()
  global f;

  keys = {
      '0', '1', ...
      '00', '01', '10', '11', ...
      '000', '001', '010', '011', '100', '101', '110', '111' };

  values = {
    2, 1, ...
    2, 1, 2, 0, ...
    0, 1, 1, 0, 2, 0, 0, 0 };
    
  f = containers.Map(keys, values);

end