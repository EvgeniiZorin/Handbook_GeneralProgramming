import pandas as pd
import numpy as np

print('-'*100)

print("Version of Pandas: ")
print(pd.__version__)

print('-'*100)

print('Reading contents of another file: ')
with open('file1.txt', 'r') as input:
	for i in input:
		print(i)

print('-'*100)
