function [score, dpmat] = dp_score(dmatii, dpmat, x0, y0, x1, y1, mina, minw, nodata)

%bounded search of splits
h = y1 -y0 +1;
w = x1 - x0 +1;
minwx = max(minw, ceil(mina/h));
minwy = max(minw, ceil(mina/w));

%unsplittable if value is 1 (default)
minimal = 1;

%init score
score = inf;

if x0+minwx-1 > x1-minwx
    
else
    minimal = 0;
    for i = x0+minwx-1:x1-minwx
        ax0 = x0; ax1 = i;
        bx0 = i+1; bx1 = x1;
        if dpmat(ax0,y0,ax1,y1) == nodata
            [ascore, dpmat] = dp_score(dmatii, dpmat, ax0, y0, ax1, y1, mina, minw, nodata);
            dpmat(ax0,y0,ax1,y1) = ascore;
        else 
            ascore = dpmat(ax0,y0,ax1,y1);
        end
        if dpmat(bx0,y0,bx1,y1) == nodata
            [bscore, dpmat] = dp_score(dmatii, dpmat, bx0, y0, bx1, y1, mina, minw, nodata);
            dpmat(bx0,y0,bx1,y1) = bscore;
        else
            bscore = dpmat(bx0,y0,bx1,y1);
        end
        if ascore + bscore < score
            score = ascore + bscore;
        end
    end
end

if y0+minwy-1 > y1-minwy
    
else
    minimal = 0;
    for i = y0+minwy-1:y1-minwy
        ay0 = y0; ay1 = i;
        by0 = i+1; by1 = y1;
        if dpmat(x0,ay0,x1,ay1) == nodata
            [ascore, dpmat] = dp_score(dmatii, dpmat, x0, ay0, x1, ay1, mina, minw, nodata);
            dpmat(x0,ay0,x1,ay1) = ascore;
        else 
            ascore = dpmat(x0,ay0,x1,ay1);
        end
        if dpmat(x0,by0,x1,by1) == nodata
            [bscore, dpmat] = dp_score(dmatii, dpmat, x0, by0, x1, by1, mina, minw, nodata);
            dpmat(x0,by0,x1,by1) = bscore;
        else
            bscore = dpmat(x0,by0,x1,by1);
        end
        if ascore + bscore < score
            score = ascore + bscore;
        end
    end
end

if minimal == 1
    score = minchange(dmatii, x0, y0, x1, y1);
end

dpmat(x0, y0, x1, y1) = score;