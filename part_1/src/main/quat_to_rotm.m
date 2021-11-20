function r = quat_to_rotm(q)
    q = reshape(q', 4, 1, size(q, 1));
    qs = q(1, 1, :);
    qx = q(2, 1, :);
    qy = q(3, 1, :);
    qz = q(4, 1, :);
    r = [1-2*(qy.^2 + qz.^2), 2*(qx.*qy - qz.*qs), 2*(qx.*qz + qy.*qs);
         2*(qx.*qy + qz.*qs), 1-2*(qx.^2 + qz.^2), 2*(qy.*qz - qx.*qs);
         2*(qx.*qz - qy.*qs), 2*(qy.*qz + qx.*qs), 1-2*(qx.^2 + qy.^2)];
end

