function Y0=PCNN(matrix,link_arrange,np)
% matrix is the input image
% np fault number is 300
% link_arrange fault is 13.0
alpha_L=1.0;
alpha_Theta=5.0;
beta=6;
vL=0.2;
vTheta=20;
[p, q] = size(matrix);
% Generate the null matrix that could be used
L=zeros(p,q);
U=zeros(p,q);
Y=zeros(p,q);
Y0=zeros(p,q);
E=ones(p,q);

% Compute the linking strength.
center_x=round(link_arrange/2);
center_y=round(link_arrange/2);
W=zeros(link_arrange,link_arrange);
for i=1:link_arrange
    for j=1:link_arrange
        if (i==center_x)&&(j==center_y)
            W(i,j)=1;
        else
            W(i,j)=1./sqrt((i-center_x).^2+(j-center_y).^2);
        end
    end
end
%%
F=double(matrix);

for i=1:np
    work = conv2(Y,W,'same');

    L = exp( -1 / alpha_L) * L + vL * work;
    for row=1:p
        for col=1:q
           if Y(row,col) == 0
               E(row,col) = exp( -1 / alpha_Theta) * E(row,col);
           else
               E(row,col) = vTheta;
           end
        end
    end

    U = F .* (1 + beta * L);


    for row=1:p
        for col=1:q
           if U(row,col) > E(row,col)
               Y(row,col) = 1;
           else
               Y(row,col) = 0;
           end
        end
    end
    
Y0 = Y0 + Y;
end
    
end



