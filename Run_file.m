%%  Test functions
clear all
close all

filename_train = 'pendigits-orig.tra';
filename_test = 'pendigits-orig.tes';

% Reading the data
[data_train,label_train] = loadUnipenData(filename_train);
[data_test,label_test] = loadUnipenData(filename_test);

% Some test plots 

figure;
title('Example plot')
plotUnipen(data_train{1});
plotUnipen(data_test{1});

%% Normalising the data and interpolating 

norm_data_train = data_train;
norm_data_test = data_test;

train_set =[];
ct_train = zeros(size(data_train,2),1);
test_set =[];
ct_test = zeros(size(data_test,2),1);

for i = 1: size(data_train,2)
    norm_data_train{i} = normalise_unipen(data_train{i});
    train_set = vertcat(train_set,norm_data_train{i}');
    ct_train(i) = size(norm_data_train{i},2);
end

for i = 1: size(data_test,2)
    norm_data_test{i} = normalise_unipen(data_test{i});
    test_set = vertcat(test_set,norm_data_test{i}');
    ct_test(i) = size(norm_data_test{i},2);
end

%% K means and encoding

[ind_train, cent_train] = kmeans(train_set,256,'MaxIter',1000);
save('codebook.mat','ind_train','cent_train')

% encode the training data
count  =1 ;
encoded_train ={};

for i = 1:size(data_train,2)
    encoded_train{i} = ind_train(count:count + ct_train(i)-1)';
    count = count + ct_train(i);
end

% encoding the test data

count  =1 ;
encoded_test ={};

codebook = KDTreeSearcher(cent_train);
ind_test = knnsearch(codebook,test_set);

for i = 1:size(data_test,2)
    encoded_test{i} = ind_test(count:count + ct_test(i)-1)';
    count = count + ct_test(i);
end

save('encoded_values.mat','encoded_train','encoded_test')
%% HMM training 

%Initial conditions
n_states =3;

for i= 0:9
    
    seq ={};
    idx = find(label_train==i);
    TPM_guess = rand([n_states,n_states]) ;
    TPM_guess = mk_stochastic(TPM_guess);

    EM_guess = rand([n_states,256]);   
    EM_guess = mk_stochastic(EM_guess);
    
    for j = 1:size(idx,2)
        seq{j}(:,:) = encoded_train{idx(j)};
    end
    
    [hmm_model{i+1}.TPM,hmm_model{i+1}.EMM] = hmmtrain(seq,TPM_guess,EM_guess,'MAXITERATIONS',1000);
    
end

save('hmm_models.mat','hmm_model')
%% HMM prediction

acc = 0;
for i  = 1:size(data_test,2)
    
    log_prob = zeros([10,1]);
    test_seq =  encoded_test{i};
    
    for j = 1:10
       [~,logpseq] = hmmdecode2(test_seq,hmm_model{j}.TPM,hmm_model{j}.EMM); 
       log_prob(j) = logpseq;
    end
    
    ind_max = find(log_prob == max(log_prob));
    
    if (ind_max == label_test(i)+1)
        acc = acc+1;
    end
end

fprintf('%f',acc/size(data_test,2))