import pygraphviz as pgv

A = pgv.AGraph(directed=True)

execfile('py_var')

if type(pro) == type('a'):
    A.add_node(pro,color='red')
else:
    A.add_nodes_from(pro,color='red')
if type(fun) == type('a'):
    A.add_node(fun,color='green')
else:
    A.add_nodes_from(fun,color='green')
A.add_edges_from(edge_list,color='blue')
A.write('map.dot')
A.layout('circo')
A.draw('map.png')
