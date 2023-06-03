function main()
a = 0.001;
C = 46.61374 * quad(@(x) sin(x)./(x.^2 + 1), 0, 1);
x0 = fzero(@(x) 2^x - 4*x, 1.5);
F = 0.5 * x0;
% Решаем системы уравнений для нахождения A, B и D
ABD = [46, 42, 24; 42, 49, 18; 24, 18, 16]\[20628; 20346; 10252];
A = ABD(1);
B = ABD(2);
D = ABD(3);
% Решаем дифференциальные уравнения
[T, Y1] = ode45(@(t, y) volterra(t, y, a), [0:0.5:10], [A, 0.5*A]);
[T, Y2] = ode45(@(t, y) volterra(t, y, a), [0:0.5:10], [B, B]);
[T, Y3] = ode45(@(t, y) volterra(t, y, a), [0:0.5:10], [C, D]);
[T, Y4] = ode45(@(t, y) volterra(t, y, a), [0:0.5:10], [F, F]);
% Строим графики
figure(1);
plot(Y1(:,2), Y1(:,1), 'LineWidth', 2);
xlabel('f');
ylabel('r');
title('График для A и F = 0.5x0');
grid on;
figure(2);
plot(Y2(:,2), Y2(:,1), 'LineWidth', 2);
xlabel('f');
ylabel('r');
title('График для B');
grid on;
figure(3);
plot(Y3(:,2), Y3(:,1), 'LineWidth', 2);
xlabel('f');
ylabel('r');
title('График для C и D');
grid on;
figure(4);
plot(Y4(:,2), Y4(:,1), 'LineWidth', 2);
xlabel('f');
ylabel('r');
title('График для F');
grid on;
end
% Определяем функцию для решения модели Вольтерры
function dydt = volterra(t, y, a)
dydt = [2*y(1) - a*y(1)*y(2); -y(2) + a*y(1)*y(2)];
end
