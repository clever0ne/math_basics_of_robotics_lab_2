function [ax, ang] = rotm_to_ax_ang(r)
    tr = r(1, 1, :) + r(2, 2, :) + r(3, 3, :);
    ang = acos((tr - 1) / 2);
    ax = [r(3, 2, :) - r(2, 3, :), ...
          r(1, 3, :) - r(3, 1, :), ...
          r(2, 1, :) - r(1, 2, :)] ./ (2 * sin(ang));
      
    ax = reshape(ax, 3, size(r, 3))';
    ang = reshape(ang, size(r, 3), 1);
    
    for idx = 1 : size(tr, 3)
        if (tr == 3)
            ax(idx, :) = [0, 0, 1];
            ang(idx) = 0;
        end
        
        if (tr == -1)
            if ((r(1, 1, idx) > r(2, 2, idx)) && (r(1, 1, idx) > r(3, 3, idx)))
                ax = [r(1, 1, idx) + 1, r(1, 2, idx), r(1, 3, idx)];
            elseif (r(2, 2, idx) > r(3, 3, idx))
                ax = [r(2, 1, idx), r(2, 2, idx) + 1, r(2, 3, idx)];
            else
                ax = [r(3, 1, idx), r(3, 2, idx), r(3, 3, idx) + 1];
            end
            ax = ax / norm(ax);
            ang(idx) = pi;
        end
    end
end
