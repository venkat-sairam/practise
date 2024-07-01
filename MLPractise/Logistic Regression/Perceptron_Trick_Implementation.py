import numpy as np
from sklearn.datasets import make_classification
import matplotlib.pyplot as plt

X, y = make_classification(
    n_samples=100,
    n_features=2,
    n_informative=1,
    n_redundant=0,
    n_classes=2,
    n_clusters_per_class=1,
    random_state=41,
    hypercube=False,
    class_sep=10,
)

class Perceptron_Impl(object):

    def __init__(self) -> None:
        self.epochs = 1000
        self.weights = None
        self.bias = None
        self.learning_rate = 0.01

    def step(self, z):

        return 1 if z >0 else 0

    def fit(self, X, y):

        self.bias = 0
        X = np.insert(X, 0, 1, axis=1)
        self.weights = np.ones(X.shape[1])
        print(f"shape of X: {X.shape}")
        print(f"shape of weights: {self.weights.shape}")

        for i in range(self.epochs):
            j = np.random.randint(0, 100)
            y_hat = self.step(
                np.dot(
                    self.weights, X[j]
                )
            )
            self.weights = self.weights + self.learning_rate * (y[j] - y_hat) * X[j]
        self.bias = self.weights[0]
        self.weights = self.weights[1:]

        return self.bias, self.weights

if __name__ == '__main__':
    p = Perceptron_Impl()
    intercept, coefficients = p.fit(X, y)

    print(f"Intercept: {intercept}")
    print(f"Coefficients: {coefficients}")

    m = -(coefficients[0] / coefficients[1])
    b = -(intercept / coefficients[1])

    x_input = np.linspace(-3, 3, 100)
    y_input = m * x_input + b

    plt.figure(figsize=(10, 6))
    plt.plot(x_input, y_input, color="red", linewidth=3)
    plt.scatter(X[:, 0], X[:, 1], c=y, cmap="winter", s=100)
    plt.ylim(-3, 2)
