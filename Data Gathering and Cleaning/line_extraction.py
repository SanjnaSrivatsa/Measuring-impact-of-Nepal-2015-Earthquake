import os

with open("n.ids.native.geo", "r") as in_f, open("karthik.csv","w")as out_karthik, open("kanishka.csv","w")as out_kanishka, open("sanjna.csv","w")as out_sanjna,open("aarthi.csv","w")as out_aarthi,open("manuja.csv","w")as out_manuja,open("snig.csv","w")as out_snig:
    size = in_f.tell()
    i = 1
    c = 1
    s = ""
    for line in in_f:
        size -= len(line)
        if not size:
            s = s + line.replace('\n', '')
            if c==1:
                out_karthik.write(s+"\n")
                c = c+1
            elif c==2:
                out_kanishka.write(s+"\n")
                c = c+1
            elif c==3:
                out_sanjna.write(s+"\n")
                c = c+1
            elif c==4:
                out_manuja.write(s+"\n")
                c = c+1
            elif c==5:
                out_aarthi.write(s+"\n")
                c = c+1
            elif c==6:
                out_snig.write(s+"\n")
                c = 1
				
            break
        if i==100:
            s=s+line.replace('\n','')
            if c == 1:
                out_karthik.write(s + "\n")
                c = c + 1
            elif c == 2:
                out_kanishka.write(s + "\n")
                c = c + 1
            elif c == 3:
                out_sanjna.write(s + "\n")
                c = c + 1
            elif c == 4:
                out_manuja.write(s + "\n")
                c = c + 1
            elif c == 5:
                out_aarthi.write(s + "\n")
                c = c + 1
            elif c == 6:
                out_snig.write(s + "\n")
                c = 1
            i = 1
            s = ""
            continue
        s = s+line.replace('\n','')+","
        i = i+1


