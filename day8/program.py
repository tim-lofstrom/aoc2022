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

def visible(input, x, y, dx, dy):
    h = input[x][y]
    x += dx
    y += dy
    while (y >= 0 and y < len(input) and x >= 0 and x < len(input[y])):
        if (input[x][y] >= h):
            return False
        x += dx
        y += dy
    return True

sum = 0

for i in range(0, len(lines)):
    for j in range(0, len(lines)):
        v1 = visible(grid, i,j, 1, 0)
        v2 = visible(grid, i,j, 0, 1)
        v3 = visible(grid, i,j, -1, 0)
        v4 = visible(grid, i,j, 0,-1)
        if v1 or v2 or v3 or v4:
            sum += 1

print(sum)
