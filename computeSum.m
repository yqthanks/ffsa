function score = computeSum(imgii,x0,y0,x1,y1,k)

if y0==1 || x0==1
    score = imgii(x1,y1,k);
    if x0>1
        score = score - imgii(x0-1,y1,k);
    else
        if y0>1
            score = score - imgii(x1,y0-1,k);
        end
    end
else
    score = imgii(x1,y1,k)-imgii(x1,y0-1,k)-imgii(x0-1,y1,k)+imgii(x0-1,y0-1,k);
end