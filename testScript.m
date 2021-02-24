% testing script
clc; clear; close all

%% init of classes
ploter = plotClass;
maze = mazeClass;
solver = solvingClass;


%% generate maze 
maze = maze.gen_new(25);

%% plot maze

ploter = ploter.plot_maze(maze.maze);

maze = maze.get_start_end;

solver = solver.solve_it;
disp('done')