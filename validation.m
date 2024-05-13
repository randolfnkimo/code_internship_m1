
paths = {'circle_slow','circle_fast','circle_shape','square_slow', ...
          'square_fast','square_shape','random','static'};
Validation = struct();
armLength = 0.224;
cop2shoulder = 0.0448;
Fs = 100; % sample rate for filter
k = 1;
for i=1:size(paths,2)

repRef = char(paths(i));

% Chargement du dataset de réference
[Accelerometer,Gyroscope,Magnetometer,Orientation,yrp] = readData(repRef);

% Implementation de AHRS for estimation of euleur angles
fuse = ahrsfilter('SampleRate', Fs);

% Optimization of Kalman Filter using Ground Truth data
filterParams = tuneKF(Accelerometer,Gyroscope,Magnetometer,Orientation,fuse);

%% On compare l'erreur du dataset de reference par rapport aux autres datasets

for j=1:size(paths,2)
    
    if (j~=i)
        repCur = char(paths(j));

        [Accelerometer,Gyroscope,Magnetometer,Orientation,yrp] = readData(repCur);
        
        % Paramètres de réference sur ce dataset et orientation de ref 
        newfuse = ahrsfilter('SampleRate', Fs);
        filterParamsRef = tuneKF(Accelerometer,Gyroscope,Magnetometer,Orientation,newfuse);
        [qEstRef,GyroscopeEstRef] = newfuse(Accelerometer,Gyroscope,Magnetometer);
        
        % Estimation de l'orientation avec paramètres  obtenu sur le dataset de
        % 'reférence'
        [qEst,GyroscopeEst] = fuse(Accelerometer,Gyroscope,Magnetometer);
        
        % rms quaternion distance
        rms = loss2qad(qEst, Orientation);
        rmsRef = loss2qad(qEstRef, Orientation);
        
        %Evaluation de l'erreur (l'amélioration) des paramètres du filtre (dataset ref) par rapport à l'erreur minimale
        l1rms = loss1(rmsRef,rms);
        % Impact de l'optimisation des paramètres du filtre sur la robustesse des features
        eulerEst = euler(qEst, 'ZYX', 'frame');
        eulerGT  = euler(qEstRef, 'ZYX','frame');
        
        
        posGT = handPosition(eulerGT, armLength, cop2shoulder);
        posEst = handPosition(eulerEst, armLength, cop2shoulder);
        
        
        [areaGT,volumeGT,velocityGT,accelGT,jerkGT,TravelPGT] = assesment(posGT, Accelerometer,GyroscopeEstRef,armLength);
        [areaEst,volumeEst,velocityEst,accelEst,jerkEst,TravelPEst] = assesment(posEst, Accelerometer,GyroscopeEst,armLength);
        l1area = loss1(areaGT,areaEst);
        l1volume = loss1(volumeGT,volumeEst);
        l1travelP = loss1(TravelPGT,TravelPEst);
        
        pathRefError = strcat(repCur,'_error');
        ref2others = strcat(repRef,'2',repCur);
        
        d = struct();
        d.Ref = ref2others;
        d.Error = [l1rms, l1area, l1volume, l1travelP];
        Validation.Ref2others{k} = d;
        k=k+1;

        elseif (j==i) 
         continue
    end
  
end

end