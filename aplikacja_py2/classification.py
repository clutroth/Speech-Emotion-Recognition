#!/usr/bin/python
# -*- coding: utf-8 -*-import csv
import random
from itertools import product, combinations, groupby

import numpy
from sklearn.decomposition import PCA
from sklearn.feature_selection import RFECV
from sklearn.model_selection import train_test_split, StratifiedKFold
from sklearn.neighbors import KNeighborsClassifier
from sklearn.neural_network import MLPClassifier
from sklearn.preprocessing import scale
from sklearn.svm import SVC

import agh
from emo.stage import selectorInfo
from util import filter


class FeaturesList:
    def __init__(self, features, expected, feature_names):
        self.features = features
        self.expected = expected
        self.feature_names = feature_names


random_state = 2420522089
# random_state = random.randint(0,7654567877)
bunch = agh.load_file('features_analysis-cc.csv')
X = bunch.data
y = bunch.target
X_scaled = scale(X)
featuresList = FeaturesList(X_scaled, y, bunch.feature_names)
cv = StratifiedKFold(10, random_state=random_state)
classificators = {
    'knn': KNeighborsClassifier(5),
    'lsvc': SVC(kernel="linear", C=.025, random_state = random_state),
    'mlp': MLPClassifier(activation='tanh', solver='lbfgs', random_state = random_state),
}
selectors = {
    'rfe': RFECV(SVC(kernel="linear", C=.025, random_state=random_state), cv=cv, step=.02, n_jobs=-1),
    'pca': PCA(n_components=0.98, svd_solver='full', random_state = random_state)
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
        [filteredX, filteredY] = filter(featuresList.features, featuresList.expected, emotions)
        X_train, X_test, y_train, y_test = train_test_split(
            filteredX, filteredY, test_size=0.25, random_state=random_state)
        fittedSelector = selector.fit(X_train, y_train)
        X_train_reduced = fittedSelector.transform(X_train)
        X_test_reduced = fittedSelector.transform(X_test)
        classifier.fit(X_train_reduced, y_train)
        y_pred = classifier.predict(X_test_reduced)
        result = {
            'classifier': c_name,
            'selector': s_name,
            'emotions': emotions,
            'emotion_names': [name for idx, name in enumerate(bunch.target_names) if idx in emotions],
            'expected': y_test,
            'selector_info': selectorInfo(selector),
            'predicted': y_pred.tolist()
        }
        print (result)
        clasificationResults[classification_type].append(result)

print('encoding json')
import json
with open('classification.json', 'w') as outfile:
    json.dump(clasificationResults, outfile)

# c = clasificationResults['seven'][2]
# correct=0
# at_all=0
# for n in range(len(c['predicted'])):
#     if c['predicted'][n] == c['expected'][n]:
#         correct += 1
# with open("results.txt", "a") as myfile:
#     myfile.write( "%d\t%f\n"%(random_state,float(correct)/len(c['predicted'])))
