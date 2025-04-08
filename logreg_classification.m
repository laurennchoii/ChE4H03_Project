function [accuracy,precision,recall] = logreg_classification(T,Y)
B = glmfit(T, Y, 'binomial');
Y_prob = glmval(B, T, 'logit');

Y_pred = Y_prob > 0.5;

TP = sum((Y == 0) & (Y_pred == 0)); %True Positives
TN = sum((Y == 1) & (Y_pred == 1)); %True Negatives
FP = sum((Y == 1) & (Y_pred == 0)); %False Positives
FN = sum((Y == 0) & (Y_pred == 1)); %False Negatives

accuracy = (TP + TN) / length(Y);
precision = TP / (TP + FP);
recall = TP / (TP + FN);
% f1_score = 2 * (precision * recall) / (precision + recall);
end