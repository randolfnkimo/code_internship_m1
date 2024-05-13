function [Accelerometer,Gyroscope,Magnetometer,Orientation,yrp] = readData(repository)

%[Accelerometer,Gyroscope,Magnetometer,Orientation,yrp] =
%readData(repository) return a reading of acceleromter (rad/s^2), gyroscope
%(rad/s), magnetomer (microTesla), Orientation in quaterion and yaw,roll
%and pitch angles (in rad), all these array are Nx3 size, and takes as
%argument a string which is the access path
    cd (repository)
    
    AccData = readtable("Accelerometer.csv");
    GyroData = readtable("Gyroscope.csv");
    MagneData = readtable("Magnetometer.csv");
    OrientationData = readtable("Orientation.csv");
    
    acc_size = size(AccData,1);
    gyro_size = size(GyroData,1);
    magne_size = size(MagneData,1);
    yrp  = [OrientationData.yaw, OrientationData.roll, OrientationData.pitch]; % in rad respectively in z,y, and x axis 
    q_wxyz = [OrientationData.qw, OrientationData.qx, OrientationData.qy, OrientationData.qz]; % True quaternion orientation
    
    [mins, i] = min([acc_size, gyro_size, magne_size]);
    Accelerometer   = [AccData.x, AccData.y, AccData.z];
    Gyroscope  = [GyroData.x, GyroData.y, GyroData.z];
    Magnetometer = [MagneData.x, MagneData.y, MagneData.z];

    if i==1
         Gyroscope  = Gyroscope(1:acc_size, :);
         Magnetometer = Magnetometer(1:acc_size, :);
         q_wxyz = q_wxyz(1:acc_size,:);
    elseif i==2
         Accelerometer = Accelerometer(1:gyro_size,:);
         Magnetometer = Magnetometer(1:gyro_size, :);
         q_wxyz = q_wxyz(1:gyro_size,:);
    else 
        Accelerometer = Accelerometer(1:magne_size,:);
        Gyroscope  = Gyroscope(1:magne_size, :); 
        q_wxyz = q_wxyz(1:magne_size,:);
    end

    Orientation = quaternion(q_wxyz);
    cd ..