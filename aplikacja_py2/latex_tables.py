import json

from emo.prezentation import saveLatex, generate_table, map_to_table
import numpy as np


def save_latex_table(filename, left_corner, data_structure):
    (rows, columns), data = map_to_table(data_structure)
    saveLatex(
        generate_table((columns, rows), data, left_corner),
        filename
    )


data = json.load(open('classification.json'))


# accuracy of classifier and selector for seven emotions
r = {}
for classification in data['seven']:
    predicted = np.array(classification['predicted'])
    expected = np.array(classification['expected'])
    r[(classification['selector'], classification['classifier'])] = \
        float((predicted == expected).sum()) / expected.shape[0] * 100
filename = 'share/accuaricy_c_s_table.tex'
left_corner = 'pred\\exp'
save_latex_table(filename, left_corner, r)

# accuracy of MLP and PCA for seven emotions
r = {}
for c in data['seven']:
    if classification['selector'] is 'pca' and c['classifier'] is 'mlp':
        predicted = np.array(classification['predicted'])
        expected = np.array(classification['expected'])
        r[(classification['selector'], classification['classifier'])] = \
            float((predicted == expected).sum()) / expected.shape[0] * 100
filename = 'share/accuaricy_c_s_table.tex'
left_corner = 'pred\\exp'
save_latex_table(filename, left_corner, r)
emotions = ['irytacja', 'stan neutralny', 'radosc', 'smutek', 'strach', 'zdziwienie', 'zlosc']
accuaricyMatrix = [[1] * 7] * 7
saveLatex(
    generate_table((emotions, emotions), accuaricyMatrix, 'pred\\exp'),
    'share/accuaricy_table.tex'
)
