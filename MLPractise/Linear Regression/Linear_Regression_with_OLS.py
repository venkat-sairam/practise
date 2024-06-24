from sklearn.model_selection import train_test_split
from sklearn.datasets import load_wine
import numpy as np
from sklearn.metrics import r2_score
from sklearn.linear_model import LinearRegression

class Linear_Regression_with_OLS:

    def __init__(self):
        self.coef_ = None
        self.intercept_ = None

    def fit(self, x_train, y_train):
        x_train = np.insert(x_train,0,1,axis=1)

        first = (x_train.T).dot(x_train)
        second= (x_train.T).dot(y_train)


        self.betas = np.linalg.inv(first).dot(second)

        self.intercept_ = self.betas[0]
        self.coef_ = self.betas[1:]  

    def predict(self, x_test):
        return np.dot( x_test, self.coef_)+ self.intercept_
    
    def create_and_predict_model(self, X_train, X_test, y_train, y_test):

        
        self.fit(X_train, y_train)
        predictions = self.predict(X_test)
        print("R2 Score of LR Model: ", round(r2_score(predictions, y_test) * 100, 2), "%")

    def use_LR(self, X_train, X_test, y_train, y_test):
        lr = LinearRegression()
        lr.fit(X_train, y_train)
        predictions = lr.predict(X_test)
        print("R2 Score using SKLearn LR Model: ", round(r2_score(predictions, y_test) * 100, 2), "%")

if __name__ == '__main__':

    X, y = load_wine(return_X_y=True)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.27, random_state=123)
    Linear_Regression_with_OLS().create_and_predict_model(X_train, X_test, y_train, y_test)
    Linear_Regression_with_OLS().use_LR(X_train, X_test, y_train, y_test)


