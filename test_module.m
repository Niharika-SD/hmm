function acc = test_module(encoded_test,label_test,hmm_model,n_states)
%%given the pretrained hmm models for each class, takes the encoded test
%%data and computes the accuracy of classification 

acc = 0;
for i  = 1:size(encoded_test,2)
    
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
acc = acc/size(label_test,2);
fprintf('\n The accuracy with %d states is %f',n_states,acc)

end