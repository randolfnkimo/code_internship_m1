function [surfaceArea,volume,velocity,acceleration,Jerk,TP] = assesment(pos3D,accIMU,gyroIMU,armLenght)
% [surfaceArea,volume,velocity,acceleration,Jerk,TP] =
% assesment(pos3D,accIMU,gyroIMU,armLenght) returns scalar workspace surface area,
% volume of hand movements, an array of velocity, acceleration, jerk during
% movement, and finaly a scalar represent the travel path of hand.

[surfaceArea, volume] = plotPos3D(pos3D);

% Velocity is dot product between the angular velocity and arm lenght 

speed = gyroIMU.*armLenght;
velocity = [];
acceleration = [];
for i=1:size(speed,1)
    velocity(i) = norm(speed(i,:));
end

% Acceleration 
for i=1:size(accIMU,1)
    acceleration(i) = norm(accIMU(i,:));
end

% Travel Path
pos3D = pos3D';
TP = 0;
for i=2:size(pos3D,1)
    a = pos3D(i,1) - pos3D(i-1,1);
    b = pos3D(i,2) - pos3D(i-1,2);
    c = pos3D(i,3) - pos3D(i-1,3);
    TP = TP + sqrt(a^2 + b^2 + c^2);
end

Jerk = diff(acceleration);
