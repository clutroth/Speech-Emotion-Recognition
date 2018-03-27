#!/usr/bin/python
# -*- coding: utf-8 -*-import csv
import csv
from itertools import product, combinations, groupby

import numpy
from numpy.ma import mean
from sklearn.decomposition import PCA
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis, QuadraticDiscriminantAnalysis
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from sklearn.feature_selection import SelectKBest, RFE, RFECV
from sklearn.gaussian_process import GaussianProcessClassifier
from sklearn.gaussian_process.kernels import RBF
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import GaussianNB
from sklearn.neighbors import KNeighborsClassifier
from sklearn.neural_network import MLPClassifier
from sklearn.preprocessing import scale
from sklearn.svm import SVC, SVR
from sklearn.tree import DecisionTreeClassifier

import agh
from util import filter


class FeaturesList:
    def __init__(self, features, excpected):
        self.features = features
        self.excpected = excpected


bunch = agh.load_file('features_analysis-cc.csv')
X = bunch.data
y = bunch.target
X_scaled = scale(X)
featuresList = FeaturesList(X_scaled, y)
classificators = {
    'knn': KNeighborsClassifier(5),
    'lsvc': SVC(kernel="linear", C=0.025),
    # 'svc': SVC(gamma=2, C=1),
    # 'gpc': GaussianProcessClassifier(1.0 * RBF(1.0)),
    # 'dtc': DecisionTreeClassifier(max_depth=5),
    # 'rfc': RandomForestClassifier(max_depth=5, n_estimators=10, max_features=1),
    'mlp': MLPClassifier(alpha=.1, max_iter=200),
    # 'ad': AdaBoostClassifier(),
    # 'gnb': GaussianNB(),
    # 'qda': QuadraticDiscriminantAnalysis()
}
selectors = {
    # 'kbest': SelectKBest(k=10),
    'rfe': RFECV(SVR(kernel="linear"), 5, n_jobs=-1),
    # 'lda': LinearDiscriminantAnalysis(),
    'pca': PCA()
}

pairS = {
    'seven': combinations(range(7), 7),
    'two': combinations(range(7), 2)
}


def clasification_stats(rows):
    bySelectorAndClas = groupby(rows, lambda x: (x[0], x[1]))
    for ((classifier, selector), row) in bySelectorAndClas:
        print("for %s and %s: %f" % (classifier, selector, numpy.mean(map(lambda x: x[2], row))))


clasificationResults = {
    'seven': [],
    'two': []
}

for (classification_type, pairs) in pairS.items():
    all_product = product(classificators.items(), selectors.items(), pairs)

    for [(c_name, classifier), (s_name, selector), emotions] in all_product:
        print [classification_type,c_name, s_name,emotions]
        [filteredX, filteredY] = filter(featuresList.features, featuresList.excpected, emotions)
        X_train, X_test, y_train, y_test = train_test_split(
            filteredX, filteredY, test_size=0.33, random_state=1)
        selector = selector.fit(X_train, y_train)
        X_train_reduced = selector.transform(X_train)
        X_test_reduced = selector.transform(X_test)
        classifier.fit(X_train_reduced, y_train)
        y_pred = classifier.predict(X_test_reduced)
        result = {
            'classifier': c_name,
            'selector': s_name,
            'emotions': emotions,
            'emotion_names': [name for idx, name in enumerate(bunch.target_names) if idx in emotions],
            'expected': y_test,
            'predicted': y_pred.tolist()
        }
        print (result)
        clasificationResults[classification_type].append(result)
        # Compute the accuracy of the prediction
    # acc = float((y_test == y_pred).sum()) / y_pred.shape[0]
    # rows.append([
    # c_name, s_name, 100.0 * acc] + list(emotions))
print('encoding json')
import json

with open('classification.json', 'w') as outfile:
    json.dump(clasificationResults, outfile)
# clasification_stats(rows)
# with open("cross_classification.csv", "wb") as file:
#     writer = csv.writer(file)
#     writer.writerow(['klasyfikator', 'selektor', 'emocja1', 'emocja2', 'celność'])
#     for row in rows:
#         writer.writerow(row)
