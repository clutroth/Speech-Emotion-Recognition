#!/usr/bin/python
# -*- coding: utf-8 -*-import csv

import numpy as np
from mlxtend.feature_selection import SequentialFeatureSelector as SFS
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import scale
from pylatex import Tabular, Document

import agh

bunch = agh.load_file('features_analysis-cc.csv')
X = bunch.data
y = bunch.target
X_scaled = scale(X)

# iris = load_iris()
# X = iris.data
# y = iris.target
X_train, X_test, y_train, y_test = train_test_split(
    X_scaled, y, test_size=0.33, random_state=1)

classificator = KNeighborsClassifier(n_neighbors=len(bunch.target_names))
# classificator = GaussianMixture(n_components=len(d.target_names), covariance_type='full')
# classificator=SVC()
# najlepsze wyniki dla KNN !!?

sfs1 = SFS(classificator,
           k_features=5,
           forward=True,
           floating=False,
           scoring='accuracy',
           cv=4,
           n_jobs=-1)
sfs1 = sfs1.fit(X_train, y_train)
print('Selected features:', sfs1.k_feature_idx_)

X_train_sfs = sfs1.transform(X_train)
X_test_sfs = sfs1.transform(X_test)

# Fit the estimator using the new feature subset
# and make a prediction on the test data
classificator.fit(X_train_sfs, y_train)
y_pred = classificator.predict(X_test_sfs)

# tabela skuteczności
accuaricyMatrix = np.zeros((len(bunch.target_names), len(bunch.target_names)), dtype=np.int64)
for n in range(len(y_pred)):
    accuaricyMatrix[y_pred[n], y_test[n]] += 1


# tabela-wstawka
def generate_table(names, data, corner=''):
    lists = data.tolist()
    table_schema = '|l' + '|c' * len(names) + '|'
    table = Tabular(table_schema)
    table.add_hline()
    table.add_row([corner] + names)
    table.add_hline()
    for n in range(len(names)):
        table.add_row([names[n]] + lists[n])
        table.add_hline()
    return table
def saveLatex(obj, filename):
    with open(filename, "wb") as f:
        f.write(obj.dumps())
emotions = ['irytacja','stan neutralny','radosc','smutek','strach','zdziwienie','zlosc']

saveLatex(
    generate_table(emotions, accuaricyMatrix,'pred\\exp'),
    'share/accuaricy_table.tex'
)

# Compute the accuracy of the prediction
acc = float((y_test == y_pred).sum()) / y_pred.shape[0]
print('Test set accuracy: %.2f %%' % (acc * 100))
