# Apply some transformation to one or more columns in our data
include("02-select.jl")

# Change the sex encoding (ISMALE)
df
@transform df :SEX = [i == 0 ? "Female" : "Male" for i in :ISMALE] # Create a new column
@transform df :ISMALE = [i == 0 ? "Female" : "Male" for i in :ISMALE] # Modify an existing column

## Tip: use @rtransform to avoid specifying the entire column at once
@rtransform df :SEX = :ISMALE == 0 ? "Female" : "Male"
@rtransform df :ISMALE = :ISMALE == 0 ? "Female" : "Male"

# You can also apply multiple transformations at once
@rtransform df begin
  :ISMALE = :ISMALE == 0 ? " Female" : "Male"
  :AGE = Int(round(:AGE, digits = 0)) # Round age to an integer
  :AGE_months = :AGE * 12 # Calculate age in months
end

# Notice that our age in months was not computed from the rounded version of the AGE column
## We have to use @astable to be able to use intermediate results
@rtransform df @astable begin
  :AGE = Int(round(:AGE, digits = 0))
  :AGE_months = :AGE * 12
end

# Modify the original DataFrame
@rtransform df :SEX = :ISMALE == 0 ? "Female" : "Male" # Creates a new DataFrame
df # Our original DataFrame remains unchanged

@rtransform! df :SEX = :ISMALE == 0 ? "Female" : "Male" # Use ! at the end to modify the source
df # Watch out: we lost the original DataFrame (we would have to reread our source file)

## Tip: this works for all of DataFramesMeta.jl's macros
@rsubset! df :SEX == "Female"
df # Now we only have female subjects

@select! df :AGE :WEIGHT :SEX
df # Now we lost the rest of the columns
