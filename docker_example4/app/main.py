import argparse
import time

parser = argparse.ArgumentParser()
parser.add_argument('-p', '--param')
args = parser.parse_args()

abcd = args.param

print('Starting code!')

while True:
    print(int(abcd))
    time.sleep(1)

for i in range(0, int(abcd)):
    print(i)

