function q_int = quat_slerp(q0, q1, steps)
    theta = acos(q0 * q1');
    if (theta > pi)
        theta = 2 * pi - theta;
    end
    
    t = (0 : 1 / (steps - 1) : 1)';
    q_int = sin((1 - t) * theta) / sin(theta) * q0 + sin(t * theta) / sin(theta) * q1;
end