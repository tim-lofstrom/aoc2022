s1 = ["R","C","H"]
s2 = ["F","S","L","H","J","B"]
s3 = ["Q","T","J","H","D","M","R"]
s4 = ["J","B","Z","H","R","G","S"]
s5 = ["B","C","D","T","Z","F","P","R"]
s6 = ["G","C","H","T"]
s7 = ["L","W","P","B","Z","V","N","S"]
s8 = ["C","G","Q","J","R"]
s9 = ["S","F","P","H","R","T","D","L"]

theMap = { "1": s1, "2": s2, "3": s3, "4": s4, "5": s5, "6": s6, "7": s7, "8": s8, "9": s9 }

lines = []
with open("input.txt") as file:
    for line in file:
        lines.append(line.rstrip().replace("move", "").replace("from", ",").replace("to", ",").replace(" " , ""))

for line in lines:
    parts = line.split(",")
    temp = []
    for _ in range(0, int(parts[0])):
        temp.append(theMap[parts[1]].pop(0))
    for _ in range(0, int(parts[0])):
        theMap[parts[2]].insert(0,temp.pop())

result = ""
for key in theMap:
    result += theMap[key].pop(0)
print(result)