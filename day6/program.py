parts = list(open("input.txt").readline())

def find(numbers):
    for i in range(0,len(parts)):
        letters = set()
        for j in range(0,numbers):
            letters.add(parts[i+j])
        if len(letters) == numbers:
            i += numbers
            return i

print(find(4))
print(find(14))
