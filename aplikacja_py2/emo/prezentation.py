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
    row_set = set()
    column_set = set()
    for row, column in m.keys():
        row_set.add(row)
        column_set.add(column)
    row_list = list(row_set)
    column_list = list(column_set)
    data = np.empty((len(row_set), len(column_set))).tolist()
    for ((row, column), value) in m.items():
        idx1 = row_list.index(row)
        idx2 = column_list.index(column)
        data[idx1][idx2] = m[(row, column)]
    return (row_list, column_list), data
