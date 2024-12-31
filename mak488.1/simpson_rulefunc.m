function integral = simpson_rule(f, a, b, n)
    % f: Function to integrate
    % a: Lower bound of the interval
    % b: Upper bound of the interval
    % n: Number of subintervals (should be even)

    if mod(n, 2) ~= 0
        error('Number of subintervals (n) should be even.');
    end

    h = (b - a) / n;  % Width of each subinterval
    x = a:h:b;        % Generate the points within the interval

    % Calculate the integral using Simpson's rule
    integral = (h / 3) * (f(x(1)) + f(x(end)) + 4 * sum(f(x(2:2:end-1))) + 2 * sum(f(x(3:2:end-2))));
end