#!/usr/bin/python
# -*- coding: utf-8 -*-import csv

import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import scale
from sklearn.svm import SVC

import agh
from emo.NoSelector import NoSelector
from emo.prezentation import generate_table, saveLatex

bunch = agh.load_file('features_analysis-cc.csv')
X = bunch.data
y = bunch.target
X_scaled = scale(X)

# iris = load_iris()
# X = iris.data
# y = iris.target
X_train, X_test, y_train, y_test = train_test_split(
    X_scaled, y, test_size=0.33, random_state=1)

# classificator = KNeighborsClassifier(n_neighbors=len(bunch.target_names))
# classificator = GaussianMixture(n_components=len(bunch.target_names), covariance_type='full', verbose=True)
# classificator=BayesianGaussianMixture(n_components=len(bunch.target_names), covariance_type='spherical', verbose=True, n_init=10)
classificator=SVC(verbose=True)
# najlepsze wyniki dla KNN !!?
# selector = SFS(classificator,
#                k_features=20,
#                forward=True,
#                floating=False,
#                scoring='accuracy',
#                cv=4,
#                n_jobs=-1)
selector = NoSelector()
# selector = PCA()
selector = selector.fit(X_train, y_train)

X_train_sfs = selector.transform(X_train)
X_test_sfs = selector.transform(X_test)

# Fit the estimator using the new feature subset
# and make a prediction on the test data
classificator.fit(X_train_sfs, y_train)
y_pred = classificator.predict(X_test_sfs)
# Compute the accuracy of the prediction
acc = float((y_test == y_pred).sum()) / y_pred.shape[0]
print('Test set accuracy: %.2f %%' % (acc * 100))
# tabela skuteczności
accuaricyMatrix = np.zeros((len(bunch.target_names), len(bunch.target_names)), dtype=np.int64)
for n in range(len(y_pred)):
    accuaricyMatrix[y_pred[n], y_test[n]] += 1

emotions = ['irytacja','stan neutralny','radosc','smutek','strach','zdziwienie','zlosc']

saveLatex(
    generate_table(emotions, accuaricyMatrix, 'pred\\exp'),
    'share/accuaricy_table.tex'
)