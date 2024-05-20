#!/usr/bin/python3
import getopt
import sys
import os
import shutil

def main(argv):
    try:
        _, args = getopt.getopt(argv[1:],"h")
        if len(args) != 1:
            print("usage:%s directoryPath" % argv[0])
            sys.exit(2)
    except getopt.GetoptError:
            print("usage:%s directoryPath" % argv[0])
            sys.exit(2)
    files = []
    comfiles = []
    dirname = args[0]
    for folderName, dirnames, filenames in os.walk(dirname):
        for direle in dirnames:
            if direle == '.vs' or direle == 'Debug':
                print("%s:%s deleted\n" % (folderName, direle))
                tmp = os.path.join(folderName,direle)
                shutil.rmtree(tmp)


if __name__ == '__main__':
    print(sys.argv)
    main(sys.argv)
