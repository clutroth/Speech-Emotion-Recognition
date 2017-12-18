#!/usr/bin/python
# -*- coding: utf-8 -*-import csv

import numpy as np
from mlxtend.feature_selection import SequentialFeatureSelector
from sklearn.decomposition import PCA
from sklearn.mixture import GaussianMixture
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import scale
from sklearn.svm import SVC

from itertools import combinations


import agh
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
classificators = {
    'knn': KNeighborsClassifier(n_neighbors=len(bunch.target_names)),
    'gmm': GaussianMixture(n_components=len(bunch.target_names), covariance_type='full'), # dla czego uczy jedną iterację?
    'svm': SVC()
}
classificator = classificators[0]
pairs = combinations(range(7), 2)
selectors = {
    'sfs': SequentialFeatureSelector(classificators,
               k_features=20,
               forward=True,
               floating=False,
               scoring='accuracy',
               cv=4,
               n_jobs=-1),
    'pca': PCA()
}
selector = selectors[0]
selector = selector.fit(X_train, y_train)

X_train_sfs = selector.transform(X_train)
X_test_sfs = selector.transform(X_test)

# Fit the estimator using the new feature subset
# and make a prediction on the test data
classificator.fit(X_train_sfs, y_train)
y_pred = classificator.predict(X_test_sfs)
# Compute the accuracy of the prediction
acc = float((y_test == y_pred).sum()) / y_pred.shape[0]
