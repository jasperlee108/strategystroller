def makePigLatin(word):
    """ convert one word into pig latin """ 
    m  = len(word)
    vowels = "a", "e", "i", "o", "u", "y" 
    # short words are not converted 
    if m<3 or word=="the":
        return word
    else:
        for i in vowels:
            if word.find(i) < m and word.find(i) != -1:
                m = word.find(i)
        if m==0:
            return word+"way" 
        else:
            return word[m:]+word[:m]+"ay" 
 
import sys, getopt

def main(argv):
    print argv
    f = open("./"+str(argv[0]), 'r')
    newfile = open("./piglatin.yml", 'w')
    newfile.write("piglatin:\n")
    count =0
    for line in f:
        print "run" +str(count)
        if count < 1:
            count +=1
            continue
        split =line.split(":")
        if len(split)>1:
            rhs = split[1]
            newfile.write(split[0]+': \"')
            trans = ""
            for w in rhs.split(' '):
                if trans == "":
                    trans = (makePigLatin(w.replace('"',''))).replace("\n",' ')
                else:
                    trans += " "+(makePigLatin(w.replace('"',''))).replace("\n",' ')
            print trans
            newfile.write(trans)
            newfile.write('\"\n')
        count +=1
    f.close()   
    
    # process options
   # sentence = "Hooray for pig latin" 
   # pigLatinSentence = "" 
    # iterate through words in sentence 
    #for w in sentence.split(' '):
    #    pigLatinSentence += makePigLatin(w) + " " 
     
   # print pigLatinSentence.strip()

if __name__ == "__main__":
    main(sys.argv[1:])