# Dist space
# N. DiQuattro - Spring 15

# Import modules
from psychopy import core, data, event, gui, sound
import numpy as np
from scipy.stats import truncnorm
import os, logfiler, pylinkwrapper

## Experiment Set-up
expinfo = {'Subject ID' : '', 'Group' : ['Near', 'Far'],
           'Target Color' : [0, 90, 180, 270]}

if not gui.DlgFromDict(expinfo, title = 'Subject Info').OK:
    core.quit()

from psychopy import visual  # Because of OSX Bug
    
# Window set-up
win = visual.Window([1920, 1200], monitor = 'nickMon', units = 'deg',
                    fullscr = True, allowGUI = False, color = 0)
                    
# Eye-tracker setup
tracker = pylinkwrapper.connect(win, expinfo['Subject ID'])
tracker.tracker.setPupilSizeDiameter('YES')
                    
## Shared Stimuli
fix = visual.Circle(win, radius = .125, pos = (0, 0), fillColor = -1,
                    lineColor = -1, autoDraw = True)

# Circles
target = visual.Circle(win, radius = 1.5, fillColor = [1, -1, -1],
                       fillColorSpace = 'rgb255', lineColorSpace = 'rgb255')
                       
distractor = visual.Circle(win, radius = 1.5, fillColor = [-1, 1, -1],        
                           fillColorSpace = 'rgb255', lineColorSpace = 'rgb255')

# Discrimination Cross
def crosser(size, bardist):
    ''' Makes vertices for a discrimination cross
    
        Parameters
            size = length of vertical/horizontal bar (degrees visual angle)
            bardist = proportion of vertical bar to place horiztonal (0 = 
                      middle; 1 = top)
    '''
    
    # covert size to half
    size = size / 2.0
    bardist = size * bardist
    
    # Make vertices
    verts = []
    verts.append((0.0, -size))  # Vertical Bar
    verts.append((0.0, size))
    
    verts.append((0.0, bardist))  # Where horizontal bar is place
    
    verts.append((-size, bardist))  # Horiztonal bar
    verts.append((size, bardist))
    
    return verts
    
tcross = visual.ShapeStim(win, vertices = crosser(.25, .4), size = 3,
                          closeShape = False, lineColor = -1)
dcross = visual.ShapeStim(win, vertices = crosser(.25, .4), size = 3,
                          closeShape = False, lineColor = -1)

# Feedback Sounds                          
corsound = sound.Sound(800, secs = .1)
errsound = sound.Sound(400, secs = .1)

# Set-up Colors
allcols = np.loadtxt(os.path.join('stims', '1deg_cols.txt'), delimiter = ',',
                     skiprows = 1) * 255
allcols = allcols.tolist()

# Define target color
target.setFillColor(allcols[int(expinfo['Target Color'])])
target.setLineColor(allcols[int(expinfo['Target Color'])])

# define target locations
radius = 4
tpos = np.linspace(0, 300, 6)
tloc = [[round(radius * np.cos(t * (np.pi / 180)), 2),
         round(radius * np.sin(t * (np.pi / 180)), 2)] for t in tpos]

# ISI array
isi = np.around(np.linspace(800, 1500, 6) / 16.7)

