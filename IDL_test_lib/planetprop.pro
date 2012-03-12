function planetprop,planet,mass=mass,rad=rad
  if n_elements(planet) eq 0 then planet='Earth'
  planet_names = ['mercury','venus','earth','mars']
  planet_mass = [3.3022e23,4.868e24,5.9736e24,6.4185e23];kg
  planet_rad  = [2439.7,6051.8,6371.0,3396.2]*1e3 ;m

  properties = {name:'',mass:0.,rad:0.}
  planet_lab = where(strupcase(planet) eq strupcase(planet_names),npos)
  if npos eq 1 then begin
     properties.name = planet_names[planet_lab]
     properties.mass = planet_mass[planet_lab]
     properties.rad  = planet_rad[planet_lab]
  endif else begin
     if n_elements(mass) eq 0 then mass = planet_mass[2]
     if n_elements(rad)  eq 0 then rad  = planet_rad[2]
     properties.name = planet
     properties.mass = mass
     properties.rad = rad
  endelse
  return,properties
end
