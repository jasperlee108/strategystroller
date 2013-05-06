import sys, getopt
import fileinput
import os

def maind(argv):
    for dirpath, dirnames, files in os.walk(os.path.abspath(os.curdir)):
        
        for filen in files:
            if "html.erb" in filen:
                if "spec.rb" not in filen:
                    path = dirpath+"/"+filen
                    print path
                

def main(argv):
    trans = {}
    for dirpath, dirnames, files in os.walk(os.path.abspath(os.curdir)):
        for filen in files:
            if "html.erb" in filen:
                if "spec.rb" not in filen:
                    path = dirpath+"/"+filen
                    print path
                    for line in fileinput.FileInput(path,inplace=1): #,inplace=1
                        #line = line.replace(";"," ")
                        if ':label => "' in line:
                            #print line
                            nameWithend = line.split(':label => "')[1];
                            name =nameWithend.split('"')[0];
                            short = name.replace(" ", "_")
                            short = short.lower()
                            short = ":"+short
                            trans[short] =name
                            replacement = ":label => (I18n.t "+ short+")"
                            line = line.replace(':label => "'+name+'"', replacement)
                        
                        else:
                            line =line
                        print line,
    #print trans
    newfile = open("./translated", 'a')
    for ent in trans:
        tline = "  "+ent[1:]+': "'+trans[ent]+'"\n'
        print tline
        newfile.write(tline)
            
         
    

if __name__ == "__main__":
    main(sys.argv[1:])
