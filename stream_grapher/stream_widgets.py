#!/usr/bin/env python
# -*- coding: UTF-8 -*-

# Copyright (c) 2009 Piccinini Santiago
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

import itertools
import pyglet.graphics
import math
sample_rate=1000


def from_iterable(iterables):
    # chain.from_iterable(['ABC', 'DEF']) --> A B C D E F
    for it in iterables:
        for element in it:
            yield element

def flatten(listOfLists):
    return list(itertools.chain(from_iterable(listOfLists)))

class Grid(object):
    def __init__(self, size, position, color=(100,255,100), h_sep=50, v_sep=50):

        self.size = size
        self.position = position
        self.color = color
        self.h_sep = h_sep
        self.v_sep = v_sep

        v_center = position[1] + self.size[1]/2       
        auxs = range(0, size[1]/2+1, v_sep) + range(0,-size[1]/2-1,-v_sep)[1:] #acá me armo una secuencia de -screenHeight/2 a ScreenHeight/2 con pasos v_sep
        num_h_lines = len(auxs)
        h_vertexs = flatten([(position[0], y + v_center, position[0]+size[0], y + v_center) for y in auxs])

        num_v_lines = size[0]/ h_sep + 1         
        v_vertexs = flatten([(position[0]+x*h_sep, position[1], position[0]+x*h_sep, position[1]+size[1]) for x in range(num_v_lines)])
        
        h_colors = flatten([self.color for x in range(num_h_lines*2)])
        v_colors = flatten([self.color for x in range(num_v_lines*2)])
        self.h_vertex_list = pyglet.graphics.vertex_list(num_h_lines*2, ('v2f\static', h_vertexs), ("c3B\static", h_colors))
        self.v_vertex_list = pyglet.graphics.vertex_list(num_v_lines*2 , ('v2f\static', v_vertexs), ("c3B\static", v_colors))
        
    def draw(self):
        self.h_vertex_list.draw(pyglet.gl.GL_LINES)
        self.v_vertex_list.draw(pyglet.gl.GL_LINES)


