digits = [1,2,3]

def plusOne(digits):
    num = 0
    for i in range(len(digits)):
        num = num * 10 + digits[i]
    num += 1
    return [int(i) for i in str(num)]

print(plusOne(digits))

def addbinary(a,b):
    return bin(int(a,2)+int(b,2))[2:]