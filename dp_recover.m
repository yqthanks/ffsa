function rects = dp_recover(dpmat, x0, y0, x1, y1, mina, minw,rects)

[dim1 dim2 dim3 dim4] = size(dpmat);

%bounded search of splits
h = y1 -y0 +1;
w = x1 - x0 +1;
minwx = max(minw, ceil(mina/h));
minwy = max(minw, ceil(mina/w));

if x0+minwx-1 > x1-minwx
    
else
    for i = x0+minwx-1:x1-minwx
        ax0 = x0; ax1 = i;
        bx0 = i+1; bx1 = x1;
        if dpmat(ax0,y0,ax1,y1) + dpmat(bx0,y0,bx1,y1) == dpmat(x0,y0,x1,y1)
            [rects] = dp_recover(dpmat, ax0,y0,ax1,y1, mina, minw,rects);
            [rects] = dp_recover(dpmat, bx0,y0,bx1,y1, mina, minw,rects);
            return;
        end
    end
end

if y0+minwy-1 > y1-minwy
    
else
    for i = y0+minwy-1:y1-minwy
        ay0 = y0; ay1 = i;
        by0 = i+1; by1 = y1;
        if dpmat(x0,ay0,x1,ay1) + dpmat(x0, by0, x1, by1) == dpmat(x0,y0,x1,y1)
            [rects] = dp_recover(dpmat, x0,ay0,x1,ay1, mina, minw,rects);
            [rects] = dp_recover(dpmat, x0,by0,x1,by1, mina, minw,rects);
            return;
        end
    end
end

rects = [rects;x0,y0,x1,y1];