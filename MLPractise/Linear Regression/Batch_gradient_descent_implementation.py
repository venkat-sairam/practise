import numpy as np
from sklearn.datasets import load_diabetes
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score
from sklearn.model_selection import train_test_split

class Batch_Gradient_Descent_Implementation:

    def __init__(self, learning_rate=0.01, epochs=100) -> None:
        """
        Initialize the Batch Gradient Descent implementation.

        Parameters:
        learning_rate : float, default=0.01
            Learning rate for gradient descent.
        epochs : int, default=100
            Number of iterations (epochs) to train the model.
        """
        self.intercept = 0
        self.coef_ = 0
        self.learning_rate = learning_rate
        self.epochs = epochs

    def fit(self, X, y):
        """
        Fit the linear regression model using Batch Gradient Descent.

        Parameters:
        X : numpy array, shape (n_samples, n_features)
            Training data.
        y : numpy array, shape (n_samples,)
            Target values.

        Updates self.intercept and self.coef_ with the fitted values.
        """
        self.intercept = 0
        self.coef_ = np.ones(X.shape[1])

        print("shape of co-efficient matrix:}", self.coef_.shape)
        print("Shape of X_train: ", X.shape)

        for epoch in range(self.epochs):

            if X.shape[1] != self.coef_.shape[0]:
                raise ValueError(" coefficients matrix shape is not matching with the number of features in the training data ")
            
            # Predictions with current coefficients
            y_hat = self.intercept + np.dot(X, self.coef_)

            # Gradient of intercept
            gradient_of_intercept = -2 * np.mean(y - y_hat)
            self.intercept = self.intercept - (self.learning_rate * gradient_of_intercept)


            # Gradient of coefficients            
            gradient_of_coef = -2 * np.dot(y - y_hat, X) / X.shape[0]
            self.coef_ = self.coef_ - (self.learning_rate * gradient_of_coef)

    def predict(self, X_test):
        """
        Predict using the fitted linear model.

        Parameters:
        X_test : numpy array, shape (n_samples, n_features)
            Test data.

        Returns:
        predictions : numpy array, shape (n_samples,)
            Predicted target values for X_test.
        """
        check_matrices_size = X_test.shape[1] == self.coef_.shape[0]
        if not check_matrices_size:
            raise ValueError("Test data shape is not matching with the number of features in the trained data ")

        return np.dot(X_test, self.coef_) + self.intercept


if __name__ == '__main__':
    # Load diabetes dataset
    X, y = load_diabetes(return_X_y=True)

    # Split data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.22, random_state=2)

    # Create an instance of Batch_Gradient_Descent_Implementation
    obj = Batch_Gradient_Descent_Implementation(learning_rate=0.98, epochs=100000)

    # Fit the model on the training data
    obj.fit(X=X_train, y=y_train)

    # Make predictions on the test data
    predictions = obj.predict(X_test)

    # Calculate R-squared score
    r2 = r2_score(y_test, predictions)
    print("R-squared score:", r2)
