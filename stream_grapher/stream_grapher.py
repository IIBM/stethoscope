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
    com="/dev/ttyUSB0"
    #com="/dev/ttyUSB1"
    #com="/dev/ttyACM0"
    #com="COM4"   #/dev/ttyACM0 para la compu con Ubuntu
    if com == "":
        spiro = Spiro(timeout=0.5)
    else :
        spiro = Spiro(port=com, timeout=0.5)
    spiro.run()
    backend = "spiro"

    import os.path
    import datetime

    save_path='./Data/'
    today= datetime.date.today()

    out_file_name_c1 = subjectID+ "_dataECG_"+str(today)+"_c1.log"
    out_file_name_c2 = subjectID+ "_dataECG_"+str(today)+"_c2.log"
    completeName_c1= os.path.join(save_path, out_file_name_c1)
    completeName_c2= os.path.join(save_path, out_file_name_c2)
    out_file_c1= open(completeName_c1, "w")
    out_file_c2= open(completeName_c2, "w")

else:
    backend = "math"
    
from filters.iir_filter import IIRFilter
filt_45hz_2nd_c1 = IIRFilter((1.0, 2.0, 1.0),(1.0, -1.6692031429, 0.7166338735))
filt_45hz_2nd_c2 = IIRFilter((1.0, 2.0, 1.0),(1.0, -1.6692031429, 0.7166338735))
    
    
from filters.notch import Notch
notch_c1_50Hz = Notch(1/1000.0,50.45, 2.0) #Filtra 50Hz
#notch_c1_50Hz = Notch(1/1000.0,50.0, 2.0) #Filtra 50Hz
notch_c2_50Hz = Notch(1/1000.0,50.45, 2.0)

import pyglet
from pyglet.window import key
import random, math

#import ctypes
#user32 = ctypes.windll.user32

#SIZE = (user32.GetSystemMetrics(0), user32.GetSystemMetrics(1))
SIZE= (1024,600)
N_SAMPLES = 250

#SCALE = 3.3/4096.0 #cuanto representa 1 muestra en tension, revisar
#SCALE = 2.42/6/((2**23)-1) #cuanto representa 1 muestra en tension, revisar
SCALE =256*(2.42/6/((2**23)-1)) #cuanto representa 1 muestra en tension, revisar

config = pyglet.gl.Config(double_buffer=True, buffer_size=24)
window = pyglet.window.Window(SIZE[0], SIZE[1], config=config)
#window.set_vsync(False)
fps_display = pyglet.clock.ClockDisplay()

#stream_widget1 = StreamWidget(N_SAMPLES, (SIZE[0], SIZE[1]), (100,100), (255,0,90), 1)
#stream_widget2 = StreamWidget(N_SAMPLES, (SIZE[0], SIZE[1]), (100,100), (255,255,0), 2)

stream_widgets=[]
baseparam = {}
baseparam['position'] = [(100,340),(100,260),(100,180),(100,100)]
baseparam['amp'] = [100,100,100,100]
baseparam['color'] = [(255,0,90),(255,255,0),(255,127,0),(255,127,125)]

if ( (len(baseparam['amp']) != len(baseparam['position']) ) or (len(baseparam['color']) != len(baseparam['position'])) ):
  raise ValueError('Cantidades de parametros incorrecta')

for i in range(len(baseparam['position'])) :
  stream_widgets.append(StreamWidget(N_SAMPLES, (SIZE[0]-124, SIZE[1]-150), (100,100), baseparam['color'][i], i+1))

for i in range(len(stream_widgets)):
  stream_widgets[i].graph.set_position(baseparam['position'][i])
  stream_widgets[i].graph.set_amplification(baseparam['amp'][i])

paused = False
stream_widget_ind = 0

@window.event
def on_draw():
  global paused
  if not paused:
    window.clear()
    for i in stream_widgets:
      i.redraw()
    fps_display.draw()


@window.event
def on_mouse_press(x, y, button, modifiers):
    pass

freq=50  #DEBUG
@window.event
def on_key_press(symbol, modifiers):

  global stream_widget_ind
  global freq  #DEBUG

  if (symbol >= key._1) and (symbol <= key._5):
    if ( ((symbol - key._1 + 1) > 0) and ((symbol - key._1 + 1) <= len(stream_widgets)) ):
      stream_widget_ind=(symbol - key._1)

  elif symbol == key.RIGHT: # Increase sample per screen in 20%
    n_samples = stream_widgets[stream_widget_ind].graph.n_samples
    for i in stream_widgets:
      #i.graph.set_n_samples(int(math.ceil(n_samples + n_samples*0.2 )))
      i.graph.set_n_samples(int(math.ceil(n_samples + 500 )))
  elif symbol == key.LEFT: # Decrease sample per screen in 20%
    n_samples = stream_widgets[stream_widget_ind].graph.n_samples
    #new_n_samples = int(n_samples - n_samples*0.2)
    new_n_samples = int(n_samples - 50)
    if new_n_samples > 1:
      for i in stream_widgets:
        i.graph.set_n_samples(new_n_samples)

  elif symbol == key.UP:
      old_amplification = stream_widgets[stream_widget_ind].graph.amplification
      stream_widgets[stream_widget_ind].graph.set_amplification(old_amplification + old_amplification * 0.4)
  elif symbol == key.DOWN:
      old_amplification = stream_widgets[stream_widget_ind].graph.amplification
      stream_widgets[stream_widget_ind].graph.set_amplification(old_amplification - old_amplification * 0.4)

  elif symbol == key.W:
      old_position = stream_widgets[stream_widget_ind].graph.position
      new_position=(old_position[0], old_position[1]+30)
      stream_widgets[stream_widget_ind].graph.set_position(new_position)
  elif symbol == key.S:
      old_position = stream_widgets[stream_widget_ind].graph.position
      new_position=(old_position[0], old_position[1]-30)
      stream_widgets[stream_widget_ind].graph.set_position(new_position)

  elif symbol == key.R:
      for i in range(len(stream_widgets)):
        stream_widgets[i].graph.set_position(baseparam['position'][i])
        stream_widgets[i].graph.set_amplification(baseparam['amp'][i])

  elif symbol == key.P:
      global paused
      if paused == True:
        paused = False
      else:
        paused = True

  #DEBUG
  elif symbol == key.E:
      freq = freq + 1
  elif symbol == key.D:
      freq = freq - 1
  #DEBUG
tau = 2*math.pi  #DEBUG
it=0  #DEBUG
def update(dt):
    global last_sample
    if backend == "math":  #DEBUG
        global it
        global freq
        samples_c1= [t**3/40.0 for t in range(-20,20)]
        samples_c2= [4096/2*(math.sin((it+t)/1000.0*tau*freq)+0.5) for t in range(0,40)]
        it = it + 40
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
        
        #out_file_c1.write("\n".join([str(sample) for sample in samples])+"\n")
    stream_widgets[0].graph.add_samples([sample*SCALE for sample in samples_c1])
    stream_widgets[2].graph.add_samples([sample*SCALE for sample in samples_c2])
    stream_widgets[1].graph.add_samples([filt_45hz_2nd_c1(sample)*SCALE for sample in samples_c1])
    stream_widgets[3].graph.add_samples([filt_45hz_2nd_c2(sample)*SCALE for sample in samples_c2])
    
    #stream_widgets[1].graph.add_samples([notch_c1_50Hz(sample)*SCALE for sample in samples_c1])
    #stream_widgets[3].graph.add_samples([notch_c2_50Hz(sample)*SCALE for sample in samples_c2])
      
pyglet.clock.schedule_interval(update, 0.05)

pyglet.app.run()
