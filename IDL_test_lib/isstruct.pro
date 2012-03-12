function isstruct,elem
  elem_size = size(elem)
  strT = (elem_size[elem_size[0]+1] eq 8)?1b:0b
  return,strT
end
