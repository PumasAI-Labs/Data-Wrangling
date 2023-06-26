# We often want to retrieve only certain parts of a DataFrame
df = CSV.read("demographics.csv", DataFrame) # Load the demographics dataset from before

# Columns
names(df) # Get all column names

## Get a single column as a vector
df.AGE # DataFrame.column_name
df.WEIGHT 

df[!, "AGE"] # Indexing, as if it was a matrix
df[!, "WEIGHT"]

## Get multiple columns
df[!, ["AGE", "WEIGHT"]] # This gets messy quickly

### @select macro
using DataFramesMeta # You don't need to import DataFrames if you import DataFramesMeta

@select df :AGE :WEIGHT # We use Symbols instead of Strings
@select(df, :AGE, :WEIGHT) # We can also call it in a similar way to functions

@select df begin # block syntax, probably the best alternative for multiple columns
    :ID
    :AGE
    :WEIGHT    
end

## Tip: select columns the other way around
@select df $(Not([:AGE, :WEIGHT])) # Get all columns, except the ones we specify

# Rows
## Indexing
df[1:10, ["AGE", "WEIGHT"]] # Get the first 10 rows
df[4:16, All()] # Get rows 4 to 16 for all columns

## The @subset macro
## Allows selecting rows based on conditional statements
@subset df :AGE .> 60 # Get all subjects that are more than 60 years old

# You can also have multiple conditions
@subset df begin
    :AGE .> 60
    :ISMALE .== 1 # Get males only
    :WEIGHT .< 50 # Get subjects that weigh less than 50 kg
end

## Tip: use rsubset instead of broadcasting everything (.>, .==, etc.)
@rsubset df begin
    :AGE > 60
    :ISMALE == 1
    :WEIGHT < 50
end

## You don't always want to use rsubset
@rsubset df :WEIGHT > mean(:WEIGHT)
@subset df :WEIGHT .> mean(:WEIGHT)

## Common use case: remove rows that have missing values in one column
df_iv = DataFrame(readstat("iv_bolus_sd.xpt"))
@rsubset df_iv !ismissing(:conc)