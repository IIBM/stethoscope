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
#sample_rate=1000.0
sample_rate=250.0


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
        old_height = 500

        self.up_label = pyglet.text.Label(u'\u2191'+": amplif", font_size=12, x=5, y=position[1]+size[1]-20, anchor_x='left', anchor_y='center')
        self.down_label = pyglet.text.Label(u'\u2193'+": aten", font_size=12, x=5, y=position[1]+size[1]-40, anchor_x='left', anchor_y='center')
        self.W_label = pyglet.text.Label("w: up", font_size=12, x=5, y=position[1]+size[1]-60, anchor_x='left', anchor_y='center')
        self.S_label = pyglet.text.Label("s: down", font_size=12, x=5, y=position[1]+size[1]-80, anchor_x='left', anchor_y='center')
        self.R_label = pyglet.text.Label("r: reset", font_size=12, x=5, y=position[1]+size[1]-100, anchor_x='left', anchor_y='center')
        self.P_label = pyglet.text.Label("p: pause", font_size=12, x=5, y=position[1]+size[1]-120, anchor_x='left', anchor_y='center')
        self.C_label = pyglet.text.Label("c: center", font_size=12, x=5, y=position[1]+size[1]-140, anchor_x='left', anchor_y='center')
        self.M_label = pyglet.text.Label("m: max amp", font_size=12, x=5, y=position[1]+size[1]-160, anchor_x='left', anchor_y='center')
        self.G_label = pyglet.text.Label("g: guardar", font_size=12, x=5, y=position[1]+size[1]-180, anchor_x='left', anchor_y='center')
        
    def draw(self):
        self.h_vertex_list.draw(pyglet.gl.GL_LINES)
        self.v_vertex_list.draw(pyglet.gl.GL_LINES)
        self.up_label.draw()
        self.down_label.draw()
        self.W_label.draw()
        self.S_label.draw()
        self.R_label.draw()
        self.P_label.draw()
        self.C_label.draw()
        self.M_label.draw()
        self.G_label.draw()


