function example_norm =  normalise_unipen(example)
%%Takes input as the x,y grid of digit values and normalises and interpolates the data 

mean_x = mean(example(1,2:end-1));
var_x = var(example(1,2:end-1));

mean_y = mean(example(2,2:end-1));
var_y = var(example(2,2:end-1));

[m,n] = size(example);
example_norm = zeros(m,n-2);

%Discard end point data
example_norm(1,:) = (example(1,2:end-1)-mean_x)/sqrt(var_x) ;
example_norm(2,:) = (example(2,2:end-1)-mean_y)/sqrt(var_y) ;

end