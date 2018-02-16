# -*- coding: utf-8 -*-
import json
from itertools import product, combinations

from emo.prezentation import saveLatex, generate_table, map_to_table
import numpy as np


def save_latex_table(filename, left_corner, data_structure):
    (rows, columns), data = map_to_table(data_structure)
    saveLatex(
        generate_table((columns, rows), data, left_corner),
        filename
    )
def accuaricy(correctness_array):
    return float(correctness_array.sum()) / correctness_array.shape[0] * 100

emotions = ['irytacja', 'stan neutralny', 'radosc', 'smutek', 'strach', 'zdziwienie', 'zlosc']

data = json.load(open('classification.json'))


# accuracy of classifier and selector for seven emotions
# celność od klasyfikatora i selektora
r = {}
for classification in data['seven']:
    predicted = np.array(classification['predicted'])
    expected = np.array(classification['expected'])
    r[(classification['selector'], classification['classifier'])] = accuaricy(predicted == expected)
save_latex_table('share/accuaricy_c_s_table.tex', 'pred\\exp', r)

# accuracy of MLP and PCA for seven emotions
# liczba emocji rozpoznanych od oczekiwanych dla najlepszej pary klasyfikatora i selektora
r = {}
for p in product(emotions,emotions):
    r[p]=0
for classification in data['seven']:
    if classification['selector'] == 'pca' and classification['classifier'] == 'mlp':
        predicted = np.array(classification['predicted'])
        expected = np.array(classification['expected'])
        for n in range(expected.shape[0]):
            predicted_n = predicted[n]
            expected_n = expected[n]
            r[(emotions[predicted_n],emotions[expected_n])] += 1
save_latex_table('share/classification_pca_mpl_table.tex', 'pred\\exp', r)
accuaricyMatrix = [[1] * 7] * 7
saveLatex(
    generate_table((emotions, emotions), accuaricyMatrix, 'pred\\exp'),
    'share/accuaricy_table.tex'
)

# accuracy of MLP and PCA for seven emotions
r_emotions = {}
rle = range(len(emotions))
for (e1,e2) in combinations(rle, 2):
    r_emotions[frozenset([e1, e2])]={}
for classification in data['two']:
    e, c, s = classification['emotions'],classification['classifier'],classification['selector']
    accuaricy(np.array(classification['predicted']) == np.array(classification['expected']))
    r_emotions[frozenset(list(e))][(c, s)] = accuaricy(np.array(classification['predicted']) == np.array(classification['expected']))
for (e1, e2) in combinations(rle, 2):
    save_latex_table('share/accuaricy_'+emotions[e1]+'_'+emotions[e2]+'_table.tex', 'classifier\\selector', r_emotions[frozenset([e1, e2])])

