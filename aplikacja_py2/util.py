def filter(x, y, allowed):
    new_x = []
    new_y = []
    for i in range(len(y)):
        if y[i] in allowed:
            new_x.append(x[i])
            new_y.append(y[i])
    return new_x, binarizer(new_y)


def binarizer(l):
    s=sorted(set(l))
    return map(lambda n:s.index(n), l)
