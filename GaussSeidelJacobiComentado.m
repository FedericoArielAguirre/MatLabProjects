%GaussSeidel-Jacobi_Comentado
%TP2-Ejercicio2c

% Borramos la ventana de comandos y las variables previas
clc
clear

% Considere una barra de metal de 10m de longitud que es sometida 
% a una fuente de calor en un% extremo por un tiempo determinado. 
% Al cabo de ese tiempo, la fuente de calor cesa y se miden
% temperaturas de 10◦C y 200◦C en ambos extremos. Se desea encontrar
% la temperatura en los puntos intermedios x1, x2, x3 y x4 ubicados
% a 2m equidistantes unos de otros. Asumiendo que latemperatura
% en cada punto es el promedio de las temperaturas medidas
% en los puntos vecinos,


% Definimos las matrices
A = [2 -1 0 0; -1 2 -1 0; 0 -1 2 -1; 0 0 -1 2]; %Matriz longitud barra A
b = [10; 0; 0; 200]; %Matriz b con temperaturas

% Metodo de Jacobi
D = diag(A);%extrae la diagonal de la matriz A 
% y la asigna a la variable D
R = A-diag(D);%alcula la matriz R restando la diagonal de A de la propia
% matriz A. Esto se hace para obtener la matriz de residuos
x_jacobi = zeros(4, 1);% inicializa el vector solución x_jacobi con ceros
tol = 1e-6; %establece la tolerancia para el método de Jacobi,
% que es el error máximo permitido entre la solución actual
% y la solución anterior
max_iter = 100;%el número máximo de iteraciones para el método de Jacobi

% Bucle hasta que se alcanza la tolerancia
for i = 1:max_iter
    %comienza un bucle que se ejecutará hasta que se alcance la 
    %tolerancia o se complete el número máximo de iteraciones.
    x_new = (b - R * x_jacobi) ./ D;
    %calcula la nueva solución x_new utilizando la fórmula del
    % método de Jacobi. La fórmula es: x_new = (b - R * x_jacobi) / D, 
    % donde b es el vector de la mano derecha del sistema de ecuaciones
    if norm(x_new - x_jacobi) < tol
        %verifica si la norma del error entre la solución actual x_new
        %y la solución anterior x_jacobi es menor que la tolerancia. 
        % Si es así, el bucle se detiene
        break
    end
    x_jacobi = x_new; 
    %actualiza la solución x_jacobi con la nueva solución x_new
end
 % Mostramos los resultados
 disp("La solución por el metodo de Jacobi es:");
 disp(x_jacobi);

 % Metodo de Gauss-Seidel

x_gauusseidel = zeros(4, 1); % Esta línea inicializa 
% el vector solución x_gauusseidel con ceros.

%tol = 1e-6;
%max_iter = 100;

for i = 1:max_iter
    %comienza un bucle que se ejecutará hasta que se alcance 
    %la tolerancia o se complete el número máximo de iteraciones.
    for j = 1:4 %comienza un bucle interno que se
        % ejecutará para cada elemento del vector solución.
        sum = 0; % inicializa la variable sum con cero.
        for k = 1:j-1
            % comienza un bucle que se ejecutará para calcular 
            % la suma de los términos que corresponden a los 
            % elementos anteriores del vector solución. 
            sum = sum + A(j, k) * x_gauusseidel(k);
            % calcula la suma de los términos que corresponden 
            % a los elementos anteriores del vector solución
        end
        for k = j+1:4
            %comienza un bucle que se ejecutará para calcular la 
            % suma de los términos que corresponden a los elementos
            % posteriores del vector solución.
            sum = sum + A(j, k) * x_gauusseidel(k);
            %calcula la suma de los términos que corresponden 
            % a los elementos posteriores del vector solución.
        end
        x_gauusseidel(j) = (b(j) - sum) / A(j, j);
        % calcula el nuevo valor del elemento j del vector 
        % solución utilizando la fórmula del método de Gauss-Seidel.
    end
    if norm(A * x_gauusseidel - b) < tol %verifica si la norma del
        % error entre la solución actual x_gauusseidel y la solución
        % exacta b es menor que la tolerancia. Si es así,
        % el bucle se detiene.
        break
    end
end
 % Mostramos los resultados
 disp("La solución por el metodo de Gauss-Seidel es:");
 disp(x_gauusseidel);


%Ventajas y desventajas


% El método de Jacobi es más sencillo de implementar y requiere 
% menos operaciones que el método de Gauss-Seidel. Sin embargo, 
% puede ser más lento en converger a la solución exacta.

% El método de Gauss-Seidel es más rápido en converger a la 
% solución exacta que el método de Jacobi, pero requiere más
% operaciones y es más complejo de implementar.