class StreamGraph(object):
    def __init__(self, n_samples, size, position, line_color, graph_num, amplification=5):
        
	self.n_samples = n_samples
        self.samples = [0] * n_samples
        self.actual_sample_index = 0
	self.width = size[0]
        self.heigth = size[1]/4
	old_height=size[1];
        self.position = position
        self.color = line_color
	self.amplification = amplification
	self.graph_num=graph_num
        line_color+=(255,)
	self.label_color=line_color
        
        
        vertexs = self._vertex_list_from_samples(self.samples)
        colors = flatten([self.color for x in range(n_samples)])
        self._vertex_list = pyglet.graphics.vertex_list(n_samples, ('v2f\stream', vertexs), ("c3B\static", colors))
        
        self.grid = Grid((size[0], size[1]-100), position, h_sep=50, v_sep=50)
        
        self.samples_per_h_division = int(self.n_samples * float(self.grid.h_sep) / float(self.width))
        self.samples_per_h_division_label = pyglet.text.Label(str(float(self.samples_per_h_division*1000/sample_rate))+ "mseg/div", font_size=14, x=size[0]/2.0 + position[0]-80*(math.pow(-1,self.graph_num)), y=position[1]- 10, anchor_x='center', anchor_y='center',color=self.label_color)
                          
        self.values_per_v_division = int(self.grid.v_sep / float(self.amplification))
        self.values_per_v_division_label = pyglet.text.Label("CH" + str(self.graph_num)+":"+str(self.values_per_v_division)+"/div",font_size=10, x=position[0]-40, y=position[1]+self.heigth/2.0-20*(math.pow(-1,self.graph_num)), anchor_x='center', anchor_y='center',color=self.label_color)

	self.up_label = pyglet.text.Label("UP: +", font_size=12, x=position[0]-45, y=position[1]+old_height*0.75, anchor_x='center', anchor_y='center')

	self.down_label = pyglet.text.Label("DOWN: -", font_size=12, x=position[0]-45, y=position[1]+old_height*0.70, anchor_x='center', anchor_y='center')

	self.W_label = pyglet.text.Label("w: up", font_size=12, x=position[0]-45, y=position[1]+old_height*0.60, anchor_x='center', anchor_y='center')

	self.S_label = pyglet.text.Label("s: down", font_size=12, x=position[0]-45, y=position[1]+old_height*0.55, anchor_x='center', anchor_y='center')

	self.R_label = pyglet.text.Label("r: reset", font_size=12, x=position[0]-45, y=position[1]+old_height*0.45, anchor_x='center', anchor_y='center')

    
    def draw(self, samples):
        "Add a list of samples to the graph and then draw it"
        self.add_samples(samples)
        self.grid.draw()
        self._vertex_list.draw(pyglet.gl.GL_LINE_STRIP)
        self.samples_per_h_division_label.draw()
        self.values_per_v_division_label.draw()
	self.up_label.draw()
	self.down_label.draw()
	self.W_label.draw()
	self.S_label.draw()
	self.R_label.draw()

    def redraw(self):
        "Draw the graph"
        self.grid.draw()
        self._vertex_list.draw(pyglet.gl.GL_LINE_STRIP)
        self.samples_per_h_division_label.draw()
        self.values_per_v_division_label.draw()
	self.up_label.draw()
	self.down_label.draw()
	self.W_label.draw()
	self.S_label.draw()
	self.R_label.draw()

    def add_samples(self, samples):
        "Add a list of samples to the graph"
        for sample in samples:
            index = self.actual_sample_index
            self.samples[index] = sample
            self._vertex_list.vertices[index*2:index*2+2] = self._vertex_from_sample(sample, index)
            self.actual_sample_index +=1
            if self.actual_sample_index >= self.n_samples:
                    self.actual_sample_index = 0

    def set_n_samples(self, n_samples):
        "Set a new value of n_samples"
        if n_samples <=0:
            raise AttributeError("n_samples must be > 0")
        self.n_samples = n_samples
        new_samples = [0]*n_samples
        for i in range(n_samples):
            try:
                new_samples[i] = self.samples[i]
            except IndexError:
                break
        self.samples = new_samples
        self._vertex_list.resize(n_samples)
        self._regenerate_vertex_list()
        self.set_color(self.color)
        self.actual_sample_index = min(self.actual_sample_index, n_samples-1)
        
        self.samples_per_h_division = int(self.n_samples * float(self.grid.h_sep) / float(self.width))
        self.samples_per_h_division_label.text  = str(float(self.samples_per_h_division*1000/sample_rate))+ "mseg/div"

    def set_amplification(self, amplification):
        self.amplification = amplification
        self._regenerate_vertex_list()
        self.values_per_v_division = int(self.grid.v_sep / float(self.amplification))
        self.values_per_v_division_label.text = "CH" + str(self.graph_num)+":"+str(self.values_per_v_division)+"/div"

    def set_position(self, position):
 	self.position=position
        self._regenerate_vertex_list()

    def set_color(self, color):
        colors = tuple(flatten([color for x in range(self.n_samples)])) 
        self._vertex_list.colors = colors
 
    def _regenerate_vertex_list(self):
        "Regenerates the internal vertex list from self.samples data"
        self._vertex_list.vertices = self._vertex_list_from_samples(self.samples)

    def _vertex_list_from_samples(self, samples):
        vertex_list = []
        for index, sample in enumerate(self.samples):
            vertex_list.extend(self._vertex_from_sample(sample, index))
        return vertex_list

    def _vertex_from_sample(self, sample, index):
        x = self.position[0] + index * self.width / float(self.n_samples)
        y = self.position[1] + self.heigth/2 + self.samples[index] * self.amplification
        return  x, y

class StreamWidget(object):
    def __init__(self, n_samples, size, position, line_color, graph_num):
        self.graph = StreamGraph(n_samples, size, position, line_color, graph_num)
        self.size = size

    def draw(self, samples):
       self.graph.draw(samples)

    def redraw(self):
       self.graph.redraw()
    
    def set_n_samples(self, n_samples):
        "Resize samples per widget"
        self.graph.set_n_samples(n_samples)
