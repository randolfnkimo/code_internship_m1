function [rms] = loss2qad(q_gt,q_es)
% cost = lossqad(q1,q2), take two array of quaternion [q_gt, q_es] size(N*1) and compute
% loss2 of quaternion distance
d = rad2deg(dist(q_es,q_gt));
rms = sqrt(mean(d.^2));
end
