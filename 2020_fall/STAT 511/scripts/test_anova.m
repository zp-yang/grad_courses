function test_anova(y_cell)
    I = length(y_cell); % population/Group
    y = [];
    J = [];
    g = {};
    for i = 1:I
        y = [y y_cell{i}];
        Ji = length(y_cell{i});
        J = [J Ji];

        if i ~= 1
            s = e+1;
        else
            s = 1;
        end
        e = s+J(i)-1;
        for k = s:e
            g{k} = char(i+64);
        end
    end

    n = length(y);
    anova1(y,g);
end