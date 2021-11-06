%{
This code is used to control the actuator in velocity, run the code till 
the breakpoint, wait until homing is done and continue to run the Simulink
model.

Ctrl+c to abort the simulation and upon completion execute 
load('position.mat') to obtain the carriage's mid section position in mm, 
at each time step of the simulation.
%}

clc;
clear all;

%Creating the Motor object to perform the Homing
Motor = Epos4(1,0);

%Simulation Parameters
MaxEncoderPosition = 1.881e5;     %Maximum encoder position (inc)
EffectiveActuatorLength = 482;    %Lt - E2 --> (790 - 308) (mm) 
ControlParameter = -1;            %Controls the motion accordance
MaxVelocity = 6000;               %Maximum velocity [rpm]
PhysicalDimension = ... 
    (EffectiveActuatorLength/2)/MaxEncoderPosition; 
                                  %Relates encoder and actual position (mm)

%S-function parameters
NodeID = 1;                 %ID of the motor, 1 by default
DeltaT = 1e-9;              %Not so relevant sample time
OperationalMode = 2;        %1 --> Current control
                            %2 --> Velocity control
                            %3 --> Position control

%Checking if everything is all-right prior to homing
if (Motor.IsInErrorState)
    Motor.ExplainErrors;
    Motor.ClearErrorState;
end

%Home Procedure
Motor.EnableNode;
Motor.SetOperationMode(OperationModes.HommingMode);
Motor.SetHommingMethod(HommingMethods.CurrentPosSpeed);
Motor.DoHomming;
% res=WaitForHomingAttained(Motor.Handle, Motor.NodeID,10000);
% pause(10)
Motor.DisableNode;
delete(Motor);

%Running the simulink model
sim('VelocityControl.slx');