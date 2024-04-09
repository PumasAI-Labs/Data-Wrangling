# Reading and writing external files

## CSV: probably the most common type of data file you will find
using CSV
using DataFrames

# Note: go to the workshop directory before reading the CSV file
# by right-clicking on the desired directory and selecting
# `Julia: Change to this directory
df = CSV.read("demographics.csv", DataFrame) # read(<filepath>, <sink>)

# Writing files
## As an example, let's change some column names and then save it
renamed_df = rename(df, Dict("AGE" => "AGE (years)", "WEIGHT" => "WEIGHT (kg)"))

## Tip: you can rename columns programmatically by passing a function
lowercase_df = rename(lowercase, df) # Make all columns be lowercase

# Now we are ready to save the new file
CSV.write("demographics_new.csv", renamed_df) # write(<filepath>, <DataFrame>)
# CSV.write("demographics.csv", renamed_df) # Watch out: This would overwrite our original dataset

# Check our new files using VS Code

## Tip: you can read/save data to a folder
CSV.write("data/demographics_new.csv", renamed_df)
CSV.read("data/demographics_new.csv", DataFrame)

## Custom specifications (keyword arguments):
readlines("demographics_eu.csv")[1:3]
readlines("demographics.csv")[1:3] # Standard format

# - delim: CSV files are separated by commas most of the time, but sometimes other
#   characters like ';' or '\t' are used.
CSV.read("demographics_eu.csv", DataFrame; delim = ';') # Works, but the numbers were parsed as strings

# - decimal: if the file contains Floats and they are separated by something different than
#   '.' (e.g 3.14), you must specify which character is used. If you ever need to use this, 
#   it will probably be because decimals are separated by commas (e.g 3,14)
CSV.read("demographics_eu.csv", DataFrame; delim = ';', decimal = ',')

# You can also use these keyword arguments to write files
CSV.write("demographics_eu_new.csv", renamed_df; delim = ';', decimal = ',')
readlines("demographics_eu_new.csv")[1:3]

# There are many more options: https://csv.juliadata.org/stable/reading.html#CSV.read

## Excel (.xlsx)
using XLSX

# Reading files
excel_file = XLSX.readtable("demographics.xlsx", "Sheet1") # readtable(<filepath>, <sheetname>)
df_excel = DataFrame(excel_file) # You will most definitely want to convert it to a DataFrame

## Tip: get all sheets from an Excel file
file = XLSX.readxlsx("demographics.xlsx") # You can see Sheet1 here
XLSX.sheetnames(file) # You can get a vector of sheet names too

## Tip: you can also use index numbers to refer to sheets
DataFrame(XLSX.readtable("demographics.xlsx", 1)) # We get the first sheet

# You can also read XLSX files from a folder
DataFrame(XLSX.readtable("data/demographics.xlsx", "Sheet1"))

# Allow XLSX to infer types (columns will be Any by default)
DataFrame(XLSX.readtable("demographics.xlsx", "Sheet1"; infer_eltypes = true)) # You will most definitely want to infer the columns types

# Writing files
XLSX.writetable("demographics_new.xlsx", renamed_df) # Same syntax as CSV.write (<filepath>, <DataFrame>)
XLSX.writetable("data/demographics_new.xlsx", renamed_df) # Save to a folder

## Watch out: if you try to write a file that already exists, you will get an error
XLSX.writetable("demographics_new.xlsx", lowercase_df) # Won't overwrite, like CSV would

## SAS files
using ReadStatTables

# Reading files
## .sas7bdat
DataFrame(readstat("iv_bolus_sd.sas7bdat"))
## .xpt
DataFrame(readstat("iv_bolus_sd.xpt"))

## Note: ReadStatTables supports other file formats: 
## https://junyuan-chen.github.io/ReadStatTables.jl/stable/#Supported-File-Formats

# Writing files
## Currently, ReadStatTables only supports reading files (writing is experimental only)

##############################################################################################
# Optional: run this to delete all the files created in the examples
begin
    root_files = filter(contains("new"), readdir())
    data_files = joinpath.("data", filter(contains("new"), readdir("data")))
    foreach(rm, vcat(root_files, data_files))
end
