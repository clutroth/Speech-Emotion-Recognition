classdef Knn
    properties
        model,
    end
    
    methods
        function obj = Knn(X, Y)
            obj.model = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);
        end
        function label = predict(obj, X)
            label =  obj.model.predict(X);
        end
    end
    
end

