import pandas as pd

# Step 1: Read each CSV file into separate DataFrames
df1 = pd.read_csv('data/branch_a.csv')
df2 = pd.read_csv('data/branch_b.csv')
df3 = pd.read_csv('data/branch_c.csv')

# Step 2: Merge the DataFrames
merged_df = pd.concat([df1, df2, df3], ignore_index=True)

# Step 4: Drop rows with NaN values in specified columns
merged_df.dropna(subset=['transaction_id', 'date',
                 'customer_id'], inplace=True)

# Step 5: Convert 'date' column to datetime format for sorting
merged_df['date'] = pd.to_datetime(merged_df['date'])

# Step 6: Sort DataFrame by 'transaction_id' and 'date' descending
merged_df.sort_values(by=['transaction_id', 'date'],
                      ascending=[True, False], inplace=True)

# Step 7: Drop duplicates, keeping the first occurrence (latest date)
merged_df.drop_duplicates(
    subset=['transaction_id'], keep='first', inplace=True)

# Step 8: Reset index if needed
merged_df.reset_index(drop=True, inplace=True)

# Display the cleaned DataFrame
print(merged_df)

# Assuming merged_df is already prepared from previous steps
# Step 1: Calculate total transaction amount per transaction
merged_df['total_amount'] = merged_df['quantity'] * merged_df['price']

# Step 2: Group by 'branch' and sum total transaction amount
transaction_amounts = merged_df.groupby(
    'branch')['total_amount'].sum().reset_index()

# Rename the 'total_amount' column to 'total_transaction_amount'
transaction_amounts.rename(
    columns={'total_amount': 'total_transaction_amount'}, inplace=True)

# Step 3: Save the result to a CSV file
transaction_amounts.to_csv(
    './results/transaction_amounts_per_branch.csv', index=False)

# Display the transaction amounts DataFrame (optional)
print(transaction_amounts)
