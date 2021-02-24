% testing script
clc; clear; close all

%% init of classes
ploter = plotClass;
maze = mazeClass;


%% generate maze 
maze = maze.gen_new(19);

%% plot maze

ploter = ploter.plot_maze(maze.maze);

maze = maze.get_start_end;