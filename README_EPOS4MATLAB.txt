The folder "EPOS4MATLAB" contains all the relevant files to 
control the maxon motor with Matlab and Simulink.

When you access the folder for the very first time, run in 
the command window: "Clean" and "Make". After this everything
is ready for operation.

It is important to also mention that to have everything 
working as it should, you should download the complete folder
and add it to the path in Matlab.

The main files are:

 - 'initialize_VelocityControl.m': sets up the relevant
   parameters, performs the homing procedure and calls the 
   simulink model to start the simulation.

 - 'VelocityControl.slx': this simulink model reads the 
   joystick deflection, translates it to rpm and comunicates
   with the motor.

 - 'sfun_maxon28_7.c' : this is the s-function that enables
   the Simulink model to comunicate with the motor, it can be
   modified inside the Simulink model, but recall that after
   each modification, you should call to the relevant make 
   file in the command window (i.e. 'Make_Sfun.m').

 - 'Make_Sfun.m' : this is the make function that compiles
   every change in the s-function.

[The control in position requires further improvements, that
is why it is not presented here]

Generally, with the 'initialize_VelocityControl.m' file and the 
'VelocityControl.slx' model, it is enough to control the motor, 
all that it is needed is that the Motor and Joystick are properly
connected via USB.

In principle, the only thing that could give some trouble is the 
different USB port that they could be connected to:

 - If there is trouble with the joystick, access the 'Pilot 
   Joystick All' block in the model, and adjust the variable
   Joystick ID.

 - Actually, I did not encounter problems when connecting the 
   motor to different ports, but if there is some trouble it 
   could be due to:
	
	- If EPOS Studio is open in your computer, it may be
	  already communicating with the motor, thus, close
	  the program and run the Matlab file again.

	- If there is trouble with the USB ID, then I guess
	  it should be a matter of changing the USB ID when 
	  creating the structure in the file.