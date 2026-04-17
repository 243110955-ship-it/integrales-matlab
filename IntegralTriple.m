% ============================================================
%   CALCULADORA DE INTEGRAL TRIPLE (PASO A PASO DETALLADO)
% ============================================================

clear; clc; close all;

% ------------------------------------------------------------
% 1. DECLARACIÓN DE VARIABLES SIMBÓLICAS
% ------------------------------------------------------------
% Estas variables permiten trabajar con integrales exactas
syms x y z;

% ------------------------------------------------------------
% 2. DEFINICIÓN DE LA FUNCIÓN A INTEGRAR
% ------------------------------------------------------------
% f(x,y,z) = y + 2z
f = y + 2*z;

% ------------------------------------------------------------
% 3. DEFINICIÓN DE LOS LÍMITES DE INTEGRACIÓN
% ------------------------------------------------------------
% Orden de integración: dz -> dy -> dx

% Límites de z (dependen de x y y)
z_inf = x;
z_sup = x + y;

% Límites de y (dependen de x)
y_inf = 0;
y_sup = x;

% Límites de x (constantes)
x_inf = 1;
x_sup = 2;

% ------------------------------------------------------------
% 4. PROCEDIMIENTO PASO A PASO
% ------------------------------------------------------------

fprintf('========================================\n');
fprintf('     RESOLUCIÓN DE INTEGRAL TRIPLE\n');
fprintf('========================================\n\n');

fprintf('Función: f(x,y,z) = %s\n\n', char(f));

% ------------------------------------------------------------
% PASO 1: INTEGRACIÓN RESPECTO A z
% ------------------------------------------------------------
fprintf('Paso 1: Integrando respecto a z\n');
fprintf('Límites: [%s, %s]\n\n', char(z_inf), char(z_sup));

I1 = int(f, z, z_inf, z_sup);

fprintf('Resultado después de integrar en z:\n');
disp(I1);
fprintf('\n');

% ------------------------------------------------------------
% PASO 2: INTEGRACIÓN RESPECTO A y
% ------------------------------------------------------------
fprintf('Paso 2: Integrando respecto a y\n');
fprintf('Límites: [%s, %s]\n\n', char(y_inf), char(y_sup));

I2 = int(I1, y, y_inf, y_sup);

fprintf('Resultado después de integrar en y:\n');
disp(I2);
fprintf('\n');

% ------------------------------------------------------------
% PASO 3: INTEGRACIÓN RESPECTO A x
% ------------------------------------------------------------
fprintf('Paso 3: Integrando respecto a x\n');
fprintf('Límites: [%s, %s]\n\n', char(x_inf), char(x_sup));

I3 = int(I2, x, x_inf, x_sup);

% ------------------------------------------------------------
% 5. RESULTADO FINAL
% ------------------------------------------------------------
fprintf('========================================\n');
fprintf('RESULTADO FINAL\n');
fprintf('========================================\n');

fprintf('Resultado exacto:\n');
disp(I3);

fprintf('Resultado decimal:\n');
disp(double(I3));

% ------------------------------------------------------------
% 6. VISUALIZACIÓN DEL SÓLIDO
% ------------------------------------------------------------
fprintf('\nGenerando gráfica del sólido...\n');

figure('Color','w');

% Creamos una malla para x y y
[X, Y] = meshgrid(linspace(x_inf, x_sup, 25), linspace(0, x_sup, 25));

% Evaluamos los límites de z
Z_inf = double(subs(z_inf, {x,y}, {X,Y}));
Z_sup = double(subs(z_sup, {x,y}, {X,Y}));

% Aplicamos condición y <= x (región válida)
mask = Y <= X;
Z_inf(~mask) = NaN;
Z_sup(~mask) = NaN;

% Superficie inferior
surf(X, Y, Z_inf, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
hold on;

% Superficie superior
surf(X, Y, Z_sup, 'FaceAlpha', 0.5, 'EdgeColor', 'none');

% Estética
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Región de integración en 3D');
grid on;
view(3);

legend('z = x (inferior)', 'z = x + y (superior)');

fprintf('Gráfica generada correctamente.\n');