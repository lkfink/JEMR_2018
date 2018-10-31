# Pylink Wrapper
Wrapper for using pylink in psychopy

## Installation
First, download the `pylinkwrapper` folder and place it somewhere that's in your python path. You can set a path in psychopy for additional module imports under the options.

Then, include the following `import` command at the top of your experiment script: 
```python
import pylinkwrapper
```

Finally, initiate the connection to the EyeLink providing your window object and EDF filename.
```python
win = visual.window(monitor = 'nickMon', fullScr = True, allowGUI = False, color = -1)
tracker = pylinkwrapper.connect(win, '1_nd')
```

## Functions
Here's a list of the functions currently in the wrapper. See each functions `help()` for explanation of parameters.
* `.calibrate()` : Runs the camera set-up procedure using the custom calibration defined in `psychocal.py`. The function automatically sets the background color to match that defined in your window object.
* `.setStatus()` : Defines the status message that appears on the eye-tracker software.
* `.setTrialID()` : Indicates the start of an experimental trial in the EDF.
* `.recordON()` : Starts recording to the EDF file only.
* `.recordOFF()` : Stops recording to the EDF file.
* `.drawIA()` : Defines a square interest area in the EDF and draws a corresponding colored box on the eye-tracker display.
* `.sendVAR()` : Sends key-value pairs to the EDF file as variables that can be included in dataviewer reports.
* `.setTrialResult()` : Indiciates the end of an experimental trial in the EDF.
* `.endExperiment()` : Closes the EDF file and transfers it to the provided path on the display computer.
* `.fixCheck()` : Pauses experiment until fixation at the center of the screen has been held for a given amount of time.
* `.sendMessage()` : Sends a message to the EDF file
* `.sendCommand()` : Sends a command to the EyeLink

## Example
An very simple experiment that shows how to use the above functions is provided in `eyetest.py`.
