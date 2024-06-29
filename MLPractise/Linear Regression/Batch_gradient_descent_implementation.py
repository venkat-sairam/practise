import numpy as np
from sklearn.datasets import load_diabetes
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score
from sklearn.model_selection import train_test_split

class Batch_Gradient_Descent_Implementation:

    def __init__(self, learning_rate = 0.01, epochs=100) -> None:
        
        self.intercept = 0
        self.coef_ = 0
        self.learning_rate = learning_rate
        self.epochs = epochs

    def fit(self, X, y):
        self.intercept = 0
        self.coef_ = np.ones(X.shape[1])

        for i in range(self.epochs):
            # update all the coefficients and intercept values:

            y_hat = self.intercept + np.dot(X, self.coef_)
            gradient_of_intercept = -2 * np.mean(y-y_hat)

            self.intercept = self.intercept - (self.learning_rate * gradient_of_intercept)

            gradient_of_coef = -2 * np.dot(y-y_hat, X)/ X.shape[0]

            self.coef_ = self.coef_ - (self.learning_rate * gradient_of_coef)

    def predict(self,X_test):
        return np.dot(X_test,self.coef_) + self.intercept



if __name__ == '__main__':
    X,y = load_diabetes(return_X_y=True)
    X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=0.22,random_state=2)

    obj = Batch_Gradient_Descent_Implementation(learning_rate=0.98, epochs=100000)
    obj.fit(X=X_train, y=y_train)
    predictions = obj.predict(X_test)

    print(r2_score(y_test, predictions))


    
