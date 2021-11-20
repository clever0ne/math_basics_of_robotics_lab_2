function q = ax_ang_to_quat(ax, ang)
    q = [cos(ang / 2), ax .* sin(ang / 2)];
end

