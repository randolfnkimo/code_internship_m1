 function [pos3D] = handPosition(orientation_YRP,armLenght,COP_shoulder)

%pos3d = handPosition(orienation, armLenght, COP_shoulder) returns the 3D
%hand position estimation relative to trunk taken orientation in rad (yaw(z), roll(y) and
%pitch(x) angles size Nx3, arm lenght and Center of Presure (COP) to
%shoulder distance COP_shoulder.

R0 = [1 0 0; 0 0 1; 0 -1 0]';
% Initial hand position on trunk marker withouht rotation
p00 = [-COP_shoulder, 0, armLenght]';
p0 = p00;
pos3D = [];
pos3D(:,1) = p0;

Rpitch = [];
Rroll = [];
for i = 1:size(orientation_YRP, 1) 
    if i==1
        pitch = orientation_YRP(i,3);
        roll  = orientation_YRP(i,2);
        [Rpitch, tx] = pitchRT(0, pitch,armLenght);
        [Rroll, ty] = rollRT(0, roll,armLenght);
        t = [tx, ty, 0]';
    
        p = Rpitch*Rroll*p0 + t;
        %p = Rpitch*Rroll*p0;
        pos3D(:, i+1) = p;
    
    else
    
        pitch_pre = orientation_YRP(i-1,3);
        roll_pre  = orientation_YRP(i-1,2);
        pitch_curr = orientation_YRP(i,3);
        roll_curr  = orientation_YRP(i,2);
        [Rpitch, tx] = pitchRT(pitch_pre, pitch_curr,armLenght);
        [Rroll, ty] = rollRT(roll_pre , roll_curr,armLenght);
        t = [tx, ty, 0]';
        
        p = Rpitch*Rroll*pos3D(:, i) + t;
        pos3D(:, i+1) = p;
    end

end
end