## Experiment Structure
def makeTrialList():
    
    # Distribution function
    def dspacer(group):
        # Make Distribution
        lower, upper = 0, 60
        mu, sigma = 0, 25
        X = truncnorm((lower - mu) / sigma, (upper - mu) / sigma, loc=mu,
                    scale=sigma)
                    
        # Generate sample
        ssize = 100000.0
        samp = X.rvs(ssize)
        
        # Calculate trials
        n = np.histogram(samp, bins = 13)
        tnums = np.round((n[0] / ssize) * 1000)
        dvals = np.linspace(0, 60, 13)
        
        # Assign trials to values
        if group == 'Near':
            stimarray = np.c_[dvals, tnums]
        elif group == 'Far':
            stimarray = np.c_[dvals, np.sort(tnums)]
            
        # Make trial list
        tvals = []
        for val, tnum in stimarray:
            tvals = np.append(tvals, np.repeat(val, tnum))
            
        return tvals
    
    # Make trials
    trialList = []
    for dcol in dspacer(expinfo['Group']):
        trialList += [{
                        'sub'    : expinfo['Subject ID'],
                        'group'  : expinfo['Group'],
                        'tcol'   : expinfo['Target Color'],
                        'dcol'   : dcol,
                        'tdcol'  : '',
                        'tloc'   : np.random.choice(range(6)),
                        'dori'   : np.random.choice([90, 270]),
                        'isi'    : np.random.choice(isi),
                        'resp'   : '',
                        'cor'    : '',
                        'rt'     : '',
                        'time'   : ''
                     }]
                                             
    # Add target cross orientation
    torisa = np.zeros(len(trialList))
    torisa[::2].fill(180)
    np.random.shuffle(torisa)
    for i, trial in enumerate(trialList):
        trial['tori'] = torisa[i]        
        
    # Randomize order
    np.random.shuffle(trialList)

    # Add trial number
    for i, trial in enumerate(trialList):
        trial['tnum'] = i + 1
        
    return(trialList)
    
## Main Task
def runTask(prac = False):
    # Start logfile
    if prac:
        log = logfiler.logger(expinfo['Subject ID'], 'pr_distspace')
    else:
        log = logfiler.logger(expinfo['Subject ID'], 'distspace')
    
    # Initiate trial list
    trials = makeTrialList()
    if prac:
        trials = trials[:15]
    
    # Iterate and present
    for trial in trials:
        # Define locations
        target.setPos(tloc[trial['tloc']])
        distractor.setPos([x * -1 for x in tloc[trial['tloc']]])
        
        tcross.setPos(tloc[trial['tloc']])
        dcross.setPos([x * -1 for x in tloc[trial['tloc']]])
        
        # Set orientations
        tcross.setOri(trial['tori'])
        dcross.setOri(trial['dori'])
        
        # Define distractor features
        truedcol = int(trial['tcol']) + trial['dcol']
            
        trial['tdcol'] = truedcol  # Save actual index used
        distractor.setFillColor(allcols[int(truedcol)])
        distractor.setLineColor(allcols[int(truedcol)])
        
        # Check for fixation
        if not prac:
            tracker.fixCheck(4, .1, 'z')
            
            # Eye-tracker pre-stim
            perdone = round(trial['tnum'] / float(len(trials)), 3) * 100
            statmsg = 'Experiment {}%% complete. Current Trial {}'.format(perdone, trial['tnum'])
            tracker.setStatus(statmsg)
            tracker.setTrialID()
            tracker.drawIA(0, 0, 2, 1, 1, 'fixation')  # Draw IA
            tracker.recordON()  # Start Recording
        
        # Display Stimuli
        event.clearEvents()
        trial['time'] = round(exptime.getTime(), 2)
        for frames in range(9):
            # Draw stimuli
            target.draw()
            distractor.draw()
            tcross.draw()
            dcross.draw()
            
            if frames == 0:
                stim_on = win.flip()  # on first flip save time of flip
            else:
                win.flip()
        stim_off = win.flip()

        # Pause for response
        keyps = event.waitKeys(keyList = ['j', 'n', 'escape'],
                               timeStamped = True)
                               
        # Save actual display time
        trial['distime'] = round((stim_off - stim_on) * 1000, 2)
                               
        # Stop Recording
        if not prac:
            tracker.recordOFF()
        
        # Save trial response info
        trial['resp'] = keyps[0][0]
        trial['rt']   = round((keyps[0][1] - stim_on) * 1000, 2)
    
        # Calculate accuracy
        if keyps[0][0] == 'j' and trial['tori'] == 0:
            trial['cor'] = 1
            corsound.play()
        elif keyps[0][0] == 'n' and trial['tori'] == 180:
            trial['cor'] = 1
            corsound.play()
        else:
            trial['cor'] = 0
            errsound.play()
            
        # Eye-tracker post-stim
        if not prac:
            for key, value in trial.iteritems():
                tracker.sendVar(key, value)
            tracker.setTrialResult()
        
        # Quit?
        if keyps[0][0] == 'escape':
           log.close()
           tracker.endExperiment('C:\\edfs\\Nick\\distspace\\')
           core.quit()
            
        # Display ISI time
        for frames in range(int(trial['isi'])):
            if frames == 0:
                isi_flip = win.flip()
            else:
                win.flip()
                
        # Save actual ISI time
        trial['isitime'] = round((core.getTime() - isi_flip) * 1000)
        
        # Save trial results
        log.write(trial)
    
    # Practice stuff
    if prac:
        # Calculate accuracy
        resps = [trial['cor'] for trial in trials]
        acc = np.mean(resps) * 100

        # Display to subject
        ptxt = visual.TextStim(win, 'Accuracy: %.2f%%' % acc, pos = (0, 2))
        ptxt.draw()
        win.flip()

        # Restart practice if needed, else continue with experiment
        keyps = event.waitKeys()
        if keyps[0] == 'r':
            log.close()
            runTask(prac = True)
            
    # Do we need a break?
    if trial['tnum'] % 333 == 0 and trial['tnum'] != 999:
        visual.TextStim(win, 'Take a Break! Press J to continue',
                        pos = (0, 3)).draw()
        win.flip()
        event.waitKeys()
        win.flip()
        core.wait(2)
            
    # Clean up
    log.close()
    
