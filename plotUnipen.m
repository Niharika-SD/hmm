function plotUnipen(data)
    ind = find(data(1,:) == -1);
    indDown = ind(find(data(2,ind) == 1));
    indUp   = ind(find(data(2,ind) == -1));
    old_hold = ishold;
    hold on;
    h = plot(data(1, indDown(1) + 1:indUp(1) -1), data(2, indDown(1) + 1:indUp(1) -1));
    for i = 2:length(indDown)
        h1 = plot(data(1, indDown(i) + 1:indUp(i) -1), data(2, indDown(i) + 1:indUp(i) -1));
        h1.Color = h.Color;
    end;
    if ~old_hold, hold off; end
end
