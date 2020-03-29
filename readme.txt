If you use our method, please cite our article: V. Uslan, H. Seker and R. John, "Overlapping Clusters and Support Vector Machines Based Interval Type-2 Fuzzy System for the Prediction of Peptide Binding Affinity," in IEEE Access, vol. 7, pp. 49756-49764, 2019.
https://ieeexplore.ieee.org/abstract/document/8685099

prepdata.m: sets the taskno, the parameters and data path of the given task.
main.m: train/test process for the proposed method.

/data: contains the data and selected features to be used during the train/test process.
/mex: library for support vector machines (libsvm).
/it2/ca.m: cluster analysis.
/it2/overlap.m: determining the lowerMF parameters using overlaping clusters.
/it2/trainfsvm2.m: training the support vector based interval type-2 fuzzy system.
/it2/predictfsvm2.m: predicting the responses.
/assess/findq2.m: evaluating the performance using q2 metric.
/assess/findsp.m: evaluating the performance using Spearman metric.

