function [class] = vect2class(vect)
    if vect(1) > vect(2)
        class = 1;
    else
        class = 2;
    end
end

