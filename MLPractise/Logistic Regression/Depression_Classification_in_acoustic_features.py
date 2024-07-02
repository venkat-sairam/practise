import pandas as pd
from statsmodels.graphics.gofplots import qqplot
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats as stats
from sklearn.feature_selection import SelectKBest, f_classif
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, balanced_accuracy_score, confusion_matrix
from scipy.stats import zscore
import numpy as np
import os
from imblearn.over_sampling import SMOTE

class LogisticRegression_Implementation(object):
    def __init__(self) -> None:
        self.weights = None
        self.intercept = None
        self.learning_rate = 0.01
        self.epochs = 1000

    def fit(self, X, y):

        print(X.shape)

    def predict(self, X_test):
        return np.dot(X_test, self.weights) + self.intercept

    def read_input_data(self, filePath):
        return pd.read_csv(filePath)


if __name__ == "__main__":
    try:

        base_path = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

        train_file_path = os.path.join(
            base_path, "Datasets", "combined_participants_data.csv"
        )
        test_file_path = os.path.join(
            base_path, "Datasets", "test_combined_participants_data.csv"
        )
        labels_file_path = os.path.join(base_path, "Datasets", "labels.csv")

        cls_ref = LogisticRegression_Implementation()
        print(f"{'*'*50} Reading Input Files {'*' * 50}")
        train_df = cls_ref.read_input_data(filePath=train_file_path)
        test_df = cls_ref.read_input_data(filePath=test_file_path)
        labels_df = cls_ref.read_input_data(filePath=labels_file_path)

        print(f"Train file shape: {train_df.shape}")
        print(f"Test file shape: {test_df.shape}")
        print(f"Labels file shape: {labels_df.shape}")
        print(f"{'*'*50} Successfully read all the Input Files {'*' * 50}")

        train_df.drop_duplicates(inplace=True)
        train_df.dropna(inplace=True)

        # Reset index of train_df after dropping duplicates and NaN values
        train_df.reset_index(drop=True, inplace=True)


        X = train_df.drop(columns=["depression", "gender", "participant_id"])
        y = train_df["depression"]
        participant_ids = train_df["participant_id"]
        gender = train_df["gender"]

        # Before train_test_split, apply SMOTE to balance classes
        smote = SMOTE(random_state=42)
        X_resampled, y_resampled = smote.fit_resample(X, y)

        # Create a new DataFrame for resampled data
        resampled_df = pd.DataFrame(X_resampled, columns=X.columns)
        resampled_df["depression"] = y_resampled
        resampled_df["participant_id"] = participant_ids
        resampled_df["gender"] = gender  

        X_train, X_test, y_train, y_test = train_test_split(
            resampled_df.drop(columns=["depression", "participant_id", "gender"]),
            resampled_df["depression"],
            test_size=0.25,
            random_state=213,
            stratify=resampled_df["depression"]
        )

        train_participant_ids = resampled_df.loc[X_train.index, "participant_id"]
        test_participant_ids = resampled_df.loc[X_test.index, "participant_id"]
        train_gender = resampled_df.loc[X_train.index, "gender"]
        test_gender = resampled_df.loc[X_test.index, "gender"]


        lr = LogisticRegression(max_iter=10000, solver="saga")
        lr.fit(X_train, y_train)
        pos_class_predicted_probabilities = lr.predict_proba(X_test)[:, 1]
        print("shape of predictions: ", pos_class_predicted_probabilities.shape)
        print("shape of y_Test: ", y_test.shape)

        participant_wise_y_true_y_pred_gender_df = pd.DataFrame(
            {
                "participant_id": test_participant_ids,
                "y_pred": pos_class_predicted_probabilities,
                "y_true": y_test,
                "gender": test_gender,
            }
        )
        grouped_participant_data = participant_wise_y_true_y_pred_gender_df.groupby(
            by="participant_id"
        ).agg({"y_true": "first", "y_pred": "mean", "gender": "first"})

        print(grouped_participant_data.shape)

        grouped_participant_data["final_y_pred"] = (
            grouped_participant_data["y_pred"] >= 0.5
        ).astype(int)

        Accuracy_Score_A = accuracy_score(grouped_participant_data['y_true'], grouped_participant_data['final_y_pred'])

        depressed_participants = grouped_participant_data[grouped_participant_data['y_true'] == 1]
        non_depressed_participants = grouped_participant_data[grouped_participant_data['y_true'] == 0]

        tp_count = depressed_participants[depressed_participants['y_true'] == depressed_participants['final_y_pred']].shape[0]
        tn_count = non_depressed_participants[non_depressed_participants['y_true'] == non_depressed_participants['final_y_pred']].shape[0]

        balanced_accuracy_score = 0.5 *(tp_count / depressed_participants.shape[0]) + \
            0.5 * (tn_count / non_depressed_participants.shape[0])

        print(f"balanced accuracy score of the participants = {balanced_accuracy_score}")
        print(f"Accuracy Score of the participants = {Accuracy_Score_A}")

        male_participants = grouped_participant_data[grouped_participant_data['gender'] == 1]
        female_participants = grouped_participant_data[grouped_participant_data['gender'] == 0]

        male_accuracy_score = accuracy_score(male_participants['y_true'], male_participants['final_y_pred'])
        female_accuracy_score = accuracy_score(female_participants['y_true'], female_participants['final_y_pred'])

        print(f"Accuracy Score of Male participants = {male_accuracy_score}")
        print(f"Accuracy Score of Female participants = {female_accuracy_score}")

        male_depressed = male_participants[male_participants['y_true'] == 1]
        male_non_depressed = male_participants[male_participants['y_true'] == 0]

        male_tp_ = male_depressed[male_depressed['y_true'] == male_depressed['final_y_pred']].shape[0]
        male_tn_ = male_non_depressed[male_non_depressed['final_y_pred'] == male_non_depressed['y_true']].shape[0]

        male_balanced_accuracy_score = 0.5 * (male_tp_ / male_depressed.shape[0]) + 0.5 * (
            male_tn_ / male_non_depressed.shape[0]
        )

        female_depressed = female_participants[female_participants['y_true'] == 1]
        female_non_depressed = female_participants[female_participants['y_true'] == 0]

        female_tp_ = female_depressed[female_depressed['y_true'] == female_depressed['final_y_pred']].shape[0]
        female_tn_ = female_non_depressed[female_non_depressed['final_y_pred'] == female_non_depressed['y_true']].shape[0]

        female_balanced_accuracy_score = 0.5 * (female_tp_ / female_depressed.shape[0]) + 0.5 * (
            female_tn_ / female_non_depressed.shape[0]
        )

        print(f"Balanced accuracy score of Male participants = {male_balanced_accuracy_score}")
        print(f"Balanced accuracy score of Female participants = {female_balanced_accuracy_score}")

        male_tp = male_depressed[male_depressed['y_true'] == male_depressed['final_y_pred']].shape[0]
        male_fn = male_depressed[male_depressed['y_true'] != male_depressed['final_y_pred']].shape[0]

        male_tn = male_non_depressed[male_non_depressed['y_true'] == male_non_depressed['final_y_pred']].shape[0]
        male_fp = male_non_depressed[male_non_depressed['y_true']!= male_non_depressed['final_y_pred']].shape[0]

        male_tpr = male_tp / (male_tp + male_fn)


        female_tp = female_depressed[female_depressed['y_true'] == female_depressed['final_y_pred']].shape[0]
        female_fn = female_depressed[female_depressed['y_true']!= female_depressed['final_y_pred']].shape[0]

        female_tpr = female_tp /(female_tp + female_fn)

        EO = 1- abs(male_tpr - female_tpr)
        
        print(f"True Positive Rate of Male participants: {male_tpr}")
        print(f"True Positive Rate of Female participants: {female_tpr}")

        print(f"EO Value: {EO}")

    except Exception as e:
        raise FileNotFoundError(" Error occured while reading Input Files")
