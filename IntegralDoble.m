% ============================================================
%   RESOLUCIÓN DE UNA INTEGRAL DOBLE PASO A PASO
% ============================================================

clear; clc; close all;

% ------------------------------------------------------------
% 1. DECLARACIÓN DE VARIABLES SIMBÓLICAS
% ------------------------------------------------------------
% Usamos variables simbólicas para obtener el resultado exacto.
syms x y

% ------------------------------------------------------------
% 2. DEFINICIÓN DE LA FUNCIÓN A INTEGRAR
% ------------------------------------------------------------
% La función dada en la integral es:
% f(x,y) = x*y
f = x*y;

% ------------------------------------------------------------
% 3. DEFINICIÓN DE LOS LÍMITES DE INTEGRACIÓN
% ------------------------------------------------------------
% La integral dada es:
%
%   ∫_0^2 ∫_y^(sqrt(2y)) x y dx dy
%
% Por lo tanto:
% - El límite exterior es y desde 0 hasta 2
% - El límite interior es x desde y hasta sqrt(2y)

y_inf = 0;
y_sup = 2;

x_inf = y;
x_sup = sqrt(2*y);

% ------------------------------------------------------------
% 4. ENCABEZADO DE IMPRESIÓN EN PANTALLA
% ------------------------------------------------------------
fprintf('==============================================\n');
fprintf('      RESOLUCION DE INTEGRAL DOBLE\n');
fprintf('==============================================\n\n');

fprintf('Integral dada:\n');
fprintf('Integral de 0 a 2 de la integral de y a sqrt(2y) de x*y dx dy\n\n');

fprintf('Funcion a integrar: f(x,y) = %s\n\n', char(f));

% ------------------------------------------------------------
% 5. PRIMER PASO: INTEGRAR RESPECTO A x
% ------------------------------------------------------------
fprintf('Paso 1: Integrando respecto a x\n');
fprintf('Límites: x = [%s, %s]\n\n', char(x_inf), char(x_sup));

% Integramos la función x*y respecto a x, dejando y como constante
I1 = int(f, x, x_inf, x_sup);

fprintf('Resultado parcial después de integrar en x:\n');
disp(I1);
fprintf('\n');

% ------------------------------------------------------------
% 6. SEGUNDO PASO: INTEGRAR RESPECTO A y
% ------------------------------------------------------------
fprintf('Paso 2: Integrando respecto a y\n');
fprintf('Límites: y = [%d, %d]\n\n', y_inf, y_sup);

% Integramos el resultado anterior respecto a y
I2 = int(I1, y, y_inf, y_sup);

fprintf('Resultado final exacto:\n');
disp(I2);

fprintf('Resultado final decimal:\n');
disp(double(I2));

% ------------------------------------------------------------
% 7. VERIFICACIÓN CON INTEGRAL DIRECTA
% ------------------------------------------------------------
% Esta parte confirma que el resultado coincide con la integral original.
I_verificacion = int(int(f, x, x_inf, x_sup), y, y_inf, y_sup);

fprintf('\nVerificacion directa de la integral:\n');
disp(simplify(I_verificacion));

% ------------------------------------------------------------
% 8. GRAFICACIÓN DE LA REGIÓN DE INTEGRACIÓN
% ------------------------------------------------------------
fprintf('\nGenerando grafica de la region de integracion...\n');

figure('Color','w');
hold on;

% Creamos un conjunto de valores de y para dibujar las curvas frontera
y_vals = linspace(y_inf, y_sup, 400);

% Curva inferior: x = y
x1 = y_vals;

% Curva superior: x = sqrt(2y)
x2 = sqrt(2*y_vals);

% Dibujamos el área entre ambas curvas
fill([x1 fliplr(x2)], [y_vals fliplr(y_vals)], [0.8 0.9 1], ...
     'EdgeColor', 'none', 'FaceAlpha', 0.6);

% Dibujamos las fronteras
plot(x1, y_vals, 'b', 'LineWidth', 2);
plot(x2, y_vals, 'r', 'LineWidth', 2);

% Estética de la gráfica
grid on;
xlabel('x');
ylabel('y');
title('Región de integración en el plano xy');
legend('Región', 'x = y', 'x = \surd(2y)', 'Location', 'best');
axis tight;
hold off;

fprintf('Proceso completado con exito.\n');