import socket
import os
import OSC

MAXMSP_IP = "127.0.0.1"
MAXMSP_PORT = 44102
BUF_SIZE = 1024

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # UDP
sock.bind((MAXMSP_IP, MAXMSP_PORT))


def eye_start():
    print "start the eyetracker here"


def eye_stop():
    print "stop the eyetracker"


def experiment_end():
    sock.close()
    os._exit(0)

# map the integer values received from Max/MSP into method calls
dispatch = {
    1: eye_start,
    2: eye_stop,
    99: experiment_end
}

while True:
    data, addr = sock.recvfrom(BUF_SIZE)
    datatype, abbrev, value = OSC.decodeOSC(data)
    if value in dispatch:
        dispatch[value]()
    else:
        print "unrecognized message: ", value
