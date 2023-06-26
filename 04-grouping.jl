# Some times we want to group our data and apply operations according to that grouping
df = CSV.read("demographics.csv", DataFrame) # Load a fresh copy of our dataset

# The groupby function
groupby(df, :ISMALE) # Group subjects according to sex

## More complicated example: transform + group
@rtransform! df :WEIGHT_cat = :WEIGHT > 70 ? "Over 70 kg" : "Under 70 kg"
groupby(df, :WEIGHT_cat)

## Tip: groupby can take multiple columns
groupby(df, [:ISMALE, :WEIGHT_cat]) # Now we get 4 groups

# Combining
## A common thing to do after grouping data is to combine it back with some operation.

# Example: mean age for each sex group
grouped_df = groupby(df, :ISMALE)
@combine grouped_df :AGE = mean(:AGE)

# You can also use DataFrames that have been grouped with multiple columns
combined_df = @combine groupby(df, [:WEIGHT_cat, :ISMALE]) :AGE = mean(:AGE)
@orderby combined_df :ISMALE # Fix awkward ordering with @orderby
@orderby combined_df :ISMALE :WEIGHT_cat # Use multiple columns in @orderby 

## Tip: you can include multiple calculations inside of @combine
@combine grouped_df begin
    :AGE = mean(:AGE)
    :WEIGHT = mean(:WEIGHT)
end

# the @by macro: groupby + @combine in one call
@by df :ISMALE begin
    :AGE = mean(:AGE)
    :WEIGHT = mean(:WEIGHT)
end