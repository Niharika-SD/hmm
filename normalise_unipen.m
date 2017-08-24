function example_norm =  normalise_unipen(example)
%%Takes input as the x,y grid of digit values and normalises and interpolates the data 

mean_x = mean(example(1,2:end-1));
var_x = var(example(1,2:end-1));

mean_y = mean(example(2,2:end-1));
var_y = var(example(2,2:end-1));

[m,n] = size(example);
example_norm = zeros(m,n-2);

example_norm(1,:) = (example(1,2:end-1)-mean_x)/sqrt(var_x) ;
example_norm(2,:) = (example(2,2:end-1)-mean_y)/sqrt(var_y) ;

% ex_int = zeros(2,128);
% n1 = n-2;
% n2 = 128;
% 
% j=2;
% 
% ex_int(:,1) = example_norm(:,1);
% ex_int(:,end) = example_norm(:,end);
% 
% for i= 1:n2-1
%     
%     if i/127 > j/(n1-1)
%        j =j+1; 
%     end
%     ex_int(1,i) = example_norm(1,j-1)+ (i*(n-1)/(j*127))* (example_norm(1,j) - example_norm(1,j-1));
%     ex_int(2,i) = example_norm(2,j-1)+ (i*(n-1)/(j*127))* (example_norm(2,j) - example_norm(2,j-1));
% 
% end
end