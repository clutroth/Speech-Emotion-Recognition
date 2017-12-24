class NoSelector:
    def __init__(self):
        self.k_feature_idx_ = ('wszystkie',)
    def transform(self, x):
        return x
    def fit(self, a, b):
        return self