## Instructions
def instruct():
    # Make text
    intxt = visual.TextStim(win, 'test', pos = (0, 5))
    tasktxt = ('Find the colored circle below and report the orientation'
               ' of the cross within by pressing J for upright and N for '
               'inverted')
    intxt.setText(tasktxt)
    intxt.draw()
    
    intxt.setText('High tone means you responded correctly, low tone means'
                  ' incorrect')
    intxt.setPos([0, -3])
    intxt.draw()
    
    target.setFillColor(allcols[int(expinfo['Target Color'])])
    target.setLineColor(allcols[int(expinfo['Target Color'])])
    target.setPos([-3, 0])
    tcross.setPos([-3, 0])
    target.draw()
    tcross.draw()
    
    target.setPos([3, 0])
    tcross.setPos([3, 0])
    tcross.setOri(180)
    target.draw()
    tcross.draw()
    
    win.flip()
    event.waitKeys()
    win.flip()
    core.wait(1)
    
## JND Task
def jnd(sdist):
    ''' sdist -- stimulus distance in degrees visual angle '''
    
    def instructions():
        tasktext = ('Identify which side the target color is on. Use arrows for'
                    ' left/right.')
        intxt = visual.TextStim(win, tasktext, pos = (0, 2))
        intxt.draw()
        
        target.setPos((0, -2))
        target.draw()
        
        win.flip()
        event.waitKeys()
        win.flip()
        core.wait(3)
        
    def task(sdist):
        # Open logfile
        log = logfiler.logger(expinfo['Subject ID'], 'jnd_distspace')
        
        # Set-up staircase
        staircase = data.StairHandler(startVal = 10, stepType = 'lin',        
                                      stepSizes=[5,5,5,5,2,2,1,1], minVal=0,
                                      maxVal=60, nUp=1, nDown=3, nTrials=75)
                                      
        # Iterate through steps
        for step in staircase:
            # Set location
            tside = np.random.choice([sdist*-1, sdist])
            target.setPos([tside, 0.0])
            distractor.setPos([tside*-1, 0.0])
            
            # Set distractor color
            print(step)
            dcol = int(expinfo['Target Color']) + step
            distractor.setFillColor(allcols[dcol])
            distractor.setLineColor(allcols[dcol])
            
            # Draw and show
            target.draw()
            distractor.draw()
            win.flip()
            core.wait(.15)
            win.flip()
            
            # Response handling
            resp = event.waitKeys(keyList = ['left', 'right', 'escape'])
            cor = None
            if (resp[0] == 'left' and tside == (sdist*-1)) \
            or (resp[0] == 'right' and tside == sdist):
                cor = 1
                corsound.play()
            else:
                cor = 0
                errsound.play()
            
            # Do we quit?
            if resp[0] == 'escape':
                log.close()
                tracker.endExperiment('C:\\edfs\\Nick\\distspace\\')
                core.quit()

            # Adjust next trial, save results
            staircase.addResponse(cor)
            trial = {'sub'    : expinfo['Subject ID'],
                     'group'  : expinfo['Group'],
                     'tcol'   : expinfo['Target Color'],
                     'dcol'   : dcol,
                     'ddist'  : step,
                     'tside'  : tside,
                     'resp'   : resp[0],
                     'cor'    : cor
                    }
            log.write(trial)
            
            # ISI
            core.wait(1)
            
        # Clean up
        log.close()
        staircase.saveAsPickle('{}_jnd'.format(expinfo['Subject ID']))
    
    # Execute task
    instructions()
    task(sdist)
    
