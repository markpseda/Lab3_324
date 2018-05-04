# Add, Sub, Load, Print, Compare


import sys


if len(sys.argv) == 3:
    ReadPath = sys.argv[1]
    WritePath = sys.argv[2]

readFile = open(ReadPath, 'r')
writeFile = open(WritePath, 'w')


for line in readFile:
    components = line.split(' ')
    writeString = ""
    if components[0] == "add":
        writeString += "11"
        register1 = int(components[1]) #register1
        writeString += "{0:{fill}2b}".format(register1,fill='0')
        register2 = int(components[2]) #register2
        writeString += "{0:{fill}2b}".format(register2,fill='0')
        register3 = int(components[3]) #register3
        writeString += "{0:{fill}2b}".format(register3,fill='0')
    elif components[0] == "sub":
        writeString += "10"
        register1 = int(components[1]) #register1
        writeString += "{0:{fill}2b}".format(register1,fill='0')
        register2 = int(components[2]) #register2
        writeString += "{0:{fill}2b}".format(register2,fill='0')
        register3 = int(components[3]) #register3
        writeString += "{0:{fill}2b}".format(register3,fill='0')    
    elif components[0] == "load":
        writeString += "00"
        register = int(components[1]) #register
        writeString += "{0:{fill}2b}".format(register,fill='0')
        immediate = int(components[2]) #imm
        if immediate < 0:
            print(immediate)
            immediate = abs(immediate)
            print(immediate)
            immediate = ~immediate & 0x0F
            print(immediate)
            immediate += 1
            print(immediate)
        writeString += "{0:{fill}4b}".format(immediate,fill='0') #TODO: 2's complement immediate values..
    elif components[0] == "print":
        writeString += "010"
        register = int(components[1]) #register
        writeString += "{0:{fill}2b}".format(register,fill='0')
        writeString += "000" #unused
    elif components[0] == "compare":
        writeString += "011"
        register1 = int(components[1]) #register1
        writeString += "{0:{fill}2b}".format(register1,fill='0')
        register2 = int(components[2]) #register2
        writeString += "{0:{fill}2b}".format(register2,fill='0')
        choice = int(components[3]) #choice
        writeString += "{0:{fill}1b}".format(choice,fill='0')

    if writeString != "":
        writeFile.write(writeString)
        print(writeString)
        writeFile.write('\n')