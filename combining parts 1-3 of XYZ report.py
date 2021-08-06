import pandas as pd
import os

part1_filelist = []
part2_filelist = []
part3_filelist = []

path1 = 'H:\EPIC\Part1'
path2 = 'H:\EPIC\Part2'
path3 = 'H:\EPIC\Part3'

# part1
for root, dirs, files in os.walk(path1):
    for file in files:
        if(file.endswith('.xls')):
            print(os.path.join(root,file))
            part1_filelist.append(os.path.join(root,file))
            
# part2
for root, dirs, files in os.walk(path2):
    for file in files:
        if(file.endswith('.xlsx')):
            print(os.path.join(root,file))
            part2_filelist.append(os.path.join(root,file))
            
# part3
for root, dirs, files in os.walk(path3):
    for file in files:
        if(file.endswith('.xlsx')):
            print(os.path.join(root,file))
            part3_filelist.append(os.path.join(root,file))
            
# initialize empty list that we will append dataframes to
list_data1 = []
list_data2 = []
list_data3 = []

# list of dataframes - part1
for file in part1_filelist:
    data = pd.read_excel(file, dtype=str)  
    list_data1.append(data)
    
# append all the part1 files
part1_all = pd.concat(list_data1, ignore_index=True)


# list of dataframes - part2
for file in part2_filelist:
    data = pd.read_excel(file, dtype=str)  
    list_data2.append(data)
    
# append all the part2 files
part2_all = pd.concat(list_data2, ignore_index=True)


# list of dataframes - part3
for file in part3_filelist:
    data = pd.read_excel(file, dtype=str)  
    list_data3.append(data)
    
# append all the part1 files - part3
part3_all = pd.concat(list_data3, ignore_index=True)


# Map the lowering function to all column names
part1_all.columns = map(str.lower, part1_all.columns)
part2_all.columns = map(str.lower, part2_all.columns)
part3_all.columns = map(str.lower, part3_all.columns)

# gen part1-3 indicator
part1_all['part1'] = 1
part2_all['part2'] = 1
part3_all['part3'] = 1


# Convert all object type variables to string
col = part1_all.select_dtypes(include=['object']).columns.tolist()
part1_all[list(col)] = part1_all[list(col)].astype(str)
#= part1_all[col].astype(str)
part1_all.info()

# drop dups
dfs = [part1_all, part2_all, part3_all]

for df in dfs:
    df.drop_duplicates(inplace=True)
       
    # remove white space at both ends of string
    df.columns = df.columns.str.strip()
    
    # replace white spaces with underscore
    df.columns = df.columns.str.replace(' ', '_')

    
# Convert dataframes to stata
part1_all.to_stata('part1.dta', version=119, write_index=False)
part2_all.to_stata('part2.dta', version=119, write_index=False)
part3_all.to_stata('part3.dta', version=119, write_index=False)


# Merge the different parts of the EPIC files
merge_1 = pd.merge(part1_all,
                   part2_all,
                   left_on=['mrn','note id'],
                   right_on=['mrn', 'note id'],
                   how='outer')

merged = pd.merge(merge_1,
                  part3_all,
                  left_on=['mrn','note id'],
                  right_on=['mrn', 'note id'],
                  how='outer')

merged.sort_values(['mrn', 'note id', 'note time'], ascending=True, inplace=True)

merged.drop_duplicates(['mrn', 'note id'],inplace=True)

# merged[['mrn', 'note id','note time']][merged['mrn']=='E796050']

merged.shape

merged.dropna(how='all', axis=1, inplace=True)

merged.to_stata('parts1-3.dta', version=119, write_index=False)

merged.columns.tolist()