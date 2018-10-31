# get updated version from Joy's computer!!!!!! 

# Import modules
from psychopy import core, data, event, gui, visual
import numpy as np
import socket
import OSC
import pylinkwrapper
#from psychopy import logging
#logging.console.setLevel(logging.WARNING)
#psychopy.logging.setDefaultClock(core.Clock)
#overwrite (mode='w') a detailed log of the last run in this dir
#lastLog=logging.LogFile("lastRun.log", level=logging.INFO, mode='w')
#also append warnings to a central log file
#centralLog=logging.LogFile("C:\\Users\\laurenfink\\Documents\\3_Quarter\\Experiment\\Data\\log", level=logging.WARNING, mode='a')

# Window set-up
win = visual.Window(monitor = 'laurenMon', units = 'deg', fullscr = True, allowGUI = False, color = 0)

# Eye-tracker setup
tracker = pylinkwrapper.connect(win, '1_test') 
tracker.tracker.setPupilSizeDiameter('YES')
# Calibrate eye-tracker
tracker.calibrate()


# Configure socket
MAXMSP_IP = "127.0.0.1" #address of this computer
MAXMSP_PORT = 44102 #arbitrary port number
BUF_SIZE = 1024
STOP_LISTENING_TO_MAX = -1 # define a unique code to break connection with MaxMSP

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # UDP
sock.bind((MAXMSP_IP, MAXMSP_PORT))

# set definitions for codes to be sent from MAX to python to eye tracker

# log deviant onset
def dev_low_263():
    tracker.sendMessage('dev_low_263')
def dev_hi_820():
    tracker.sendMessage('dev_hi_820')
def dev_low_1250():
    tracker.sendMessage('dev_low_1250')
def dev_hi_2086():
    tracker.sendMessage('dev_hi_2086')
def dev_hi_542():
    tracker.sendMessage('dev_hi_542')
def dev_low_973():
    tracker.sendMessage('dev_low_973')
def dev_hi_1807():
    tracker.sendMessage('dev_hi_1807')
def dev_low_123():
    tracker.sendMessage('dev_low_123')
def dev_low_541():
    tracker.sendMessage('dev_low_541')
def dev_hi_1111():
    tracker.sendMessage('dev_hi_1111')
def dev_hi_1947():
    tracker.sendMessage('dev_hi_1947')
def dev_low_124():
    tracker.sendMessage('dev_low_124')
def dev_low_961():
    tracker.sendMessage('dev_low_961')
def dev_hi_1795():
    tracker.sendMessage('dev_hi_1795')
def dev_hi_0():
    tracker.sendMessage('dev_hi_0')
def dev_low_404():
    tracker.sendMessage('dev_low_404')
def dev_hi_1099():
    tracker.sendMessage('dev_hi_1099')
def dev_low_1530():
    tracker.sendMessage('dev_low_1530')
    

# log participant responses
def miss(): 
    tracker.sendMessage('miss')
    print "miss"

def hit(): 
    tracker.sendMessage('hit')
    print "hit"


# log stimuli
def prA_4_3i_1v_107bpm():
    tracker.sendMessage('prA_4_3i_1v_107bpm')
    tracker.setTrialID('prA_4_3i_1v_107bpm') 
    print "prA_4_3i_1v_107bpm"

def prA_74_3i_1v_107bpm():
    tracker.sendMessage('prA_74_3i_1v_107bpm')
    tracker.setTrialID('prA_74_3i_1v_107bpm') 
    print "prA_74_3i_1v_107bpm"

def prC_54_3i_1v_107bpm():
    tracker.sendMessage('prC_54_3i_1v_107bpm')
    tracker.setTrialID('prC_54_3i_1v_107bpm') 
    print "prC_54_3i_1v_107bpm"

def prC_74_3i_1v_107bpm():
    tracker.sendMessage('prC_74_3i_1v_107bpm')
    tracker.setTrialID('prC_74_3i_1v_107bpm') 
    print "prC_74_3i_1v_107bpm"

def prC_124_3i_1v_107bpm():
    tracker.sendMessage('prC_124_3i_1v_107bpm')
    tracker.setTrialID('prC_124_3i_1v_107bpm') 
    print "prC_124_3i_1v_107bpm"

def loop():
    tracker.sendMessage('loop')
    print "loop"

# operate the tracker
def tracker_start():
    tracker.recordON()
    print "start the eyetracker" 

def tracker_stop():
    tracker.recordOFF()
    print "stop the eyetracker"

def experiment_end():
    tracker.endExperiment('C:\\edfs\\Lauren\\') #specify path 
    return STOP_LISTENING_TO_MAX

# map the integer values received from Max/MSP into method calls
dispatch = {
    # deviant probe times mapped onto condition

    # prA_4_3i_1v_107bpm.wav, 263. 820. 1250. 2086.;
    # prA_74_3i_1v_107bpm.wav, 263. 542. 973. 1807.;
    # prC_54_3i_1v_107bpm.wav, 123. 541. 1111. 1947.;
    # prC_74_3i_1v_107bpm.wav, 124. 542. 961. 1795.;
    # prC_124_3i_1v_107bpm.wav, 0. 404. 1099. 1530.;

    # prA_4_3i_1v_107bpm.wav, low_reson hi_reson low_reson hi_reson;
    # prA_74_3i_1v_107bpm.wav, low_reson hi_reson low_reson hi_reson;
    # prC_54_3i_1v_107bpm.wav, low_reson low_reson hi_reson hi_reson;
    # prC_74_3i_1v_107bpm.wav, low_reson hi_reson low_reson hi_reson;
    # prC_124_3i_1v_107bpm.wav, hi_reson low_reson hi_reson low_reson;
    263: dev_low_263,
    820: dev_hi_820,
    1250: dev_low_1250,
    2086: dev_hi_2086,
    542: dev_hi_542,
    973: dev_low_973,
    1807: dev_hi_1807,
    123: dev_low_123,
    541: dev_low_541,
    1111: dev_hi_1111,
    1947: dev_hi_1947,
    124: dev_low_124,
    961: dev_low_961,
    1795: dev_hi_1795,
    0: dev_hi_0,
    404: dev_low_404,
    1099: dev_hi_1099,
    1530: dev_low_1530,
    
    # subject response to deviant
    5: miss,
    6: hit,

    # stimulus file names
    11: prA_4_3i_1v_107bpm,
    12: prA_74_3i_1v_107bpm,
    13: prC_54_3i_1v_107bpm,
    14: prC_74_3i_1v_107bpm,
    15: prC_124_3i_1v_107bpm,

    # trial
    33: loop

    # tracker commands mapped onto beginning/end of MAX runs
    77: tracker_start,
    88: tracker_stop,
    99: experiment_end
}

while True:
    data, addr = sock.recvfrom(BUF_SIZE)
    datatype, abbrev, value = OSC.decodeOSC(data)
    if value in dispatch:
        flag = dispatch[value]()
        if flag == STOP_LISTENING_TO_MAX:
            # close the socket and exit the loop
            sock.close()
            break
    else:
        print "unrecognized message: ", value

# now present audio and visual from MAX


    
 
