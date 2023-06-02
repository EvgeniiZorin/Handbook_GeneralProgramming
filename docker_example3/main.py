import time
import os
import datetime

if not os.path.exists('output3'):
	os.mkdir('output3')

if not os.path.exists('output3/output.txt'):
	with open('output3/output.txt', 'w') as output:
		output.write('Date,Count\n')



with open('output3/output.txt', 'a') as output:
	counter = 0
	while True:
		output.write(f'{datetime.datetime.now()},{counter}\n')
		counter += 1
		print(f'Processed number {counter}')
		time.sleep(1)
		if counter == 5:
			break


print("the entire program has finished execution!")

