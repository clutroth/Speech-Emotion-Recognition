from pylatex import Tabular
import numpy as np


def generate_table((columns, rows), data, corner=''):
    table_schema = '|l' + '|c' * len(columns) + '|'
    table = Tabular(table_schema)
    table.add_hline()
    table.add_row([corner] + columns)
    table.add_hline()
    for n in range(len(rows)):
        table.add_row([rows[n]] + data[n])
        table.add_hline()
    return table


def saveLatex(obj, filename):
    with open(filename, "wb") as f:
        f.write(obj.dumps())

# rows and columns are swapped
def map_to_table(m):
    column_set = set()
    row_set = set()
    for column_, row_ in m.keys():
        column_set.add(column_)
        row_set.add(row_)
    column_list = list(column_set)
    row_list = list(row_set)
    data = np.empty((len(column_set), len(row_set))).tolist()
    for ((column_, row_), value) in m.items():
        idx1 = column_list.index(column_)
        idx2 = row_list.index(row_)
        data[idx1][idx2] = m[(column_, row_)]
    return (column_list, row_list), data
