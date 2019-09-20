import os
import csv

############################################################################################################
# Define fuction
############################################################################################################

def whoIsWinner(dict):
	detail_info = []
	for i in dict:
		detail_info.append([i,dict[i]])

	maxVotes = 0

	for k in range(0,len(detail_info)):
		if detail_info[k][1] > maxVotes:
			maxVotes = detail_info[k][1]

	# return winner's number of votes
	return maxVotes

###########################################################################################################

election_data_path = os.path.join("Resources", "election_data.csv")

totlaVotes = 0
candidates_info = {} #key: candidate's name value: number of votes
election_data = [] # cache for election data
strOutput =""

with open(election_data_path, newline="") as election_data_csvfile:
	csvreader = csv.reader(election_data_csvfile, delimiter=",")
	next(csvreader)

	for row in csvreader:
		
		totlaVotes += 1
		election_data.append(row)

		# get candidate's name
		if row[2] not in candidates_info:
			candidates_info[row[2]] = 0

	# get candidate's total number of votes
	for data in election_data:
		name = data[2]
		candidates_info[name] +=1


	# get Who is winner of Poll
	numOfWinnerVotes = whoIsWinner(candidates_info)
	indexOfWinner = list(candidates_info.values()).index(numOfWinnerVotes)
	winner = list(candidates_info.keys())[(indexOfWinner)]

	strResult = ""

	print("Election Results")
	print("-----------------------------")
	print(f"Total Votes: {totlaVotes}")
	print("-----------------------------")
	for result in candidates_info:
		percent = format((candidates_info[result]/totlaVotes)*100, ".3f")
		print(f"{result}: {percent}% ({candidates_info[result]})")
		strResult += f"{result}: {percent}% ({candidates_info[result]})\n"
	print("-----------------------------")
	print(f"Winner: {winner}")
	print("-----------------------------")

	strOutput = "Election Results\n-----------------------------\n"+f"Total Votes: {totlaVotes}"+"\n-----------------------------\n"+strResult+"\n-----------------------------\n"+f"Winner: {winner}"+"\n-----------------------------\n"
	
# export txt file
filepath = os.getcwd()
if not os.path.isfile(filepath+"/ElectionResult.txt"):
	ouput_file = open("ElectionResult.txt", "w")
	ouput_file.write(strOutput)
	ouput_file.close()