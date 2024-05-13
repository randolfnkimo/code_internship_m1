function [l1] = loss1(ref,estimate)
l1 = abs(ref-estimate)/ref;
end