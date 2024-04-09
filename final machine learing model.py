 #supervised machine learning model

import tweepy
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Twitter API credentials
consumer_key = 'your_consumer_key'
consumer_secret = 'your_consumer_secret'
access_token = 'your_access_token'
access_token_secret = 'your_access_token_secret'

# Authenticate with Twitter API
auth = tweepy.OAuth1UserHandler(consumer_key, consumer_secret, access_token, access_token_secret)
api = tweepy.API(auth)

# Search for tweets containing relevant keywords or hashtags
search_query = "Kpop photocards"
tweets = api.search(q=search_query, count=100)

# Extract relevant information from tweets (e.g., group name, year)
data = []
for tweet in tweets:
    # Extract text, group name, year, etc.
    # Preprocess text data if needed
    data.append({
        'text': tweet.text,
        'group': ...,
        'edges': ...,
        'year': ...,
    })

# Convert data to DataFrame
df = pd.DataFrame(data)

# Preprocessing: Convert categorical features to numerical representations
label_encoders = {}
for feature in ['group', 'year']:
    label_encoders[feature] = LabelEncoder()
    df[feature] = label_encoders[feature].fit_transform(df[feature])

# Split data into features (X) and labels (y)
X = df[['group', 'year']]
y = df['photocard']

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Model training (using Random Forest as an example)
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Evaluate the model
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
print("Accuracy:", accuracy)

# Example prediction
new_data = pd.DataFrame({'group': ['SHINee'], 'year': [2008]})  
for feature in ['group', 'year']:
    new_data[feature] = label_encoders[feature].transform(new_data[feature])
prediction = model.predict(new_data)
print("Predicted Photocard:", prediction[0])
