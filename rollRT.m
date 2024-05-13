function [Rroll,ty] = rollRT(thetha_0, thetha_1,armLenght)
    if nargin < 1 || isempty(thetha_0)
        thetha_0=0;
    end
    mov = thetha_1 - thetha_0;
    Rroll = [cos(mov) 0 -sin(mov); 0 1 0; sin(mov) 0  cos(mov)]';
    ty = armLenght*mov;
end