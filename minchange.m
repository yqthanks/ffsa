function score = minchange(dmat,x0,y0,x1,y1)

%function kscore = compute3d1(dmat,x0,y0,i,j,k)

[dim1,dim2,d] = size(dmat);

score = 0;

for k = 1:d
    kscore = computeSum(dmat, x0,y0,x1,y1,k);
    if score<kscore
        score = kscore;
    end
end

score = (x1-x0+1)*(y1-y0+1) - score;