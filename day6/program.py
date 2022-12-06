
line = ""
with open("input.txt") as file:
    for temp in file:
        line = temp

parts = list(line)


i = 0

while i < len(parts):


    list = []
    list.append(parts[i])
    list.append(parts[i+1])
    list.append(parts[i+2])
    list.append(parts[i+3])
    list.append(parts[i+4])
    list.append(parts[i+5])
    list.append(parts[i+6])
    list.append(parts[i+7])
    list.append(parts[i+8])
    list.append(parts[i+9])
    list.append(parts[i+10])
    list.append(parts[i+11])
    list.append(parts[i+12])
    list.append(parts[i+13])
    myset = set(list)

    print(myset)
    
    if len(myset) == 14:
        i += 14
        break
    i += 1


print(i)
