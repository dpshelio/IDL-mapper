function calculate_g,planet_str,name=name
  if n_elements(name) eq 0 then name='earth'
  if ~isstruct(planet_str) then planet_str=planetprop(name)
  Gconst = 6.67384e-11 ; N m2 kg-2
  
  g = Gconst * planet_str.mass / planet_str.rad^2
  return,g
end
pro WeightInPlanet,mass,planet=planet

  if n_elements(planet) eq 0 then planet='Earth'
  if n_elements(mass) eq 0 then begin
     mass=0
     read,prompt='Input mass[kg]: ',mass
  endif
  planet_prop = PlanetProp(planet)
  g = calculate_g(planet_prop)
  weight = mass * g
  print, 'The weight in '+planet+' is: '+string(weight)+' N'

end ;WeightInPlanet
