% MATLAB Script to visualize an airplane with quantum dot coating

% Clear workspace and command window
clear;
clc;

% Create figure window
figure;
hold on;
axis equal;
grid on;

% Set axis labels
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');

% Define color for quantum dot effect using colormap
quantumColors = jet(64); % Using 'jet' colormap to simulate the quantum dot effect

% Create the airplane body (fuselage) using a cylinder
% Parameters for the fuselage
fuselageLength = 10; % Length of the fuselage
fuselageRadius = 1;  % Radius of the fuselage

% Create fuselage
[x, y, z] = cylinder(fuselageRadius, 30);
z = z * fuselageLength; % Scale z to match fuselage length

% Plot fuselage with quantum dot effect
surf(x, y, z, 'FaceColor', 'interp', 'EdgeColor', 'none', 'CDataMapping', 'scaled');
colormap(quantumColors); % Apply the colormap to create a quantum dot-like effect

% Create the nose cone using a cone
noseLength = 2; % Length of the nose cone
[x_nose, y_nose, z_nose] = cylinder([0 fuselageRadius], 30);
z_nose = z_nose * noseLength - noseLength; % Position the nose at the front

% Plot nose cone with quantum dot effect
surf(x_nose, y_nose, z_nose, 'FaceColor', 'interp', 'EdgeColor', 'none', 'CDataMapping', 'scaled');

% Create the tail cone using a cone
tailLength = 3; % Length of the tail cone
[x_tail, y_tail, z_tail] = cylinder([fuselageRadius 0], 30);
z_tail = z_tail * tailLength + fuselageLength; % Position the tail at the back

% Plot tail cone with quantum dot effect
surf(x_tail, y_tail, z_tail, 'FaceColor', 'interp', 'EdgeColor', 'none', 'CDataMapping', 'scaled');

% Create the wings using two rectangular patches
wingWidth = 10;
wingThickness = 0.1;
wingZ = 3; % Z-position of the wing

% Define wing coordinates
wingX = [-wingWidth/2 wingWidth/2 wingWidth/2 -wingWidth/2];
wingY = [0 0 0 0];
wingZ = [wingZ wingZ wingZ+wingThickness wingZ+wingThickness];

% Plot the left wing with quantum dot effect
fill3(wingX, wingY + fuselageRadius, wingZ, 'k', 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceVertexCData', quantumColors);
% Plot the right wing with quantum dot effect
fill3(wingX, -wingY - fuselageRadius, wingZ, 'k', 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceVertexCData', quantumColors);

% Create the vertical stabilizer (tail fin)
finWidth = 1.5;
finHeight = 2;

% Define fin coordinates
finX = [0 0 0 0];
finY = [-finWidth/2 finWidth/2 finWidth/2 -finWidth/2];
finZ = [fuselageLength fuselageLength fuselageLength+finHeight fuselageLength+finHeight];

% Plot the fin with quantum dot effect
fill3(finX, finY, finZ, 'k', 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceVertexCData', quantumColors);

% Set up viewing options
view(3); % 3D view
axis equal; % Equal axis proportions
camlight; % Add a light for better visualization
lighting gouraud; % Smooth lighting
material shiny; % Shiny material for the model

% Interactive viewing
rotate3d on; % Enable 3D rotation with mouse

% Apply the quantum dot effect using lighting and material properties
shading interp; % Smooth shading
set(gca, 'Color', [0.1 0.1 0.1]); % Set background color to dark to enhance visualization
