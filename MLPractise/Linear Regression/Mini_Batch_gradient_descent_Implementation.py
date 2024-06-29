
import numpy as np
from sklearn.datasets import load_diabetes
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score
from sklearn.model_selection import train_test_split
from random import sample

class Mini_Batch_Gradient_Descent_Implementation(object):

    def __init__(self, learning_rate=0.01, epochs=100, batch_size=10):
        self.learning_rate = learning_rate
        self.epochs = epochs
        self.batch_size = batch_size
        self.coefficients_ = None
        self.intercept_ = None

    def fit(self, X, y):
        self.intercept_ = 0
        self.coefficients_ = np.ones(X.shape[1])

        for i in range(self.epochs):

            for j in range(int(X.shape[0]/self.batch_size)):

                indices = sample(range(X.shape[0]), self.batch_size)

                y_hat = self.intercept_ + np.dot(X[indices], self.coefficients_)

                gradient_of_intercepts = -2 * np.mean(y[indices]-y_hat)
                self.intercept_ = self.intercept_ - (self.learning_rate * gradient_of_intercepts)

                gradient_of_coefficients = -2 * np.dot((y[indices] - y_hat), X[indices])

                self.coefficients_ = self.coefficients_ - (self.learning_rate * gradient_of_coefficients)

    
    def predict(self,X_test):
        return np.dot(X_test,self.coefficients_) + self.intercept_
    
if __name__ == '__main__':


    X, y = load_diabetes(return_X_y=True)

    # Split data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.22, random_state=2)

    obj = Mini_Batch_Gradient_Descent_Implementation(learning_rate=0.02, epochs=100, batch_size=15)
    # Fit the model on the training data
    obj.fit(X=X_train, y=y_train)

    # Make predictions on the test data
    predictions = obj.predict(X_test)

    # Calculate R-squared score
    r2 = r2_score(y_test, predictions)
    print("R-squared score:", r2)

