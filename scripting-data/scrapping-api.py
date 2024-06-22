import pandas as pd
import requests

# Step 1: Fetch the JSON data from the API
url = 'http://universities.hipolabs.com/search?country=United States'
response = requests.get(url)
data = response.json()

# Step 2: Parse the JSON data
# Extract relevant fields for each university
universities_list = []
for university in data:
    universities_list.append({
        'name': university.get('name'),
        # Taking the first web page
        'web_pages': university.get('web_pages', [None])[0],
        'country': university.get('country'),
        # Taking the first domain
        'domains': university.get('domains', [None])[0],
        'state-province': university.get('state-province')
    })

# Step 3: Convert to Pandas DataFrame
df = pd.DataFrame(universities_list, columns=[
                  'name', 'web_pages', 'country', 'domains', 'state-province'])

# Step 4: Save the DataFrame to a CSV file
df.to_csv('./results/universities.csv', index=False)

# Step 5: Filter out rows where 'state-province' is blank, NaN, or null
filtered_df = df.dropna(subset=['state-province']
                        ).query("`state-province` != ''")

# Step 6: Display the filtered DataFrame
print(filtered_df)

# Step 7: Save the filtered DataFrame to a CSV file
filtered_df.to_csv('./results/universities_filtered.csv', index=False)
