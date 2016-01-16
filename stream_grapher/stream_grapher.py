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

''' A "real-time" stream grapher.
'''
from stream_widgets import StreamWidget

#variable global para el inicio del muestreo-> considero que la primerísima muestra levantada es del canal 1
last_sample="C2"

subjectID= raw_input("Ingrese el nombre del paciente: ")
#backend = raw_input("Choose backend: 1 = Spiro,  2 = x^3: ")

#Acá elijo el backend para que Mario no lo tenga que tipear
backend= "1"
if backend == "1":
    from backends.spiro_com import Spiro
    #com = raw_input("COM port:")
    com="/dev/ttyACM0"
    #com="COM4"   #/dev/ttyACM0 para la compu con Ubuntu
    if com == "":
        spiro = Spiro(timeout=0.5)
    else :
        spiro = Spiro(port=com, timeout=0.5)
    spiro.run()
    backend = "spiro"

    import os.path
    import datetime

    save_path='/home/biomedica/Escritorio/stream_grapher/Data'
    today= datetime.date.today()
	
    out_file_name_c1 = subjectID+ "_dataECG_"+str(today)+"_c1.log"
    out_file_name_c2 = subjectID+ "_dataECG_"+str(today)+"_c2.log"
    completeName_c1= os.path.join(save_path, out_file_name_c1)
    completeName_c2= os.path.join(save_path, out_file_name_c2)
    out_file_c1= open(completeName_c1, "w")
    out_file_c2= open(completeName_c2, "w")

    from filters.iir_filter import IIRFilter
    filt_45hz_2nd = IIRFilter((1.0, 2.0, 1.0),(1.0, -1.6692031429, 0.7166338735))
    
else:
    backend = "math"
    

import pyglet
from pyglet.window import key
import random, math

#import ctypes
#user32 = ctypes.windll.user32

#SIZE = (user32.GetSystemMetrics(0), user32.GetSystemMetrics(1))
SIZE= (1024,600)
N_SAMPLES = 1500

config = pyglet.gl.Config(double_buffer=True, buffer_size=24)
window = pyglet.window.Window(SIZE[0], SIZE[1], config=config)
#window.set_vsync(False)
fps_display = pyglet.clock.ClockDisplay()


stream_widget1 = StreamWidget(N_SAMPLES, (SIZE[0], SIZE[1]), (100,100), (255,0,90), 1)
stream_widget2 = StreamWidget(N_SAMPLES, (SIZE[0], SIZE[1]), (100,100), (255,255,0), 2)

@window.event
def on_draw():
    window.clear()
    stream_widget1.redraw()
    stream_widget2.redraw()
    fps_display.draw()


@window.event
def on_mouse_press(x, y, button, modifiers):
    pass

@window.event
def on_key_press(symbol, modifiers):

    global stream_widget_x

    if symbol == key._1:
	stream_widget_x=stream_widget1
    elif symbol == key._2:
	stream_widget_x=stream_widget2

    elif symbol == key.RIGHT: # Increase sample per screen in 20%
        n_samples = stream_widget_x.graph.n_samples
        stream_widget_x.graph.set_n_samples(int(math.ceil(n_samples + n_samples*0.2 )))
    elif symbol == key.LEFT: # Decrease sample per screen in 20%
        n_samples = stream_widget_x.graph.n_samples
        new_n_samples = int(n_samples - n_samples*0.2)
        if new_n_samples > 1:
            stream_widget_x.graph.set_n_samples(new_n_samples)
    elif symbol == key.UP:
        old_amplification = stream_widget_x.graph.amplification
        stream_widget_x.graph.set_amplification(old_amplification + old_amplification * 0.4)
    elif symbol == key.DOWN:
        old_amplification = stream_widget_x.graph.amplification
        stream_widget_x.graph.set_amplification(old_amplification - old_amplification * 0.4)
    elif symbol == key.W:
	old_position = stream_widget_x.graph.position
	new_position=(old_position[0], old_position[1]+30)
        stream_widget_x.graph.set_position(new_position)
    elif symbol == key.S:
	old_position = stream_widget_x.graph.position
	new_position=(old_position[0], old_position[1]-30)
        stream_widget_x.graph.set_position(new_position)
    elif symbol == key.R:
	new_position=(100, 100)
        stream_widget_x.graph.set_position(new_position)
        stream_widget_x.graph.set_amplification(5)


def update(dt):
    global last_sample
    if backend == "math":
        stream_widget1.graph.add_samples([t**3/4.0 for t in range(-10,11)])
    elif backend == "spiro":
        samples = spiro.get_remaining_samples()

	#Acá me quedo con las muestras pares y las impares
	samples_even=samples[0::2]
	samples_odd=samples[1::2]
	
        #Como el número de muestras puede ser par o impar, puede que la última muestra del sampleo anterior
	#haya sido del canal 1 o del canal 2. Esto me lo indica la variable last_sample, y en base a ella
	#para el vector de muestras actual sé si los elementos pares son del c1 o del c2 (lo mismo para los
	#impares). Finalmente en base a esto actualizo la variable last_sample.

	if last_sample=="C2":

			samples_c1=samples_even
			samples_c2=samples_odd
			if (len(samples)%2==0): #acá pregunto si el resto de dividir la long del arreglo por 2 es cero (PAR)
				last_sample="C2"
			else:
				last_sample="C1"

	else:
			samples_c2=samples_even
			samples_c1=samples_odd
			if (len(samples)%2==0): 
				last_sample="C1"
			else:
				last_sample="C2"
		
        out_file_c1.write("\n".join([str(sample) for sample in samples_c1])+"\n")
	out_file_c2.write("\n".join([str(sample) for sample in samples_c2])+"\n")
        #stream_widget1.graph.add_samples([filt_45hz_2nd(sample)/90.0 for sample in samples])
        
        stream_widget1.graph.add_samples([sample/90.0 for sample in samples_c1])
	stream_widget2.graph.add_samples([sample/90.0 for sample in samples_c2])


pyglet.clock.schedule_interval(update, 0.05)

pyglet.app.run()
