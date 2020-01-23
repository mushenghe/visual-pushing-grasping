1. can launch V-REP in gpu but not in CPU via ssh
throw the error:
```Loading the V-REP library...
Done!
Launching V-REP...

V-REP PRO EDU V3.6.2. (rev. 0)
qt.qpa.xcb: could not connect to display 
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, xcb.

./vrep.sh: line 33:  1795 Aborted                 "$dirname/$appname" "${PARAMETERS[@]}"
```

2. Stuck after the first iteration.