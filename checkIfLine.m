function [ isLine, fpoint, tpoint ] = checkIfLine( I, x_1, y_1, x_2, y_2, stepSize, r, missesAllowed )
%CHECKIFLINE Summary of this function goes here
%   Detailed explanation goes here

s = size(I);

x(1) = x_1;
x(2) = x_1;
y(1) = y_1;
y(2) = y_1;
xhit = x_1;
yhit = y_1;

x_d(1) = x_2 - x_1;
y_d(1) = y_2 - y_1;

v = [x_d(1) y_d(1)] / norm([x_d(1) y_d(1)]);
alpha = atan2(v(2), v(1));
x_d(1) = v(1) * (stepSize*cos(alpha));
y_d(1) = v(2) * (stepSize*sin(alpha));
x_d_n = y_d(1);
y_d_n = -x_d(1);

isLine = 0;
misses = 0;
done = 0;

consMiss(2) = 0;

dir = 1;

while done == 0
    hit = 0;
    x(dir) = floor(x(dir) + x_d(dir));
    y(dir) = floor(y(dir) + y_d(dir));
    
    if x(dir) < 1 || x(dir) > s(2) || y(dir) < 1 || y(dir) > s(1)
        done = 1;
        continue;
    end
    
    if I(y(dir),x(dir)) == 0
        
        x_n_l = ceil(x(dir) + x_d_n);
        y_n_l = ceil(y(dir) + y_d_n);
        
        x_n_h = ceil(x(dir) - x_d_n);
        y_n_h = ceil(y(dir) - y_d_n);
        
        if (y_n_l >0) && (y_n_l < s(1)) && (x_n_l > 0) && (x_n_l < s(2))
        if I(y_n_l, x_n_l) == 1
            hit = 1;
        end
        end
        if y_n_h >0 && y_n_h < s(1) && x_n_h > 0 && x_n_h < s(2)
        if I(y_n_h, x_n_h) == 1
            hit = 1;
        end
        end
    else
        hit = 1;
    end
    
    if hit == 0
        misses = misses +1;
        
        if consMiss(dir) == 2
            done = 1;
        else
            consMiss(dir) = consMiss(dir) + 1;
        end
    else
        consMiss(dir) = 0;
        xhit = x(dir); yhit = y(dir);
    end
    
    if misses > missesAllowed
        done = 1;
        break;
    end
    
end

if sqrt((x(1)-x(2))^2 + (y(1)-y(2))^2) > r
    isLine = 1;
end

fpoint = [x(2);y(2)];
tpoint = [xhit;yhit];

end

