import numpy as np
from sklearn.tree import DecisionTreeClassifier

# clf = DecisionTreeClassifier(random_state=0)
# cross_val_score(clf, iris.data, iris.target, cv=10)

x_train = np.loadtxt(open("train.dat","rb"),delimiter=",",skiprows=0)
x_test = np.loadtxt(open("test.dat", "rb"), delimiter=",",skiprows=0)
y_train = np.loadtxt(open("train_label.dat","rb"),delimiter=",",skiprows=0)
y_train = np.sign(y_train)
y_test = np.loadtxt(open("test_label.dat", "rb"), delimiter=",",skiprows=0)
y_test = np.sign(y_test)

N = len(y_train)
data_weights = 1.0 / N * np.ones(N)
classifiers = []

hypotheses = []
hypothesis_weights = []

for t in range(250):
    h = DecisionTreeClassifier(max_depth=1)

    h.fit(x_train, y_train, sample_weight=data_weights)
    pred = h.predict(x_train)

    eps = data_weights.dot(pred != y_train)
    alpha = (np.log(1 - eps) - np.log(eps)) / 2

    data_weights = data_weights * np.exp(- alpha * y_train * pred)
    data_weights = data_weights / data_weights.sum()

    hypotheses.append(h)
    hypothesis_weights.append(alpha)

# X input, y output
y = np.zeros(len(y_test))
for (h, alpha) in zip(hypotheses, hypothesis_weights):
    y = y + alpha * h.predict(x_test)
y = np.sign(y)

error = 0

for i in range(400):
    if y[i] != y_test[i]:
        error += 1
error /= 400.0

print error