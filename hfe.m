function rects = hfe(ipsol, mina, minw)

% %Inputs:
% -- ipsol = 2d integer programming solution (no spatial constraints), each
% value represents a choice (e.g., 1,2,3...). The valid values should be from 1
% to the total number of choices.
% -- mina = minimum area (unit: grid cell)
% -- minw = minimum width as well as height (unit: grid cell)
% %

% %Outputs:
% -- rects: a list of rectangles (xmin, ymin, xmax, ymax), representing the partition of the study
% area
% %

%construct multilayer representation and multilayer integral image (dmatii)
ipsol3d = getMultilayer(ipsol);
[dim1, dim2, dim3] = size(ipsol3d);

dmatii = ipsol3d(:,:,:);
for i = 1:dim3
    dmatii(:,:,i) = computeII(dmatii(:,:,i));%compute integral image
end

x0 = 1; y0 = 1;
x1 = dim1; y1 = dim2;

%create score matrix to store temporary results
nodata = uint16(inf);%def nodata
dpmat = (uint16(ones(dim1, dim2, dim1, dim2, 'uint16')))*nodata;

%get minimum number of changes (score) and the completed score matrix from
%dynamic programming
[score, dpmat] = dp_score(dmatii, dpmat, x0, y0, x1, y1, mina, minw, nodata);

%use the score and the 4d score matrix to recover the actual partitions
rects=[];
rects = dp_recover(dpmat, x0, y0, x1, y1, mina, minw, rects);

