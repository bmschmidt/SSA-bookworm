import os
import json

everything = open('input.txt','w')
jsoncatalog = open('jsoncatalog.txt','w')

oldid = None
for file in os.listdir('states'):
    for line in open('states/' + file):
        array = line.split(",")
        tmp = dict()
        
        for key in ["state","gender","year","name","count"]:
            tmp[key] = array.pop(0)

        id = "%(state)s-%(year)s-%(gender)s"%tmp        
        if oldid != id:
            if oldid is not None:
                everything.write("\n")
            everything.write(id + "\t")
            metadata=dict()
            metadata['filename'] = id
            metadata['state'] = tmp['state']
            metadata['gender'] = tmp['gender']
            metadata['year'] = tmp['year']
            metadata['searchstring'] = "%(gender)s in %(state)s in %(year)s" %tmp
            jsoncatalog.write(json.dumps(metadata) + "\n")
            oldid = id
        everything.write((tmp['name'] + " ")*int(tmp['count']))
