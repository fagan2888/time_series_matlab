%% Starting with a clean slate

clear
close all
clc


%% Setting up the environment (ensuring replicability)
rng(3006510)
T = 350;
irf_horizon = 250;
irf_identif = 'short-run';

% Graphics settings
theline_color = 'red';
theline_width = 1;
theline_style = '--';
irfline_color = 'black';
irfline_width = 1;
irfline_style = '-';
refline_color = 'black';
refline_width = 1;
refline_style = ':';

%% Generating (not so much) random data
N = 2;

y1 = zeros(T, 1);
y2 = zeros(T, 1);

e1 = randn(T, 1);
e2 = randn(T, 1);

y = [y1, y2];
e = [e1, e2];

C = [ 0 ; ...
      0 ];
 
B = [ 0.7, -0.1 ; ...
     -0.2,  0.9 ];
 
G = [ 0.3,  0.0 ; ...
      0.5,  0.8 ];

for t = 2 : T
    y(t, :) = C' + y(t-1, :) * B + e(t, :) * G;
end

%% Cleaning up the mess

y = y(101:end, :);
T = size(y, 1);

clearvars e1 e2 y1 y2 t


%% Starting testing

[Bhat, Shat] = VAR(y, 1);
ir = IRF(irf_horizon, Bhat, Shat, irf_identif);

ir_theory = zeros(N, N, irf_horizon);

for h = 1 : irf_horizon
    ir_theory(:, :, h) = G * B^(h-1);
end


%% Plotting results

figure
plot(y, 'LineWidth', 1)
legend({'$y_1$', '$y_2$'}, 'interpreter', 'latex')
grid on; box on;

figure
subplot(2, 2, 1)
    hold on
        plot(squeeze(ir(1, 1, :)), ...
             'Color',     irfline_color, ...
             'LineWidth', irfline_width, ...
             'LineStyle', irfline_style)
        plot(squeeze(ir_theory(1, 1, :)), ...
             'Color',     theline_color, ...
             'LineWidth', theline_width, ...
             'LineStyle', theline_style)
        z = refline(0, 0);
        z.Color     = refline_color;
        z.LineStyle = refline_style;
        z.LineWidth = refline_width;
    hold off
    legend({'Estimated', 'Theoretical'})
    title('IRF of y_1 to e_1')
    grid on; box on;

subplot(2, 2, 2)
    hold on
        plot(squeeze(ir(1, 2, :)), ...
             'Color',     irfline_color, ...
             'LineWidth', irfline_width, ...
             'LineStyle', irfline_style)
        plot(squeeze(ir_theory(1, 2, :)), ...
             'Color',     theline_color, ...
             'LineWidth', theline_width, ...
             'LineStyle', theline_style)
        z = refline(0, 0);
        z.Color     = refline_color;
        z.LineStyle = refline_style;
        z.LineWidth = refline_width;
    hold off
    legend({'Estimated', 'Theoretical'})
    title('IRF of y_1 to e_2')
    grid on; box on;

subplot(2, 2, 3)
    hold on
      plot(squeeze(ir(2, 1, :)), ...
             'Color',     irfline_color, ...
             'LineWidth', irfline_width, ...
             'LineStyle', irfline_style)
      plot(squeeze(ir_theory(2, 1, :)), ...
             'Color',     theline_color, ...
             'LineWidth', theline_width, ...
             'LineStyle', theline_style)
      z = refline(0, 0);
      z.Color     = refline_color;
      z.LineStyle = refline_style;
      z.LineWidth = refline_width;
    hold off
    legend({'Estimated', 'Theoretical'})
    title('IRF of y_2 to e_1')
    grid on; box on;

subplot(2, 2, 4)
    hold on
        plot(squeeze(ir(2, 2, :)), ...
             'Color',     irfline_color, ...
             'LineWidth', irfline_width, ...
             'LineStyle', irfline_style)
        plot(squeeze(ir_theory(2, 2, :)), ...
             'Color',     theline_color, ...
             'LineWidth', theline_width, ...
             'LineStyle', theline_style)
        z = refline(0, 0);
        z.Color     = refline_color;
        z.LineStyle = refline_style;
        z.LineWidth = refline_width;
    hold off
    legend({'Estimated', 'Theoretical'})
    title('IRF of y_2 to e_2')
    grid on; box on;
