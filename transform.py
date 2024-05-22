import pandas
import sqlalchemy
import dash
import matplotlib
import seaborn
import pandas as pd
import sqlite3

df = pd.read_csv('dataset.csv')
print(df.head())

# from sqlalchemy import create_engine

# engine = create_engine('sqlite:///:memory:')
# df.to_sql('transactions',engine, if_exists='replace')

df.columns = df.columns.str.strip()
connection = sqlite3.connect('demo.db')

df.to_sql('dataset',connection,if_exists='replace')

