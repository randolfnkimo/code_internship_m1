function [filterParams] = tuneKF(Accelerometer,Gyroscope,Magnetometer,Orientation,fuse)
%[filterParams] = optimize the parameters of the kalman filter according to
%the ground truth which is the Orientation vector (quaternion) and returns
%the optimised parameters in to struct filterParams
%tuneKF(Accelerometer,Gyroscope,Magnetometer,Orientation,fuse)
sensorData = table(Accelerometer,Gyroscope,Magnetometer);
groundTruth = table(Orientation);
config = tunerconfig('ahrsfilter', 'Display','none');
tune(fuse,sensorData,groundTruth,config);
paramsValue = [fuse.AccelerometerNoise,fuse.GyroscopeNoise,fuse.MagnetometerNoise,fuse.GyroscopeDriftNoise, ...
    fuse.LinearAccelerationNoise,fuse.MagneticDisturbanceNoise,fuse.LinearAccelerationDecayFactor, ...
    fuse.MagneticDisturbanceDecayFactor];
paramsName = ['AccelerometerNoise', 'GyroscopeNoise' ,'MagnetometerNoise','GyroscopeDriftNoise', ...
    'LinearAccelerationNoise','MagneticDisturbanceNoise','LinearAccelerationDecayFactor', ...
    'MagneticDisturbanceDecayFactor'];
filterParams = struct();
filterParams.Value = paramsValue;
filterParams.Name = paramsName;
end