import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns



# Load dataset
df = pd.read_csv(r"C:\Users\sagar\OneDrive\Documents\Desktop\Healthcare-Analysis\Data\healthcare-dataset-stroke-data.csv")


# DATA UNDERSTANDING

print("First 5 rows:\n", df.head())
print("\nDataset Info:\n")
print(df.info())
print("\nSummary Statistics:\n", df.describe())


# DATA CLEANING
print("\nMissing Values:\n", df.isnull().sum())

# Fill missing BMI with mean (better than dropping)
df['bmi'] = df['bmi'].fillna(df['bmi'].mean())


# Create Age Groups
df['age_group'] = pd.cut(df['age'],
                        bins=[0, 20, 40, 60, 100],
                        labels=['0-20', '20-40', '40-60', '60+'])


# VISUALIZATIONS

plt.figure(figsize=(15, 10))

# 1. Stroke Distribution
plt.subplot(2,2,1)
sns.countplot(x='stroke', data=df)
plt.title("Stroke Distribution")

# 2. Age Group vs Stroke
plt.subplot(2,2,2)
sns.countplot(x='age_group', hue='stroke', data=df)
plt.title("Age Group vs Stroke")

# 3. Glucose vs Age
plt.subplot(2,2,3)
sns.scatterplot(x='avg_glucose_level', y='age', hue='stroke', data=df)
plt.title("Glucose vs Age")

# 4. BMI Distribution
plt.subplot(2,2,4)
sns.histplot(df['bmi'], kde=True)
plt.title("BMI Distribution")

plt.tight_layout()
plt.show()


# INSIGHTS

print("\nAverage Glucose Level by Stroke:\n",
      df.groupby('stroke')['avg_glucose_level'].mean())

print("\nStroke Count by Gender:\n",
      df.groupby('gender')['stroke'].sum())
