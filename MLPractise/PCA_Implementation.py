#!/usr/bin/env python
# coding: utf-8

# In[1]:


filepath = "D:\CU Files\Spring 2024\ML\Assignments\HW-5\combined_participants_data.csv"


# In[2]:


import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler


# In[3]:


from sklearn.decomposition import PCA, IncrementalPCA
from sklearn.model_selection import train_test_split


# In[4]:


df = pd.read_csv(filepath)


# In[5]:


df.dropna(inplace=True)


# In[6]:


X = df.drop(columns=["gender"])
y = df["gender"]


# In[7]:


X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.25, random_state=123
)


# In[8]:


scaler = StandardScaler()


# In[9]:


scaler.fit(X_train)


# In[10]:


scaled_X_train = scaler.transform(X_train)
scaled_X_test = scaler.transform(X_test)


# In[11]:


pca = PCA(n_components=22)


# In[12]:


pca.fit_transform(scaled_X_train).shape


# In[13]:


pca.transform(scaled_X_test).shape


# Actual variance explained by each principal component is given by `explained_variance_`
# 

# In[14]:


pca.explained_variance_


# Cumulative proportion of variance explained by each principal component is given by `explained_variance_ratio_`
# 

# In[15]:


pca.explained_variance_ratio_


# In[16]:


cumulative_variance_explained = np.cumsum(pca.explained_variance_ratio_)


# In[17]:


cumulative_variance_rounded = np.round(cumulative_variance_explained, 4)
cumulative_variance_rounded


# In[18]:


import matplotlib.pyplot as plt


# In[19]:


plt.figure(figsize=(10, 6))
plt.bar(
    range(1, len(cumulative_variance_rounded) + 1),
    pca.explained_variance_ratio_,
    alpha=0.5,
    color="b",
    align="center",
    label="Individual explained variance",
)
plt.step(
    range(1, len(cumulative_variance_rounded) + 1),
    cumulative_variance_rounded,
    where="mid",
    label="Cumulative explained variance",
)
plt.ylabel("Explained variance explained by each principal component")
plt.legend(loc="best")
plt.tight_layout()
plt.show()


# In[22]:


pd.DataFrame(pca.components_)


# In[ ]:




