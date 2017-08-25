
load('encoded_values.mat')
load('data.mat')

fprintf('\n The pretrained hmm modules will be loaded ')

for i = 2:5
    
    str = strcat('hmm_models_',num2str(i),'.mat');
    load(str)
    acc(i-1) = test_module(encoded_test,label_test,hmm_model,i);
    
end

figure;
title('Performace on test dataset')
plot(2:5,acc)
xlabel('number of states')
ylabel('acc')

