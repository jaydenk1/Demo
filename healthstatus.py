
#!/usr/bin/python

import csv
import sys


#input string you want to search
string = raw_input('Enter only healthy or unhealthy word\n')

#read csv, and split on "," the line
csv_file = csv.reader(open('/home/logs/containerlogs.csv', "r"), delimiter=",")


#loop through the csv list
for row in csv_file:
    #if current rows 2nd value is equal to input, print that row
    if string == row[5]:
         print (row)