
numberlist = [2, 4, 6, 8, 10]

for i in range(len(numberlist)):
    if i == len(numberlist) - 1:
        sum_of_numbers = numberlist[i] + numberlist[0]
    else:
        sum_of_numbers = numberlist[i] + numberlist[i + 1]
    print(sum_of_numbers)

print()
