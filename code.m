% MATLAB Script to visualize an airplane with a compact hexagonal mask

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

% Define parameters for the airplane
fuselageLength = 10; % Length of the fuselage
fuselageRadius = 1;  % Radius of the fuselage

% Create the fuselage
[x, y, z] = cylinder(fuselageRadius, 100);  % Increased resolution for better texture mapping
z = z * fuselageLength; % Scale z to match fuselage length

% Plot fuselage
fuselageSurf = surf(x, y, z, 'EdgeColor', 'none');
set(fuselageSurf, 'FaceColor', 'texturemap');

% Create the nose cone
noseLength = 2; % Length of the nose cone
[x_nose, y_nose, z_nose] = cylinder([0 fuselageRadius], 100);
z_nose = z_nose * noseLength - noseLength;

% Plot nose cone
noseSurf = surf(x_nose, y_nose, z_nose, 'EdgeColor', 'none');
set(noseSurf, 'FaceColor', 'texturemap');

% Create the tail cone
tailLength = 3; % Length of the tail cone
[x_tail, y_tail, z_tail] = cylinder([fuselageRadius 0], 100);
z_tail = z_tail * tailLength + fuselageLength;

% Plot tail cone
tailSurf = surf(x_tail, y_tail, z_tail, 'EdgeColor', 'none');
set(tailSurf, 'FaceColor', 'texturemap');

% Create the main wings using patches
wingSpan = 12;   % Total span of the wings
wingChord = 2;   % Distance from leading edge to trailing edge of the wing
wingZ = fuselageLength / 2;

% Define wing coordinates (left wing)
wingX = [0, wingChord, wingChord, 0];
wingY = [-wingSpan/2, -wingSpan/2, 0, 0];
wingZ = [wingZ, wingZ, wingZ, wingZ];

% Plot left wing
wingLeft = fill3(wingX, wingY, wingZ, 'k', 'FaceAlpha', 0.5);

% Plot right wing
wingRight = fill3(wingX, -wingY, wingZ, 'k', 'FaceAlpha', 0.5);

% Create the horizontal stabilizers
stabilizerSpan = 4;  % Span of the stabilizers
stabilizerChord = 1; % Chord length of the stabilizers
stabilizerZ = fuselageLength;

% Define stabilizer coordinates
stabX = [0, stabilizerChord, stabilizerChord, 0];
stabY = [-stabilizerSpan/2, -stabilizerSpan/2, 0, 0];
stabZ = [stabilizerZ, stabilizerZ, stabilizerZ, stabilizerZ];

% Plot left horizontal stabilizer
stabLeft = fill3(stabX, stabY, stabZ, 'k', 'FaceAlpha', 0.5);

% Plot right horizontal stabilizer
stabRight = fill3(stabX, -stabY, stabZ, 'k', 'FaceAlpha', 0.5);

% Create the vertical stabilizer
finWidth = 1.5;
finHeight = 2;

% Define fin coordinates
finX = [0 0 0 0];
finY = [-finWidth/2 finWidth/2 finWidth/2 -finWidth/2];
finZ = [fuselageLength fuselageLength fuselageLength+finHeight fuselageLength+finHeight];

% Plot the fin
fin = fill3(finX, finY, finZ, 'k', 'FaceAlpha', 0.5);

% Set up viewing options
view(3); % 3D view
axis equal; % Equal axis proportions
axis vis3d; % Fix aspect ratio for 3D visualization
camlight; % Add a light for better visualization
lighting gouraud; % Smooth lighting
material shiny; % Shiny material for the model

% Interactive viewing
rotate3d on; % Enable 3D rotation with mouse
zoom on; % Enable zooming with mouse

% Apply the compact hexagonal comb texture to the fuselage, nose, and tail
hexSize = 0.1; % Size of hexagons (smaller size for more compact)
[hexTexture] = createCompactHexagonalTexture(hexSize, 512);

% Apply the texture to the aircraft components
set(fuselageSurf, 'CData', hexTexture, 'FaceColor', 'texturemap');
set(noseSurf, 'CData', hexTexture, 'FaceColor', 'texturemap');
set(tailSurf, 'CData', hexTexture, 'FaceColor', 'texturemap');

% Function to generate a compact hexagonal pattern texture
function hexTexture = createCompactHexagonalTexture(hexSize, gridSize)
    % Hexagon vertices for a compact, gapless pattern
    theta = linspace(0, 2*pi, 7);
    hx = hexSize * cos(theta);
    hy = hexSize * sin(theta);
    
    % Create grid
    [X, Y] = meshgrid(linspace(-1, 1, gridSize), linspace(-1, 1, gridSize));
    
    % Calculate hexagon centers
    dx = hexSize * 3/2;  % Distance between hexagon centers horizontally
    dy = hexSize * sqrt(3);  % Distance between hexagon centers vertically
    
    % Create hexagonal pattern (compact, no gaps)
    hexPattern = zeros(size(X));
    for i = 1:size(X, 1)
        for j = 1:size(X, 2)
            % Calculate the hexagon center with offset
            cx = mod(floor(i / dx), 2) * dx/2 + round(X(i,j) / dx) * dx;
            cy = round(Y(i,j) / dy) * dy;
            
            % Check if the point is inside the hexagon
            if inpolygon(X(i,j), Y(i,j), hx + cx, hy + cy)
                hexPattern(i,j) = 1; % Inside hexagon
            end
        end
    end

    % Convert hexPattern to texture format
    hexTexture = repmat(hexPattern, [1, 1, 3]); % RGB texture
end
