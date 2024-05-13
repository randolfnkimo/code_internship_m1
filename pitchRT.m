function [Rpitch,tx] = pitchRT(thetha_0, thetha_1,armLenght)
    if nargin < 1 || isempty(thetha_0)
        thetha_0=0;
    end
    mov = thetha_1 - thetha_0;
    Rpitch = [1 0 0; 0 cos(mov) sin(mov); 0 -sin(mov) cos(mov)]';
    tx = armLenght*mov;
end