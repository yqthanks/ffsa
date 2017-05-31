function sol3d = getMultilayer(sol2d)

[dim1, dim2] = size(sol2d);

dim3 = max(max(sol2d));

sol3d = zeros(dim1,dim2,dim3);

for i = 1:dim1
    for j = 1:dim2
        k = sol2d(i,j);
        sol3d(i,j,k) = 1;
    end
end