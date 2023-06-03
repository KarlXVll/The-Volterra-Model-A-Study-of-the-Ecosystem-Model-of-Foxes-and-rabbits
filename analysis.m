function main()% Задание диапазонов и распределений для каждого параметра
a_min = 0;
a_max = 10;
C_min = 0;
C_max = 5;
x0_min = -5;
x0_max = 5;
F_min = 0;
F_max = 1;
A_mean = 1;
A_std = 0.1;
B_mean = 2;
B_std = 0.2;
D_mean = 0.1;
D_std = 0.01;
% Генерация случайных значений для каждого параметра
n_iterations = 1000; % Количество итераций
a_values = rand(n_iterations, 1) * (a_max - a_min) + a_min;
C_values = rand(n_iterations, 1) * (C_max - C_min) + C_min;
x0_values = rand(n_iterations, 1) * (x0_max - x0_min) + x0_min;
F_values = rand(n_iterations, 1) * (F_max - F_min) + F_min;
A_values = normrnd(A_mean, A_std, n_iterations, 1);
B_values = normrnd(B_mean, B_std, n_iterations, 1);
D_values = normrnd(D_mean, D_std, n_iterations, 1);
% Запуск модели для каждого набора случайных данных
results = zeros(n_iterations, 1);
for i = 1:n_iterations
result = run_model(a_values(i), C_values(i), x0_values(i), F_values(i), A_values(i), B_values(i),
D_values(i));
10
results(i) = result;
end
% Оценка общей погрешности результата
mean_result = mean(results);
std_result = std(results);
disp(['Mean result: ', num2str(mean_result)]);
disp(['Std result: ', num2str(std_result)]);
% Оценка влияния на точность погрешности исходных данных
sensitivity_a = std(results ./ a_values);
sensitivity_C = std(results ./ C_values);
sensitivity_x0 = std(results ./ x0_values);
sensitivity_F = std(results ./ F_values);
sensitivity_A = std(results ./ A_values);
sensitivity_B = std(results ./ B_values);
sensitivity_D = std(results ./ D_values);
disp(['Sensitivity a: ', num2str(sensitivity_a)]);
disp(['Sensitivity C: ', num2str(sensitivity_C)]);
disp(['Sensitivity x0: ', num2str(sensitivity_x0)]);
disp(['Sensitivity F: ', num2str(sensitivity_F)]);
disp(['Sensitivity A: ', num2str(sensitivity_A)]);
disp(['Sensitivity B: ', num2str(sensitivity_B)]);
disp(['Sensitivity D: ', num2str(sensitivity_D)]);
end
function result = run_model(a, C, x0, F, A, B, D)
t = 0:0.01:10; % Временной интервал моделирования
y = A * sin(B * t) .* exp(-D * t); % Модельный результат
result = trapz(t, y); % Определение интеграла
end
