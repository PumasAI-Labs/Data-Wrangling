# Perform all your data wrangling operations in one block with @chain
df = CSV.read("demographics.csv", DataFrame)

# Get ages for all female subjects
@chain df begin
  @rsubset :ISMALE == 0
  @select :ID :AGE # We didn't have to pass df as an argument
end

# More complicated example
@chain df begin

  @rtransform begin
    :SEX = :ISMALE == 0 ? "Female" : "Male" # Create the new sex column
    :WEIGHT_cat = :WEIGHT > 70 ? "Over 70 kg" : "Under 70 kg" # Create weight categories
  end

  @by [:SEX, :WEIGHT_cat] begin # Calculate mean values for each column
    :AGE = mean(:AGE)
    :SCR = mean(:SCR)
    :eGFR = mean(:eGFR)
    :n = length(:AGE)
  end

  @orderby :SEX :WEIGHT_cat # Fix ordering

  # Make column names more readable
  rename(Dict(:SEX => :Sex, :WEIGHT_cat => :Weight, :AGE => :Age))

end
