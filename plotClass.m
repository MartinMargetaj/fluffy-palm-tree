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
            greenColor = obj.actualMaze == 4;
            redColor = obj.actualMaze == 5;
            yellowColor =  obj.actualMaze == 3;
            plotedPic(:,:,2) = plotedPic(:,:,2) - blueColor;
            plotedPic(:,:,1) = plotedPic(:,:,1) - blueColor;
            plotedPic(:,:,3) = plotedPic(:,:,3) - greenColor;
            plotedPic(:,:,1) = plotedPic(:,:,1) - greenColor;
            plotedPic(:,:,3) = plotedPic(:,:,3) - redColor;
            plotedPic(:,:,2) = plotedPic(:,:,2) - redColor;
            plotedPic(:,:,3) = plotedPic(:,:,3) - yellowColor;
            image(plotedPic)
            axis square
            axis off
            pause(0.1)
        end
    end
    
end

