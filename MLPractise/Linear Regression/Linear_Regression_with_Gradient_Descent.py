import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
from sklearn.datasets import load_wine


class Linear_Regression_with_GD:
    def __init__(self, lr=0.01, epochs=1000):
        self.lr = lr
        self.epochs = epochs
        self.m = 0  # Initialize slope to 0
        self.b = 0  # Initialize intercept to 0

    def fit(self, X, y):
        # Ensure X and y are numpy arrays
        X = np.array(X)
        y = np.array(y)

        # Check if X and y have the same number of samples
        if X.shape[0] != y.shape[0]:
            raise ValueError("X and y must have the same number of elements")

        for i in range(self.epochs):
            y_pred = self.m * X + self.b

            # Calculate loss slopes
            loss_slope_b = -2 * np.sum(y - y_pred)
            loss_slope_m = -2 * np.dot((y - y_pred), X)

            # Update weights
            self.b = self.b - (self.lr * loss_slope_b)
            self.m = self.m - (self.lr * loss_slope_m)

    def predict(self, X):
        return  self.m * X + self.b

    def create_model(self, X_train, X_test, y_train, y_test):
        self.fit(X_train, y_train)
        predictions = self.predict(X_test)
        return r2_score(predictions, y_test)


if __name__ == '__main__':
    ref = Linear_Regression_with_GD(lr=0.01, epochs=100)
    X, y = load_wine(return_X_y=True)
    X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.25, random_state=123)

    print("R2 Score: ", ref.create_model(X_train, X_test, y_train, y_test))
