import numpy as np
from sklearn.datasets import load_diabetes
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score
from sklearn.model_selection import train_test_split

class Stochastic_Gradient_Descent_Implementation:

    def __init__(self, learning_rate = 0.01, epochs=10) -> None:
        self.coefficients_ = None
        self.intercept_ = None
        self.learning_rate_ = learning_rate
        self.epochs_ = epochs

    def fit(self, X, y):
        self.intercept_ = 0
        self.coefficients_ = np.ones(X.shape[1])

        for i in range(self.epochs_):
            for j in range(X.shape[0]):
                index = np.random.randint(low=0, high= X.shape[0])

                y_hat = self.intercept_ + np.dot(X[index], self.coefficients_)
                
                # gradient for intercept term
                gradient_of_intercept = -2 * (y[index] - y_hat)

                # calculate the intercept term using the gradient of intercept term
                self.intercept_ = self.intercept_ - (self.learning_rate_ * gradient_of_intercept)

                # gradient for coefficients
                gradient_of_coefficients = -2 *np.dot( (y[index]- y_hat), X[index])
                
                self.coefficients_ = self.coefficients_ - (self.learning_rate_ * gradient_of_coefficients)  

    def predict(self,X_test):
        return np.dot(X_test,self.coefficients_) + self.intercept_
    

if __name__ == '__main__':


    X, y = load_diabetes(return_X_y=True)

    # Split data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.22, random_state=2)

    obj = Stochastic_Gradient_Descent_Implementation(learning_rate=0.02, epochs=100)
    # Fit the model on the training data
    obj.fit(X=X_train, y=y_train)

    # Make predictions on the test data
    predictions = obj.predict(X_test)

    # Calculate R-squared score
    r2 = r2_score(y_test, predictions)
    print("R-squared score:", r2)