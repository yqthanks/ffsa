function [b1,c1,b,aeq,beq,ctype] = generateData(r, benefit3d, cost3d, totalChoice, budget)

%%outputs
%-- b1 = list of benefits (start from beginning, every block of "totalChoice" number of elements represent benefit values of all choices at one location)
%-- c1 = list of costs (in the same order)
%-- b = budget (cost constraint)
%-- aeq = equlity constraint (A in A*x=beq), used to make sure each location
%only has one choice
%-- beq = a list of all ones (beq in A*x=beq), used to make sure each location
%only has one choice
%ctype = used by cplex solver (from ampl, or you can use ampl or cplex for matlab, depending on which license you have), making sure all decision variables have only
%binary values

dim = size(r,1);
b1 = zeros(1, dim*totalChoice);
c1 = zeros(1, dim*totalChoice);

for t = 1:dim
    x0 = r(t,1);
    y0 = r(t,2);
    x1 = r(t,3);
    y1 = r(t,4);
    for k = 1:totalChoice
        id = (t-1)*totalChoice + k;
        for i = x0:x1
            for j = y0:y1
                b1(id) = b1(id) + benefit3d(i,j,k);%for solver used for minimization, negate this
                c1(id) = c1(id) + cost3d(i,j,k);
            end
        end
    end
end

vi = zeros(dim*totalChoice,1);
vj = zeros(dim*totalChoice,1);
vk = ones(dim*totalChoice,1);
for i = 1:(dim)
    base = (i-1)*totalChoice;
    vi(base+1:base+totalChoice) = i;
end
for i = 1:(dim)
    base = (i-1)*totalChoice;
    for j = 1:totalChoice
        vj(base+j) = base+j;
    end
end
aeq = sparse(vi,vj,vk);


b=[budget];
beq = ones(dim,1);
ctype(1:dim*totalChoice) = 'B';