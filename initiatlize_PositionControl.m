clc;
clear all;

Motor = Epos4(1,0);
ControlParameter = 1;
MaxPosition = 1.875e5;
NodeID = 1;
DeltaT = 1e-6;
OperationalMode = 3;
PhysicalDim = 2.10667e-3;

if (Motor.IsInErrorState)
    Motor.ExplainErrors;
    Motor.ClearErrorState;
end

Motor.EnableNode;
Motor.SetOperationMode(OperationModes.HommingMode);
Motor.SetHommingMethod(HommingMethods.CurrentPosSpeed);
Motor.DoHomming;
% Motor.WaitUntilHomingDone(10000);
% pause(10)
Motor.DisableNode;
delete(Motor);

sim('PositionControl.slx');