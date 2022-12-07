lines = []
with open("input.txt") as file:
    for line in file:
        lines.append(line.rstrip())

cwd = []
tree = {}

for line in lines:
    
    parts = line.split()

    if parts[0] == "$":
        if parts[1] == "cd":
            if parts[2] == "..":
                cwd.pop()
            else:
                cwd.append(parts[2])
                
    elif parts[0].isnumeric():

        key = "/"+"/".join(cwd[1:])

        if not key in tree:
            tree[key] = 0
        tree[key] += int(parts[0])

        temp = cwd.copy()

        while len(temp) > 1:
            temp.pop()
            key = "/"+"/".join(temp[1:])
            if not key in tree:
                tree[key] = 0
            tree[key] += int(parts[0])


sum = 0

listan = []

for k in tree:
    if(tree[k] <= 100000):
        sum += tree[k]
    listan.append(tree[k])

print(sum)

listan.sort()

spaceNeeded = 30000000-(70000000-listan[-1])
for i in listan:
    if i > spaceNeeded:
        print(i)
        break