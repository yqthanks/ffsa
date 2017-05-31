function [opt, rarray] = getFFSA(rects, benefit3d, cost3d, budget)

%***Note: to run this, you will need to specify your integer programming
%solver at line 33: x = ip_solve(b1,c1,b,aeq,beq,ctype).

%***As an alternative, you can use another script "generateData" (also used at the end here) to
%generate dataset to use with your own integer programming solver or any
%solver for the Multiple-Choice Knapsack Problem.

%%Inputs:
%  benefit3d = a 3d matrix where each 3rd dimension represents a different
% choice. The first two dimensions represent the 2d grid, where each grid cell (i,j)
% is a location in the study area. A value in the 3d matrix means the
% benefit of a choice at a specific location.
% -- cost3d = similar to benefit3d, but the values are costs.
% -- budget = a single value limiting the total amount of cost.

%%Outputs:
% -- opt = a 2d matrix where each value is a choice at a location (i,j)
% -- rarray = a list of rectangles and the choice on the rectangle (xmin,ymin,xmax,ymax,choice)

%compute integral image for benefit3d, cost3d (not necessary here)

rarray = rects(:,:);
[dim1, dim2, totalChoice] = size(benefit3d);

disp('ip starts');
[b1,c1,b,aeq,beq,ctype] = generateData(rarray, benefit3d, cost3d, totalChoice, budget);

%specify your own integer programming solver and use the above generated
%inputs if needed

x = ip_solve(b1,c1,b,aeq,beq,ctype);%***define your own integer programming solver

disp('ip completes');

%map to FFSA solution
x = int16(x);
dim = max(size(x));
for i = 1:dim/totalChoice
    base = (i-1)*totalChoice;
    for j = 1:totalChoice
        if x(base+j)==1
            rarray(i,5) = j;
            break;
        end
    end
end

opt = zeros(dim1, dim2);
for i = 1:size(rarray,1)
    x0 = rarray(i,1);
    y0 = rarray(i,2);
    x1 = rarray(i,3);
    y1 = rarray(i,4);
    k = rarray(i,5);
    for ii = x0:x1
        for jj = y0:y1
            opt(ii,jj) = k;
        end
    end
end

