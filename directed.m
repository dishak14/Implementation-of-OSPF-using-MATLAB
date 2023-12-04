  adjacencyMatrix = [
    0 1 0 0 0 0;
    0 0 1 0 2 0;
    0 0 0 2 4 0;
    0 0 1 0 1 0;
    3 0 0 2 0 3;
    2 0 0 0 0 0;
];

numNodes = size(adjacencyMatrix, 1);

while true
    % Display the adjacency matrix
    fprintf('Adjacency Matrix:\n');
    disp(adjacencyMatrix);

    % Display the network graph
    G = digraph(adjacencyMatrix);
    nodeNames = cell(1, numNodes);
    for i = 1:numNodes
        nodeNames{i} = sprintf('Node %d', i);
    end
    h = plot(G, 'EdgeLabel', G.Edges.Weight, 'EdgeLabelColor', 'k', 'NodeLabel', nodeNames);
    title('Network Graph');

    sourceNode = input('Enter the source node: ');
    destinationNode = input('Enter the destination node: ');

    if sourceNode < 1 || sourceNode > numNodes || destinationNode < 1 || destinationNode > numNodes
        fprintf('Invalid source or destination node.\n');
    else
        distances = inf(1, numNodes);
        visited = false(1, numNodes);
        distances(sourceNode) = 0;
        predecessors = zeros(1, numNodes);
        for i = 1:numNodes
            currentMinDistance = inf;
            currentNode = -1;
            for j = 1:numNodes
                if ~visited(j) && distances(j) < currentMinDistance
                    currentNode = j;
                    currentMinDistance = distances(j);
                end
            end

            if currentNode == -1
                break; 
            end

            visited(currentNode) = true;

            for j = 1:numNodes
                if adjacencyMatrix(currentNode, j) > 0
                    if distances(currentNode) + adjacencyMatrix(currentNode, j) < distances(j)
                        distances(j) = distances(currentNode) + adjacencyMatrix(currentNode, j);
                        predecessors(j) = currentNode;
                    end
                end
            end
        end

        shortestDistance = distances(destinationNode);

        if shortestDistance == inf
            fprintf('No path exists from Node %d to Node %d.\n', sourceNode, destinationNode);
        else
            fprintf('Shortest distance from Node %d to Node %d: %d\n', sourceNode, destinationNode, shortestDistance);
        end

        % Ask the user if they want to change weights
        changeWeights = input('Do you want to change weights? (1 for Yes, 0 for No): ');

        if changeWeights
            fromNode = input('Enter the source node to change weight: ');
            toNode = input('Enter the destination node to change weight: ');
            newWeight = input('Enter the new weight: ');

            if fromNode >= 1 && fromNode <= numNodes && toNode >= 1 && toNode <= numNodes
                % Update adjacencyMatrix
                adjacencyMatrix(fromNode, toNode) = newWeight;

                % Display updated adjacency matrix
                fprintf('Updated Adjacency Matrix:\n');
                disp(adjacencyMatrix);

                % Update graph
                G = digraph(adjacencyMatrix);
                h = plot(G, 'EdgeLabel', G.Edges.Weight, 'EdgeLabelColor', 'k', 'NodeLabel', nodeNames);
                title('Updated Network Graph');

                % Run shortest path algorithm on the updated graph
                distances = inf(1, numNodes);
                visited = false(1, numNodes);
                distances(sourceNode) = 0;
                predecessors = zeros(1, numNodes);
                for i = 1:numNodes
                    currentMinDistance = inf;
                    currentNode = -1;
                    for j = 1:numNodes
                        if ~visited(j) && distances(j) < currentMinDistance
                            currentNode = j;
                            currentMinDistance = distances(j);
                        end
                    end

                    if currentNode == -1
                        break;
                    end

                    visited(currentNode) = true;

                    for j = 1:numNodes
                        if adjacencyMatrix(currentNode, j) > 0
                            if distances(currentNode) + adjacencyMatrix(currentNode, j) < distances(j)
                                distances(j) = distances(currentNode) + adjacencyMatrix(currentNode, j);
                                predecessors(j) = currentNode;
                            end
                        end
                    end
                end

                % Display shortest path information on the updated graph
                shortestDistance = distances(destinationNode);

                if shortestDistance == inf
                    fprintf('No path exists from Node %d to Node %d.\n', sourceNode, destinationNode);
                else
                    fprintf('Shortest distance from Node %d to Node %d: %d\n', sourceNode, destinationNode, shortestDistance);
                end
            else
                fprintf('Invalid source or destination node.\n');
            end
        end
    end

    % Ask the user if they want to run the program again or exit
    userChoice = input('Do you want to run the program again? (1 for Yes, 0 for No, "exit" to end): ', 's');

    if strcmp(userChoice, 'exit') || ~str2double(userChoice)
        break;
    end
end
