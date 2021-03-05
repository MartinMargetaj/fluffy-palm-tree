classdef solvingClass
    %SOLVINGCLASS Summary of this class goes here
    %   Detailed explanation goes here
    properties
        ploter
        maze
        pointMap
        pathMap
        curentPosition
        crossWays = {};
    end
    
    methods
        function obj = solvingClass
        end
        
        function obj = solve_it(obj)
            obj.ploter = evalin('base','ploter');
            obj.maze = evalin('base','maze');
            obj.curentPosition = obj.maze.startCoo;
            obj.pointMap = zeros(obj.maze.x,obj.maze.y,obj.maze.z);
            while true
                obj = obj.place_points();
                obj = obj.solve_step();
                if (obj.curentPosition(1) == obj.maze.endCoo(1)) && (obj.curentPosition(2) == obj.maze.endCoo(2))
                    break
                end
                obj.ploter.plot_maze(obj.maze.maze);
            end
        end
        
        function obj = place_points(obj)
            endCoo = obj.maze.endCoo;
            finalScore = 50 + obj.maze.x * obj.maze.y;
            for i = 1:obj.maze.x
                for j = 1:obj.maze.y
                    obj.pointMap(i,j) = finalScore - sqrt(((endCoo(1)-i)^2) + ((endCoo(2)-j)^2));                
                end
            end
            walls = obj.maze.maze ~= 0;
            endpoint = obj.maze.maze == 5;
            walls = walls & ~endpoint;
            obj.pointMap = obj.pointMap.*double(~walls);
        end   
        
        function obj = solve_step(obj)
            passibleDir{1} = [1,0];
            passibleDir{2} = [-1,0];
            passibleDir{3} = [0,1];
            passibleDir{4} = [0,-1];
            nextDir = [0,0];
            maxFind = 0;
            for i = 1:4
                lookHere = obj.curentPosition - passibleDir{i};
                findTemp = obj.pointMap(lookHere(1),lookHere(2));
                if findTemp ~= 0
                    obj.crossWays{end+1,1} = findTemp;
                    obj.crossWays{end,2} = lookHere;
                end
            end
            obj = obj.move_lovest();
        end
        
        function obj = move_lovest(obj)
            maximalValue = max([obj.crossWays{:,1}]);
            maximalValuePosition = find([obj.crossWays{:,1}] == maximalValue);
            if length(maximalValuePosition) ~= 1
                maximalValuePosition = maximalValuePosition(1);
            end
            obj.curentPosition = obj.crossWays{maximalValuePosition,2};
            obj.maze.maze(obj.curentPosition(1),obj.curentPosition(2)) = 10;
            obj.crossWays(maximalValuePosition,:) = [];
        end
    end
end

