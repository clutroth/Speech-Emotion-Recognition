from pylatex import Tabular


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