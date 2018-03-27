# -*- coding: utf-8 -*-
import json
from itertools import product, combinations

from emo.prezentation import saveLatex, generate_table, map_to_table
import numpy as np

def uppercaser(names):
    translatees = {
        "pca": "PCA",
        "rfe": "RFE",
        "knn": "KNN",
        "mlp": "MLP",
        "lsvc": "LSVC",
    }
    def up(key):
        if key in translatees:
            return translatees[key]
        else:
            return key
    return map(up, names)

def save_latex_table(filename, left_corner, data_structure):
    (rows, columns), data = map_to_table(data_structure)
    turncatedData = [[("%.1f" % v) if isinstance(v, float) else v for v in r] for r in data]
    saveLatex(
        generate_table((uppercaser(columns), uppercaser(rows)), turncatedData, left_corner),
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
save_latex_table('share/accuaricy_c_s_table.tex', 'otrzymane\\spodziewane', r)

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
save_latex_table('share/classification_pca_mpl_table.tex', 'otrzymane\\spodziewane', r)
accuaricyMatrix = [[1] * 7] * 7
saveLatex(
    generate_table((emotions, emotions), accuaricyMatrix, 'otrzymane\\spodziewane'),
    'share/accuaricy_table.tex'
)
def unspace(str):
    return str.replace(" ", "-")
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
    save_latex_table('share/accuaricy_'+unspace(emotions[e1])+'_'+unspace(emotions[e2])+'_table.tex', 'klasyfikator\\reduktor', r_emotions[frozenset([e1, e2])])

