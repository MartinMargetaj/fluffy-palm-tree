classdef mazeClass
    properties
         maze
         wallValue = 1;
         seedValue = 3;
         startValue = 4;
         endValue = 5;
         maze3D = false;
         x
         y
         z
         maxWallLength = 100;
         enablePlotting = false;
         ploter
         endCoo
         startCoo
    end
    methods
        function obj = mazeClass
             obj.ploter = evalin('base','ploter');
        end
        
        function obj = gen_new(obj,dimension)
            if any(dimension <= 3)
                error('dimension cannot be smaller than 3 in any way')
            end
            if any(dimension > 30)
                obj.enablePlotting = false;
            end
            for i = 1:length(dimension)
                if mod(dimension(i),2) ~= 1
                    dimension(i) = dimension(i) - 1;
                end
            end
            dimNum = length(dimension);
            switch  dimNum
                case 1
                    obj.x = dimension;
                    obj.y = dimension;
                    obj.z = 1;
                case 2
                    obj.x = dimension(1);
                    obj.y = dimension(2);
                    obj.z = 1;
                case 3 
                    obj.maze3D = true;
                    obj.x = dimension(1);
                    obj.y = dimension(2);
                    obj.z = dimension(3);
                otherwise
                    error('Invalid number of dimensions (we only support 3)')
            end     
            obj.maze = zeros(obj.x,obj.y,obj.z);
            obj = obj.fill_edges;
            obj = obj.fill_seeds;
            obj = obj.place_walls;
        end
        
        function obj = get_start_end(obj)
            while true
                startCooTemp = ginput(1);
                obj.startCoo = [round(startCooTemp(2)),round(startCooTemp(1))];
                if obj.maze(obj.startCoo(1),obj.startCoo(2)) == 0
                    break
                end
            end
            obj.maze(obj.startCoo(1),obj.startCoo(2)) = obj.startValue;
            obj.ploter.plot_maze(obj.maze);
            while true
                endCooTemp = ginput(1);
                obj.endCoo = [round(endCooTemp(2)),round(endCooTemp(1))];
                if obj.maze(obj.endCoo(1),obj.endCoo(2)) == 0
                    break
                end
            end
            obj.maze(obj.endCoo(1),obj.endCoo(2)) = obj.endValue;
            obj.ploter.plot_maze(obj.maze);
        end
        
        function obj = fill_edges(obj)
            if ~obj.maze3D
                obj.maze(:,1) = obj.wallValue; 
                obj.maze(:,end) = obj.wallValue; 
                obj.maze(1,:) = obj.wallValue; 
                obj.maze(end,:) = obj.wallValue;
            else
                % FIXME
                % this will result into 6 faces and 6 mazes which is not
                % great... redo this
                obj.maze(:,1,1) = obj.wallValue; 
                obj.maze(:,1,end) = obj.wallValue;
                obj.maze(:,end,1) = obj.wallValue; 
                obj.maze(:,end,end) = obj.wallValue; 
                obj.maze(1,:,1) = obj.wallValue; 
                obj.maze(1,:,end) = obj.wallValue;
                obj.maze(end,:,1) = obj.wallValue; 
                obj.maze(end,:,end) = obj.wallValue;
                obj.maze(1,1,:) = obj.wallValue; 
                obj.maze(1,end,:) = obj.wallValue;
                obj.maze(end,1,:) = obj.wallValue; 
                obj.maze(end,end,:) = obj.wallValue;
            end
        end
        
        function obj = fill_seeds(obj)
            % TODO
            % add option for 3d
            for i = 3:2:size(obj.maze,1)-2
                for j = 3:2:size(obj.maze,2)-2
                    obj.maze(i,j) = obj.seedValue; 
                end
            end
        end
        
        function obj = place_walls(obj)
            while ~isempty(find(obj.maze == 3)) 
                numSeeds = length(find(obj.maze == 3));
                selSeed = randi(numSeeds);
                seedPosn = find(obj.maze == 3);
                seedPosn = seedPosn(selSeed);
                yTemp = ceil(seedPosn/obj.y);
                xTemp = mod(seedPosn,obj.y);
                seedPosn = [xTemp,yTemp];
                direction = get_direction(obj);
                for i = 1:obj.maxWallLength
                    if obj.maze(seedPosn(1),seedPosn(2)) == obj.wallValue
                        break
                    end
                    obj.maze(seedPosn(1),seedPosn(2)) = obj.wallValue;
                    seedPosn = seedPosn + direction;
                    if obj.enablePlotting
                        obj.ploter.plot_maze(obj.maze);
                    end
                end
            end
        end
        
        function direction = get_direction(obj)
            dirNum = randi(4);
            switch dirNum
                case 1
                    direction = [1,0];
                case 2
                    direction = [-1,0];
                case 3
                    direction = [0,1];
                otherwise
                    direction = [0,-1];
            end
        end
    end
end

