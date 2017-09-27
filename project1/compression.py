hexDict = {
    '0': 0,
    '1': 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    'a': 10,
    'b': 11,
    'c': 12,
    'd': 13,
    'e': 14,
    'f': 15,
}

def sanitize(token):
    if (token[0] == "$"):
        return hexDict[token[1]]
    else:
        return int(token)

def addLine(f_out, ct, clr):
    f_out.write(" dcb {0}, {1}\n".format(ct, clr))

def addStart(f_out):
    f_out.write('pic{0}\n'.format(ct))

def addEnd(f_out):
    f_out.write(" dcb 0\n")

def compress(f_in, f_out):
    currentColor = 0
    currentCount = 0
    for line in f_in:
        print("----------")
        line = line[3:]
        line = line.replace(' ', '')
        tokens = line.split(',')
        for t in tokens:
            t = sanitize(t)
            if (t == currentColor):
                currentCount += 1
                print(t, currentColor, currentCount,"=")
                if (currentCount == 255):
                    addLine(f_out, currentCount, currentColor)
                    currentCount = 0
            else:
                print(t, currentColor, currentCount, "!")
                addLine(f_out, currentCount,currentColor)
                currentColor = t
                currentCount = 1
                print(t, currentColor, currentCount, "r!")

    addEnd(f_out)

def main():
    filename = "world.txt"
    pic_in = open(filename)
    pic_out = open("compressed1" + filename, 'w')
    compress(pic_in, pic_out)

if __name__ == '__main__':
    main()
