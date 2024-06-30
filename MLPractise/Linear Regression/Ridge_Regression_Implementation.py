import numpy as np


class Ridge_Regression_Implementation(object):

    def __init__(self, alpha=0.01):
        """
        Initialize Ridge regression model.

        Parameters:
        - alpha : float, optional, default 0.01
            Regularization strength; must be a positive float.
            Larger values specify stronger regularization.

        Attributes:
        - alpha : float
            Regularization strength.
        - coefficients_ : numpy.ndarray, shape (n_features,)
            Coefficients of the linear regression model (excluding intercept).
        - intercept_ : float
            Intercept (bias) added to the model.
        """
        self.alpha = alpha
        self.coefficients_ = None
        self.intercept_ = None

    def fit(self, X, y):
        """
        Fit Ridge regression model to the training data.

        Parameters:
        - X : numpy.ndarray, shape (n_samples, n_features)
            Training data.
        - y : numpy.ndarray, shape (n_samples,)
            Target values.

        Raises:
        - ValueError: If X and y have incompatible shapes.
        - ValueError: If dimensions of matrices are not appropriate for multiplication.

        Notes:
        - This method modifies the state of the object by setting self.coefficients_
          and self.intercept_ attributes.
        """
        if X.shape[0] != y.shape[0]:
            raise ValueError("X and y must have the same number of samples.")

        X = np.insert(X, 0, 1, axis=1)  # Add bias column
        n_samples, n_features = X.shape
        I = np.identity(n_features)

        # Check for positive alpha value
        if self.alpha <= 0:
            raise ValueError("alpha must be positive.")

        # Check dimensions before dot product computations
        if X.shape[0] != y.shape[0]:
            raise ValueError("Number of samples in X and y must be equal.")
        if X.shape[1] != len(y):
            raise ValueError(
                "Number of features in X must equal number of samples in y."
            )

        try:
            first = (X.T).dot(X) + self.alpha * I
            second = X.T.dot(y)
            self.betas = np.linalg.inv(first).dot(second)
            self.intercept_ = self.betas[0]
            self.coefficients_ = self.betas[1:]
        except np.linalg.LinAlgError as e:
            raise ValueError("Matrix inversion failed. Ensure X is full rank.") from e

    def predict(self, x_test):
        """
        Predict using the Ridge regression model.

        Parameters:
        - x_test : numpy.ndarray, shape (n_samples, n_features)
            Test data.

        Returns:
        - predictions : numpy.ndarray, shape (n_samples,)
            Predicted target values.
        """
        if self.coefficients_ is None or self.intercept_ is None:
            raise RuntimeError("Model has not been fitted yet. Call fit() first.")

        if x_test.shape[1] != len(self.coefficients_):
            raise ValueError(
                "Number of features in x_test must match number of coefficients."
            )

        return np.dot(x_test, self.coefficients_) + self.intercept_
