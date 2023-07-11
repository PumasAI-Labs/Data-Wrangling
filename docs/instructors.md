---
title: Instructor's Notes for Pumas-AI Data Wrangling Workshop
---

[![CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-sa/4.0/)

Start with `01-files.jl`, which covers file handling in Julia. Begin by emphasizing the significance of working in the correct 
directory before reading or writing data and how omitting this consideration could lead to errors. Show how to use the `pwd` function to verify the present 
working directory and how to use `cd` to navigate to another directory if needed. Some users might find it more convenient to right click on the file and use
the `Julia: Change to This Directory` option, which will automatically move the Julia REPL to the directory containing the selected file. If there are 
participants who know how to use shell commands, you can mention how to enter the `shell>` mode in the REPL by typing `;`. Next, focus on the CSV format. Make 
sure to highlight the importance of this format and provide an in-depth explanation of how to read and write CSV files to the present working directory and 
to a different data folder. One of the examples provided involves using the `rename` function, so make sure to go over how it can be used to change column names 
in a `DataFrame`.

Next, go over the use of the `XLSX.jl` package to read Excel files. Start by explaining how to read an Excel file using `XLSX.readtable`, emphasizing that it is 
required to provide the sheet name as an argument and that most of the time, you will want to convert the output from `XLSX.readtable` to a `DataFrame`. 
There may be questions about what to do if the user doesn't know the sheet names, which you can address by showing how to use `XLSX.readxlsx` and
`XLSX.sheetnames` to obtain a list of sheet names in an Excel file. You might also find it useful to demonstrate how to open an Excel file inside of 
VS Code (using the Office Viewer extension, which is installed by default in JuliaHub). Once you have covered how to read files, show how to write files. Make 
sure to mention that `XLSX.jl` will not override an existing file like `CSV.jl` would. Instead, you will get an error if you try to create a file that 
already exists.

The last topic for `01-files.jl` is SAS files (`.sasb7dat` and `.xpt`), which can be read using the `readstat` function from the `ReadStatTables.jl` package. 
However, note that the current version of `ReadStatTables.jl` only supports reading files, and write support is still experimental.

Next, go over the contents of `02-select.jl`. First, discuss the `names` function, which allows us to obtain a `Vector` containing all the column 
names of a `DataFrame`, which could be useful when working with `DataFrames` that have a large number of columns. After that, show the different alternatives
that there are to retrieve the contents of a single column (dot syntax such as `DataFrame.column_name` and indexing). Participants might be curious about the
difference between these two methods. If that is the case, you can explain that the dot syntax is simpler and more convenient to type, but that indexing is more 
flexible and powerful. Additionally, some users could find the indexing syntax more intuitive, even if it is more verbose.

Afterward, showcase how to select specific columns from a `DataFrame` using the `@select` macro provided by `DataFramesMeta.jl`. This will be the first
time in the workshop in which attendees will use `DataFramesMeta.jl`, so you can take this opportunity to provide a brief overview of the package and its 
importance. Make sure to mention that `DataFramesMeta.jl` imports the contents of `DataFrames.jl`, so it's not necessary to import `DataFrames.jl` if `DataFramesMeta.jl`
has already been imported. Lastly, demonstrate the use of the `Not` operator as a means to specify the columns that we **don't** want to select, which might
be useful in cases where there is a large number of columns and we want to select most of them.

Finally, cover the `@[r]subset` macro, which enables us to filter rows in a `DataFrame` based on specific conditions. Go over the differences between `@subset`
and `@rsubset` in detail, as this concept will be used in the scripts that follow. Finish this part of the lesson by going over the common use case of removing
rows with `missing` observations in a specific column.

The next script in the workshop is `03-transform.jl`, which focuses on using the `@[r]transform` macro to create a new column in a `DataFrame` or modify an 
existing one. Once again, it is important to explain the difference between the column and row versions of the macro (`@transform` and `@rtransform`, 
respectively) and demonstrate how the latter provides a more convenient way of specifying column transformations whenever possible.

After that, introduce the `@astable` macro, which enables accessing intermediate calculations within a `DataFramesMeta.jl` macro call. This macro allows performing 
operations on multiple columns simultaneously, making it easier to apply complex transformations and computations that would otherwise be challenging to write 
and comprehend.

Lastly, cover the mutating version of the macros, which allow direct modification of the original `DataFrame`. Make sure to explain that these macros can be 
accessed by appending an exclamation mark (`!`) at the end of the macro call, such as `@[r]transform!` or `select!`. This feature is particularly handy when 
there is a need to update or transform data in-place, eliminating the requirement for creating additional copies of the `DataFrame`.

Move on to the `04-grouping.jl` script. Begin by showing the `groupby` function, which allows grouping data based on specific columns. Next, show the common
pattern of using `groupby` together with `@combine` to apply operations on grouped data and generate aggregated results. Make sure to go over the examples and
cover the cases where one or more columns are used to group data. One of the examples includes the use of the `@orderby` macro, so take this opportunity to
provide a detailed explanation of how it works.

Once participants are comfortable with using `groupby` and `@combine`, you can introduce the `@by` macro, which provides a concise alternative to using 
`groupby` and `@combine` by streamlining the process of grouping data and applying operations in a single call. Use the example provided in the script to show a 
direct comparison between the methods and mention how using `@by` simplifies the code and enhances readability.

The last script of the workshop is `05-chaining.jl`. This script provides two examples of how to use the `@chain` macro to perform all data wrangling operations
in a single block. Go over the examples and highlight how it can be more convenient than applying all the data wrangling operations separately. Some important
points to mention here are that it is not necessary to pass the `DataFrame` as an argument inside the `@chain` block, and that it is not restricted to including
`DataFramesMeta.jl` macros (it can also include functions from `DataFrames.jl` such as `rename`).

## Get in touch

If you have any suggestions or want to get in touch with our education team,
please send an email to <training@pumas.ai>.

## License

This content is licensed under [Creative Commons Attribution-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-sa/4.0/).

[![CC BY-SA 4.0](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)
