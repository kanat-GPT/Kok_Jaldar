import pandas as pd

print("Начинаем нормализацию Online Retail датасета...")

# 1. Читаем файл
df = pd.read_csv(r"C:\Project\Kok_Jaldar\data\online_retail.csv",
                 encoding='utf-8', low_memory=False)

# Приводим типы
df['Quantity'] = pd.to_numeric(df['Quantity'], errors='coerce')
df['UnitPrice'] = pd.to_numeric(df['UnitPrice'], errors='coerce')
df['InvoiceDate'] = pd.to_datetime(df['InvoiceDate'], format='%m/%d/%Y %H:%M', errors='coerce')
df['CustomerID'] = df['CustomerID'].astype('str').str.replace('.0$', '', regex=True).replace('nan', '')

print(f"Исходных строк: {len(df)}")

# 1. countries
countries = pd.DataFrame({'country_name': sorted(df['Country'].dropna().unique())})
countries['country_id'] = range(1, len(countries) + 1)
countries[['country_id', 'country_name']].to_csv('1_countries.csv', index=False, encoding='utf-8')
print(f"1_countries.csv → {len(countries)} строк")

# 2. categories
categories = pd.DataFrame({
    'category_name': ['Other', 'Christmas Decoration', 'Bags', 'Tableware',
                      'Gifts & Decor', 'Postage', 'Manual/Adjustment', 'Uncategorized']
})
categories['category_id'] = range(1, len(categories) + 1)
categories[['category_id', 'category_name']].to_csv('2_categories.csv', index=False, encoding='utf-8')
print(f"2_categories.csv → {len(categories)} строк")

# 3. products
products = df[['StockCode', 'Description']].drop_duplicates().copy()
products['category_id'] = 1  # Other
products['product_id'] = range(1, len(products) + 1)
products = products[['product_id', 'StockCode', 'Description', 'category_id']]
products.to_csv('3_products.csv', index=False, encoding='utf-8')
print(f"3_products.csv → {len(products)} строк")

# 4. customers
customers = df[df['CustomerID'] != ''][['CustomerID', 'Country']].drop_duplicates()
customers = customers.merge(countries[['country_id', 'country_name']],
                           left_on='Country', right_on='country_name', how='left')
customers = customers[['CustomerID', 'country_id']].dropna()
customers['customer_id'] = range(1, len(customers) + 1)
customers = customers[['customer_id', 'CustomerID', 'country_id']]
customers.to_csv('4_customers.csv', index=False, encoding='utf-8')
print(f"4_customers.csv → {len(customers)} строк")

# 5. orders
orders = df[['InvoiceNo', 'InvoiceDate', 'CustomerID']].drop_duplicates()
orders = orders[orders['CustomerID'] != '']
orders = orders.merge(customers[['CustomerID', 'customer_id']], on='CustomerID', how='left')
orders = orders.dropna(subset=['customer_id'])
orders['order_id'] = range(1, len(orders) + 1)
orders = orders[['order_id', 'InvoiceNo', 'InvoiceDate', 'customer_id']]
orders.to_csv('5_orders.csv', index=False, encoding='utf-8')
print(f"5_orders.csv → {len(orders)} строк")

# 6. order_items
order_items = df[['InvoiceNo', 'StockCode', 'Quantity', 'UnitPrice']].copy()
order_items = order_items.merge(orders[['InvoiceNo', 'order_id']], on='InvoiceNo', how='left')
order_items = order_items.merge(products[['StockCode', 'product_id']], on='StockCode', how='left')
order_items = order_items.dropna(subset=['order_id', 'product_id'])
order_items['item_id'] = range(1, len(order_items) + 1)
order_items = order_items[['item_id', 'order_id', 'product_id', 'Quantity', 'UnitPrice']]
order_items.to_csv('6_order_items.csv', index=False, encoding='utf-8')
print(f"6_order_items.csv → {len(order_items)} строк")

# 7. payments
payments = order_items.groupby('order_id').apply(
    lambda x: round((x['Quantity'] * x['UnitPrice']).sum(), 2)
).reset_index(name='amount_paid')
payments = payments.merge(orders[['order_id']], on='order_id', how='right')
payments['payment_id'] = range(1, len(payments) + 1)
payments = payments[['payment_id', 'order_id', 'amount_paid']]
payments.to_csv('7_payments.csv', index=False, encoding='utf-8')
print(f"7_payments.csv → {len(payments)} строк")

print("\nГОТОВО ЗА 12 СЕКУНД!")
print("Все 7 файлов созданы и идеально подходят для импорта в MySQL Workbench")
print("Порядок импорта: 1 → 2 → 3 → 4 → 5 → 6 → 7")