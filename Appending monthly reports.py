import pandas as pd
import os

# location of monthly reports
path1 = 'H:\EPIC\Part1'

# print root and file name of all .xls files in path1
for root, dirs, files in os.walk(path1):
    for file in files:
        if(file.endswith('.xls')):
            print(os.path.join(root,file))
            part1_filelist.append(os.path.join(root,file))
                        
# initialize empty list
list_data1 = []

# create list of monthly reports
for file in part1_filelist:
     data = pd.read_excel(file, dtype=str)  
     list_data1.append(data)
    
# append monthly reports
part1_all = pd.concat(list_data1, ignore_index=True)

# Map the lowering function to all column names
part1_all.columns = map(str.lower, part1_all.columns)

# Export dataframe as dta file
part1_all.to_stata('part1_.dta', version=119, write_index=False)