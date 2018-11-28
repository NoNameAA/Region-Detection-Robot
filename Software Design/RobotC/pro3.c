task main()
{
    nMotorEncoder[motorA]=0; // first we need to initialize the encoder
	motor[motorA]=20;  // set the speed
	motor[motorB]=20;
	if (SensorValue[S4]<25  ||  SensorV alue[S4]>65) //if the color is not red , black and yellow
	{
        motor[motorA]=0; // stop the robot
		motor[motorB]=0;
	}
	
}
