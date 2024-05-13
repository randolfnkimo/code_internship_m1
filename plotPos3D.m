function [surfaceArea, volume] = plotPos3D(pos3D)

%[surfaceArea, volume] - plotPos3D, returns two scalars which represent the
%arm area workspace and volume and plot then taken fron hand 3d position
%size Nx3.


shp = alphaShape(pos3D');
surfaceArea = shp.surfaceArea;
volume = shp.volume;

%Arm worspace
% 
% figure(3)
% plot(shp)
% xlabel('Axe x(m)');
% ylabel('Axe y(m)');
% zlabel('Axe z(m)');
% title('Hand workspace');

% 3D position
% x = pos3D(1,:)';
% y = pos3D(2,:)';
% z = pos3D(3,:)';
% figure(4)
% grid on;
% xlabel('Axe x(m)');
% ylabel('Axe y(m)');
% zlabel('Axe z(m)');
% cmap = jet(length(x)); % Colormap personnalisée
% line_width = linspace(1, 5, length(x)); % Largeur de ligne variable
% hold on;
% 
% for i = 1:length(x)-1
%     plot3(x(i:i+1), y(i:i+1), z(i:i+1), 'Color', cmap(i,:), 'LineWidth', line_width(i));
% end
% 
% % Tracé du dernier et du premier point
% scatter3(x(end), y(end), z(end), 100, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', cmap(end,:));
% scatter3(x(1), y(1), z(1), 100, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', cmap(1,:));
% title('Hand 3D position with orientation ground truth');
% end