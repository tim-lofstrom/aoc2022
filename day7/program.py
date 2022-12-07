lines = []
with open("/home/timlof/workspace/haskell/aoc/day7/input.txt") as file:
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
            print(cwd)
    elif parts[0].isnumeric():
        key = "/"+"/".join(cwd[1:])

        # print(key + ":" + parts[0])
        if not key in tree:
            tree[key] = 0

        tree[key] += int(parts[0])

        temp = cwd.copy()

        while len(temp) > 0:
            temp.pop()
            key = "/"+"/".join(temp[1:])
            if not key in tree:
                tree[key] = 0
            tree[key] += int(parts[0])


sum = 0

for k in tree:
    print(k + ":" + str(tree[k]))
    if(tree[k] <= 100000):
        sum += tree[k]

print(sum)