class StreamGraph(object):
    def __init__(self, n_samples, size, position, line_color, graph_num, amplification=5):
        
        self.n_samples = n_samples
        self.samples = [0] * n_samples
        self.actual_sample_index = 0
        self.width = size[0]
        self.height = size[1]/4
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
        self.Ref = pyglet.text.Label("0", font_size=12, x=position[0]-10, y=position[1]+self.height/2, anchor_x='left', anchor_y='center',color=self.label_color)
        
        self.grid = Grid((size[0], size[1]-100), position, h_sep=50, v_sep=50)
        
        if (self.graph_num==1):
          self.samples_per_h_division = self.n_samples * float(self.grid.h_sep) / float(self.width)
          self.samples_per_h_division_label = pyglet.text.Label(" ms/div", font_size=14, x=size[0]/2.0 + position[0], y=position[1] - 10, anchor_x='center', anchor_y='center',color=self.label_color)
          if (self.samples_per_h_division > sample_rate):
            self.samples_per_h_division_label.text  = '%6.2f' % (self.samples_per_h_division/sample_rate) + " s/div"
          elif (self.samples_per_h_division > (sample_rate/1000.0)):
            self.samples_per_h_division_label.text  = '%6.2f' % (self.samples_per_h_division*1000.0/sample_rate) + " ms/div"
          else :
            self.samples_per_h_division_label.text  = '%6.2f' % (self.samples_per_h_division*1000000.0/sample_rate) + " us/div"
                          
        self.values_per_v_division = self.grid.v_sep / float(self.amplification)

        if (self.graph_num==1):
            texto_canal="CH 1 (1): "
        elif (self.graph_num==2):
            texto_canal="CH 1 filt. (2): "
        elif (self.graph_num==3):
            texto_canal="CH 2 (3): "
        elif (self.graph_num==4):
            texto_canal="CH 2 filt. (4): "

        self.values_per_v_division_label = pyglet.text.Label(texto_canal+'%6.2f' % self.values_per_v_division+" uV/div",font_size=14, x=position[0]+size[0]/2.0-100+((self.graph_num+1)%2)*300, y=position[1] - 40 - (((self.graph_num-1)/2)%2)*30, anchor_x='center', anchor_y='center',color=self.label_color)

        self.guardando_label = pyglet.text.Label("GUARDANDO", font_size=12, x=50, y=position[1]+size[1]-500, anchor_x='left', anchor_y='center')
        self.guardando_label.draw()
    
    def draw(self, samples):
        "Add a list of samples to the graph and then draw it"
        self.add_samples(samples)
        self.grid.draw()
        self.Ref.draw()
        self._vertex_list.draw(pyglet.gl.GL_LINE_STRIP)
        if (self.graph_num == 1):
          self.samples_per_h_division_label.draw()
        self.values_per_v_division_label.draw()

    def redraw(self):
        "Draw the graph"
        self.grid.draw()
        self.Ref.draw()
        self._vertex_list.draw(pyglet.gl.GL_LINE_STRIP)
        if (self.graph_num == 1):
          self.samples_per_h_division_label.draw()
        self.values_per_v_division_label.draw()

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
            try :
                new_samples[i] = self.samples[i]
            except IndexError:
                break
        self.samples = new_samples
        self._vertex_list.resize(n_samples)
        self._regenerate_vertex_list()
        self.set_color(self.color)
        self.actual_sample_index = min(self.actual_sample_index, n_samples-1)
        
        if (self.graph_num == 1):
          self.samples_per_h_division = self.n_samples * float(self.grid.h_sep) / float(self.width)
          if (self.samples_per_h_division > sample_rate):
            self.samples_per_h_division_label.text  = '%6.2f' % (self.samples_per_h_division/sample_rate) + "  s/div"
          elif (self.samples_per_h_division > (sample_rate/1000.0)):
            self.samples_per_h_division_label.text  = '%6.2f' % (self.samples_per_h_division*1000.0/sample_rate) + " ms/div"
          else :
            self.samples_per_h_division_label.text  = '%6.2f' % (self.samples_per_h_division*1000000.0/sample_rate) + " us/div"


    def set_amplification(self, amplification):
        self.amplification = amplification
        self._regenerate_vertex_list()
        self.values_per_v_division = self.grid.v_sep / float(self.amplification)
        
        if (self.graph_num==1):
            texto_canal="CH 1 (1): "
        elif (self.graph_num==2):
            texto_canal="CH 1 filt. (2): "
        elif (self.graph_num==3):
            texto_canal="CH 2 (3): "
        elif (self.graph_num==4):
            texto_canal="CH 2 filt. (4): "
        
        if (self.values_per_v_division > 1.0):
          self.values_per_v_division_label.text = texto_canal+'%6.2f' % (self.values_per_v_division )+"  V/div"
        elif ((self.values_per_v_division*1000.0) > 1.0):
          self.values_per_v_division_label.text = texto_canal+'%6.2f' % (self.values_per_v_division*1000.0)+" mV/div"
        else :
          self.values_per_v_division_label.text = texto_canal+'%6.2f' % (self.values_per_v_division*1000000.0)+" uV/div"

    def set_position(self, position):
        self.position=position
        self.Ref = pyglet.text.Label("0", font_size=12, x=position[0]-10, y=position[1]+self.height/2, anchor_x='left', anchor_y='center',color=self.label_color)
        self._regenerate_vertex_list()

    def set_color(self, color):
        colors = tuple(flatten([color for x in range(self.n_samples)])) 
        self._vertex_list.colors = colors

    def center_position(self):
        "Centers vertical position of the signal"
        v_med = ((max(self.samples)+min(self.samples))/2)*self.amplification #Valor medio de la señal, pasado a pixels
        center = self.height*2-v_med #height es el alto de la pantalla /4
        center_position=(self.position[0], center)
        self.set_position(center_position)

    def max_amplification(self):
        "Amplificates or attenuates the signal to fit all the screen"
        total_height=self.height*4
        amplitude = max(self.samples)-min(self.samples)
        if (amplitude < total_height):
            max_amp = total_height/amplitude
        else:
            max_amp = amplitude/total_height
        self.set_amplification(max_amp)
        self.center_position()
 
    def mostrar_cartel_guardando(self):
        self.grid.draw()
        self.Ref.draw()
        if (self.graph_num == 1):
            self.guardando_label.draw()
#    
#    def ocultar_cartel_guardando(self):
#        self.guardando_label.undraw()
#        self.grid.draw()
#        self.Ref.draw()

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
        y = self.position[1] + self.height/2 + self.samples[index] * self.amplification
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
