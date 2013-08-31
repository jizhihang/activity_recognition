function cumError = cccp_error(params,trainData,model,C)
% after learning, model holds new parameters model.w, recompute optimal
% value to measure cumulative error over data

%%% TODO USE MEX FUNCTION TO GET CUMERROR< NOT DO INFERENCE AGAIN 

F = 0;
for i = 1 : length(params.labels)
       
    X = params.patterns{i};
    Y = trainData.labels{i};
    YZ = sub2ind(params.szYZ, Y, ones(size(Y))); % Z does not matter when computing loss function
    
    % argmax_y delta(yi, y) + <psi(x,y), w>
    [~,Fi] = constraintCB(params, model, X, YZ);
    F = Fi + F;
end
F = (norm(model.w)^2)/2 + C * F;

G = 0;
for i = 1 : length(params.labels)      
    X = params.patterns{i};
    Y = trainData.labels{i}; % groundtruth labels
        
    % argmax_z <phi(x,y,z), w>
    [~,Gi] = inferLatentVariable(params, model, X, Y);
    G = Gi + G;
end
G = C * G;

cumError = F - G; % don't forget the norm...

end