## Color categorization test
def colorcat(radius):
    
    # Instructions
    def instruct():
        tasktext = ('Identify which color is displayed. K for left color; L'
                    ' for right color.')
        intxt = visual.TextStim(win, tasktext, pos = (0, 2))
        intxt.draw()
        
        tarcol = int(expinfo['Target Color'])
        target.setFillColor(allcols[tarcol])
        target.setLineColor(allcols[tarcol])
        target.setPos((-2, -2))
        target.draw()
        
        target.setFillColor(allcols[tarcol + 60])
        target.setLineColor(allcols[tarcol + 60])
        target.setPos((2, -2))
        target.draw()
        
        win.flip()
        event.waitKeys()
        win.flip()
        core.wait(3)
    
    # Task
    def task(sdist = radius):
        
        # Open logfile
        log = logfiler.logger(expinfo['Subject ID'], 'colcat_distspace')
        
        # Stim colors
        tarcol = int(expinfo['Target Color'])
        scols = range(tarcol, tarcol + 65, 5)  # endpoint not included
        
        # Control array
        carr = []
        for col in scols:
            carr = np.append(carr, np.repeat(col, 10)).astype(int)
        np.random.shuffle(carr)
            
        # Run trials
        for col in carr:
            # Set up stim
            target.setFillColor(allcols[col])
            target.setLineColor(allcols[col])
            
            # Choose side
            tside = np.random.choice([sdist*-1, sdist])
            target.setPos([0.0, tside])
            
            # Display and weight for response
            target.draw()
            win.flip()
            resp = event.waitKeys(keyList = ['k', 'l', 'escape'])
            
            # Parse response
            tresp = None
            if resp[0] == 'k':
                tresp = 1
            elif resp[0] == 'l':
                tresp = 0
            elif resp[0] == 'escape':
                log.close()
                tracker.endExperiment('C:\\edfs\\Nick\\distspace\\')
                core.quit()
            
            # Save and record
            trial = {'sub'    : expinfo['Subject ID'],
                     'group'  : expinfo['Group'],
                     'tcol'   : expinfo['Target Color'],
                     'col'    : col,
                     'dist'   : col - tarcol,
                     'tside'  : tside,
                     'resp'   : resp[0],
                     'tresp'  : tresp
                    }
            log.write(trial)
            
            # ISI
            win.flip()
            core.wait(1)
        
        # Clean up
        log.close()
        
    # Execute
    instruct()
    task()

## Execute Experiment

# Main Task
instruct()
exptime = core.Clock()
runTask(prac = True)
tracker.calibrate()
exptime = core.Clock()  # Reset for real trials
runTask()

# Perception Tests
jnd(radius)
colorcat(radius)

# Get edf
tracker.endExperiment('C:\\edfs\\Nick\\distspace\\')     
   