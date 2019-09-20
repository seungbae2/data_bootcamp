import os
import csv

############################################################################################################
#Define fuctions
############################################################################################################

#get average
def getAverageChanges(lists):
    total = 0.0
    for i in lists:
        total += i
    return total / len(lists)
#get Greatest Increase in Profits
def getMaximumChange(lists):
	maxVal = 0
	for i in range(0,len(lists)):
		if lists[i] > maxVal:
			maxVal = lists[i]

	return maxVal
#get Greatest Decrease in Profits
def getMinimumChange(lists):
	minVal = 0
	for i in range(0,len(lists)):
		if lists[i] < minVal:
			minVal = lists[i]

	return minVal

############################################################################################################

budget_csv = os.path.join("Resources", "budget_data.csv")

totalMonth = 0  #The total number of months included in the dataset
totalAmount = 0  #The net total amount of "Profit/Losses" over the entire period
aveChanges = 0  #The average of the changes in "Profit/Losses" over the entire period
profit_losses = [] #cache for Profit/Loss Column
changes = [] #cache for changes in Profit/Loss
months = [] #cache for dates Column

output_string = ""

#open and read csv file
with open(budget_csv, newline="") as csvfile:
	csvreader = csv.reader(csvfile, delimiter=",")

	next(csvreader)

	for row in csvreader:
		totalMonth += 1
		totalAmount = totalAmount + int(row[1])
		profit_losses.append(int(row[1]))
		months.append(row[0])

	for i in range(1,len(profit_losses)):
		changes.append(profit_losses[i] - profit_losses[i-1])


	aveChanges = format(getAverageChanges(changes), ".2f")
	maxIncrease = getMaximumChange(changes)
	maxIndex = changes.index(maxIncrease)
	maxMonth = months[maxIndex+1]

	minIncrease = getMinimumChange(changes)
	minIndex = changes.index(minIncrease)
	minMonth = months[minIndex+1]

	strTotalMonth = f"Total Months: {totalMonth}"
	strTotal = f"Total: ${totalAmount}"
	strAve = f"Average Change: ${aveChanges}"
	strGtInc = f"Greatest Increase in Profits: {maxMonth}  (${maxIncrease})"
	strGtDec = f"Greatest Decrease in Profits: {minMonth}  (${minIncrease})"

	print("Financial Analysis")
	print("----------------------------------------------------------------")
	print(strTotalMonth)
	print(strTotal)
	print(strAve)
	print(strGtInc)
	print(strGtDec)

	output_string = "Financial Analysis\n----------------------------------------------------------------"+"\n"+strTotalMonth+"\n"+strTotal+"\n"+strAve+"\n"+strGtInc+"\n"+strGtDec

#export txt file
filepath = os.getcwd()
if not os.path.isfile(filepath+"/FinalcialAnalysis.txt"):
	ouput_file = open("FinalcialAnalysis.txt", "w")
	ouput_file.write(output_string)
	ouput_file.close()


