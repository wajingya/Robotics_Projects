function [min_G] = Comparing_G_function(old_G,new_G)
%  Comparing old G value and the new G value
%  Input:old_G and new_G

if old_G<=new_G
    min_G=old_G;
else
    min_G=new_G;
end

end

