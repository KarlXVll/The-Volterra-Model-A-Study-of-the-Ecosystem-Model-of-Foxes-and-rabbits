% задаем значения констант
a = 0.001;
C = 46.61374*quad(@(x) sin(x)./(x.^2+1),0,1);
x0 = fzero(@(x) 2^x - 4*x, 2);
F = 0.5*x0;

% решаем систему уравнений для определения значений A, B и D
A = [46 42 24; 42 49 18; 24 18 16];
B = [20628; 20346; 10252];
X = linsolve(A,B);
r0_1 = 2*X(2);
f0_1 = X(2);
r0_2 = X(2);
f0_2 = X(2);
r0_3 = 5;
f0_3 = 10;
r0_4 = 10;
f0_4 = 10;

% задаем начальные условия и параметры для решения дифференциальных уравнений с помощью функции ode45
tspan = [0 10];
y0_1 = [r0_1; f0_1];
y0_2 = [r0_2; f0_2];
y0_3 = [r0_3; f0_3];
y0_4 = [r0_4; f0_4];

% решаем систему дифференциальных уравнений и строим графики
[t1,y1] = ode45(@(t,y) [2*y(1)-a*y(1)*y(2); -y(2)+a*y(1)*y(2)], tspan, y0_1);
[t2,y2] = ode45(@(t,y) [2*y(1)-a*y(1)*y(2); -y(2)+a*y(1)*y(2)], tspan, y0_2);
[t3,y3] = ode45(@(t,y) [2*y(1)-a*y(1)*y(2); -y(2)+a*y(1)*y(2)], tspan, y0_3);
[t4,y4] = ode45(@(t,y) [2*y(1)-a*y(1)*y(2); -y(2)+a*y(1)*y(2)], tspan, y0_4);


figure;
plot(y1(:,1), y1(:,2));
xlabel('Число кроликов');
ylabel('Число лис');
title(['r0 = ', num2str(r0_1), ', f0 = ', num2str(f0_1)]);

figure();
plot(y2(:,1), y2(:,2));
xlabel('Число кроликов');
ylabel('Число лис');
title(['r0 = ', num2str(r0_2), ', f0 = ', num2str(f0_2)]);

figure();
plot(y3(:,1), y3(:,2));
xlabel('Число кроликов');
ylabel('Число лис');
title(['r0 = ', num2str(r0_3), ', f0 = ', num2str(f0_3)]);

figure();
plot(y4(:,1), y4(:,2));
xlabel('Число кроликов');
ylabel('Число лис');
title(['r0 = ', num2str(r0_4), ', f0 = ', num2str(f0_4)]);

 %Графики зависимости от времени
figure();
plot(t1, round(y1(:,1)), 'b', t1, round(y1(:,2)), 'r');
xlabel('Время');
ylabel('Число особей');
title(['r0 = ', num2str(r0_1), ', f0 = ', num2str(f0_1)]);
legend('Кролики', 'Лисы', 'Location', 'northwest');

figure();
plot(t2, round(y2(:,1)), 'b', t2, round(y2(:,2)), 'r');
xlabel('Время');
ylabel('Число особей');
title(['r0 = ', num2str(r0_2), ', f0 = ', num2str(f0_2)]);
legend('Кролики', 'Лисы', 'Location', 'northwest');

figure();
plot(t3, round(y3(:,1)), 'b', t3, round(y3(:,2)), 'r');
xlabel('Время');
ylabel('Число особей');
title(['r0 = ', num2str(r0_3), ', f0 = ', num2str(f0_3)]);
legend('Кролики', 'Лисы', 'Location', 'northwest');

figure();
plot(t4,round(y4(:,1)), 'b', t4, round(y4(:,2)), 'r');
xlabel('Время');
ylabel('Число особей');
title(['r0 = ', num2str(r0_4), ', f0 = ', num2str(f0_4)]);
legend('Кролики', 'Лисы', 'Location', 'northwest');


% оцениваем погрешность результата и влияние на точность погрешности исходных данных методом Монте-Карло
n = 1000;
r0_rand = rand(n,1)*10;
f0_rand = rand(n,1)*10;
results = zeros(n,1);

for i=1:n
    y0_rand = [r0_rand(i); f0_rand(i)];
    [~,y_rand] = ode45(@(t,y) [2*y(1)-a*y(1)*y(2); -y(2)+a*y(1)*y(2)], tspan, y0_rand);
    results(i) = abs(y_rand(end,1) - y_rand(end,2));
end

mean_error = mean(results);
std_error = std(results);

disp(['Средняя ошибка: ', num2str(mean_error)]);
disp(['Стандартное отклонение: ', num2str(std_error)]);

