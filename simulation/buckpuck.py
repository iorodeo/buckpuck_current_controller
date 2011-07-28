"""
Copyright 2010  IO Rodeo Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""
#!/usr/bin/python
from __future__ import division
import numpy
import pylab
import math
import copy

def digipot_plot():
    Vcc = 5
    Ri = 1000
    Rp = 5000
    Vt0 = 1.65
    Vt1 = 4.2
    Cmax = 1
    digiPotValueMin = 256
    digiPotValueMax = 0

    m = 1/(Vt0 - Vt1)
    C0 = Cmax - m*Vt0

    Rp0 = numpy.linspace(0,Rp)
    Rp1 = Rp - Rp0

    R2 = numpy.divide((Ri*Rp1),(Ri + Rp1))
    Vc = Vcc*numpy.divide(R2,(Rp0 + R2))
    C = m*Vc + C0

    digiPotValues = numpy.linspace(digiPotValueMin,digiPotValueMax)
    pylab.plot(C,digiPotValues)
    # pylab.plot(digiPotValues,C)

    # If a buffer is used
    # Vc = Vcc*(Rp1/(Rp0 + Rp1))
    # Cb = m*Vc + C0
    # pylab.plot(Cb,digiPotValues)
    # pylab.plot(digiPotValues,Cb)

    # If ground is disconnected from digital pot
    Vc = Vcc*(Ri/(Rp0 + Ri))
    Cg = m*Vc + C0
    pylab.plot(Cg,digiPotValues)
    # pylab.plot(digiPotValues,Cg)

    # Measured, no buffer, ground connected
    # digiPotValuesMeasured = numpy.array([0,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,243,256])
    # CmA = numpy.array([915,914,912,911,909,905,897,874,829,787,733,665,600,513,408,273,105,66,0])
    # CmC = numpy.array([911,910,908,906,902,897,883,860,823,777,729,661,588,500,394,259,93,61,0])
    # CmAl = numpy.array([907,907,906,912,910,907,897,873,835,789,733,667,589,493,384,256,80,19,0])
    # CmAg = numpy.array([914,875,857,831,806,779,746,711,672,627,576,517,448,370,269,153,1,1,0])
    # CmAgl = numpy.array([907,868,851,830,806,778,742,709,666,618,564,497,425,344,249,130,0,0,0])
    # CmA = CmA/1000
    # CmC = CmC/1000
    # CmAl = CmAl/1000
    # CmAg = CmAg/1000
    # CmAgl = CmAgl/1000
    # pylab.plot(CmA,digiPotValuesMeasured)
    # pylab.plot(CmC,digiPotValuesMeasured)
    # pylab.plot(CmAl,digiPotValuesMeasured)
    # pylab.plot(CmAg,digiPotValuesMeasured)
    # pylab.plot(CmAgl,digiPotValuesMeasured)

    digiPotValuesMeasured = numpy.array([0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,243,256])
    print "digiPotValuesMeasured Reversed = "
    d_reversed = digiPotValuesMeasured[::-1]
    print d_reversed
    CmAg = numpy.array([914,912,911,909,907,905,904,898,890,875,857,831,806,779,746,711,672,627,576,517,448,370,269,153,5,1,0])
    print "CmAg Reversed = "
    c_reversed = CmAg[::-1]
    print c_reversed
    print "len(CmAg) = " + str(len(CmAg))

    print "Lookup Table: x = Current in mA, y = digiPotValue"
    for i in range(len(c_reversed)):
        print "{" + str(c_reversed[i]) + ", " + str(d_reversed[i]) + "},"
    CmAg = CmAg/1000


    pylab.plot(CmAg,digiPotValuesMeasured)

    pylab.xlim(0,1)
    # pylab.ylim(0,1)
    # pylab.ylim(175,249)
    pylab.grid()
    pylab.show()

def dac_plot():
    curr_a = numpy.array([26,80,169,245,479,662,790,859])
    dac_a = numpy.array([3136,3038,2850,2682,2178,1809,1527,1343])
    pylab.plot(curr_a,dac_a)
    pylab.xlim(0,1000)
    pylab.grid()

    (a,b) = numpy.polyfit(curr_a,dac_a,1)
    dac_a_fit = curr_a*a + b
    pylab.plot(curr_a,dac_a_fit)

    dac_0 = int(round(b))
    dac_1000 = int(round(1000*a + b))
    print "DAC A setting for 0mA = " + str(dac_0)
    print "DAC A setting for 1000mA = " + str(dac_1000)

    curr_b = numpy.array([13,130,279,542,743,822])
    dac_b = numpy.array([3169,2940,2624,2080,1646,1457])
    pylab.plot(curr_b,dac_b)

    (a,b) = numpy.polyfit(curr_b,dac_b,1)
    dac_b_fit = curr_b*a + b
    pylab.plot(curr_b,dac_b_fit)

    dac_0 = int(round(b))
    dac_1000 = int(round(1000*a + b))
    print "DAC B setting for 0mA = " + str(dac_0)
    print "DAC B setting for 1000mA = " + str(dac_1000)

    pylab.show()

if __name__ == "__main__":
    # digipot_plot()
    dac_plot()
