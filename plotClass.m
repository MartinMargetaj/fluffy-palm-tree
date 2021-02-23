classdef plotClass
    %PLOTCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        actualMaze
    end
    
    methods
        function obj = plot_maze(obj, maze)
            obj.actualMaze = maze;
            obj = plot_wall(obj);
        end
        
        function obj = plot_wall(obj)
            plotedPic = ones(size(obj.actualMaze,1),size(obj.actualMaze,2),3);
            blueColor = obj.actualMaze == 1;
            plotedPic(:,:,2) = ~blueColor;
            plotedPic(:,:,1) = ~blueColor;
            image(plotedPic)
            axis square
            axis off
            pause(0.1)
        end
    end
    
end

