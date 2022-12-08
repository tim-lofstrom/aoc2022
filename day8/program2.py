lines = []
with open("input.txt") as file:
    for line in file:
        lines.append(line.rstrip())

grid =  []

for line in lines:
    row = []
    parts = list(line)
    for tree in parts:
        row.append(tree)
    grid.append(row)

def score(input, x, y, dx, dy):
    h = input[x][y]
    x += dx
    y += dy
    sum = 0
    while (y >= 0 and y < len(input) and x >= 0 and x < len(input[y])):
        sum +=1
        if (input[x][y] >= h):
            return sum
        x += dx
        y += dy

    return sum

sum = 0

for i in range(0, len(lines)):
    for j in range(0, len(lines)):
        v1 = score(grid, i,j, 1, 0)
        v2 = score(grid, i,j, 0, 1)
        v3 = score(grid, i,j, -1, 0)
        v4 = score(grid, i,j, 0,-1)
        total = v1*v2*v3*v4
        sum = max(total, sum)

print(sum)
