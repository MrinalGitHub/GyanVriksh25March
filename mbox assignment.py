#!/usr/bin/python
import pandas as pd
import collections as cs
try:
   fhand = input('Enter file name\n')
   fname = open(fhand)
except:
   print ('File cannot be opened:', fname)
   #exit()
c = 0
t = 0
count = 0
list1 = []

for line in fname:
    if line.startswith('From:'):
        c=c+1
        list1.append(line[6:].strip())
counter = cs.Counter(list1)
#print(counter)
print(pd.Series(counter)) #1st and 2nd Questions addressed, List of all 'From' members
print("Count of all 'From:' mails",c)
countval = counter.values()
sum(countval)#cross verifying count of all from mail
spamconf = 'X-DSPAM-Confidence:'
list2 = list(counter.keys())
lenght = len(list2)
stringfrom = 'From: '
#For each from person taking spam confidence in that order
#fn = open('C:/mbox.txt', 'r')
listspammails = []
listspamcounts = []
fname.seek(0)
for line in fname:
    if line.startswith('From:'):
        listspammails.append(line[6:].rstrip())
    if line.startswith(spamconf):
        listspamcounts.append(line[19:])
#Categorizing All from person's spam confidence in the order, 
#listcountpermail has position of each person's spam confidence
i=0
j=0
listcountpermail = []
for i in range(0,len(list2)):
    for j in range(0,len(listspammails)):
        if list2[i] == listspammails[j]:
            listcountpermail.append(j)
    listcountpermail.append('break')
listcountpermail.count('break')
k=0
m=0
check=0
avgspamconf = 0
listavgspamconf = []
finalconf = []
#listspamcounts has spam confidence of all 1797 mails and k has location of per person 
# spam confidence, avgspamconf has average of each From: person spam confidence
rcount=0
n=0
firsttime = 1
brk = 'break'
for i in range(0,len(listcountpermail)):
    if listcountpermail[i]!='break':
        firsttime = firsttime+1
        k = listcountpermail[i]
        avgspamconf = float(avgspamconf+float(listspamcounts[k].strip()))
        n=n+1
    else:
        if firsttime==1:
            n=1
        avgspamconf=((avgspamconf/n))
        avgspamconf = float("{0:.4f}".format(avgspamconf))
        finalconf.append(avgspamconf)
        avgspamconf = 0
        if firsttime!=0:
            n=0
        continue
#print(list2,finalconf)#3rd Question
#print(pd.Series(finalconf))
keys = (list2)
values = (finalconf)

dic = {k:v for k,v in zip(keys, values)}
print(pd.Series(dic))
























#for line in fn:
#    mailid = list2[i]
#    mailid = stringfrom+mailid
#    if 'colin.clark@utoronto.ca' in line:
#        j=j+1
#        listspamcounts.append = line[count:]
#    i=i+1
#    if i==lenght:
#        break
#        count = line.find(mailid)
#        listspamcounts.append = line[count:]



            
        








