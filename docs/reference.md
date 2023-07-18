---
title: Reference Sheets for Pumas-AI Data Wrangling Workshop 
---

[![CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-sa/4.0/)

## Key Points

- Before reading or writing data, make sure that you are in the correct directory. You can check the present working directory with the `pwd` function, 
and you can navigate to another directory using `cd`.
- You can enter the `shell>` mode in the REPL by typing `;`, which enables you to execute system shell commands (e.g., `pwd`, `cd`, `mkdir`, etc.).
- There are various data formats, but CSV is one of the most commonly used formats.
- To read a CSV file, you can use the `CSV.read` function, and to create or write a CSV file, you can use the `CSV.write` function.
- The `CSV.read` function takes two arguments: a file path and a sink. In most cases, you will use `DataFrame` as the sink.
- The `rename` function allows you to change the column names of a `DataFrame`.
- In some cases, CSV files may not use commas for separation. If that is the case, you can use the `delim` keyword argument to specify 
the character used in your file.
- In some regions, commas are used to separate decimals instead of dots (e.g., `3,14` instead of `3.14`). In such cases, columns containing 
`Float`s will be interpreted as `String`s. To avoid this, you can use the `decimal` keyword argument.
- The `XLSX.jl` package enables reading and writing of Excel files (`.xlsx`). To read a file, you can use the `XLSX.readtable` function, and to write a file, 
you can use `XLSX.writetable`.
- When using `XLSX.readtable`, you need to specify the sheet you want to read from since Excel files can have multiple sheets. If you are unsure 
about the sheets in the Excel file, you can use `XLSX.readxlsx` and `XLSX.sheetnames` to obtain a `Vector` containing all the sheet names.
- SAS files (`.sasb7dat` and `.xpt`) can be read using the `readstat` function provided by the `ReadStatTables.jl` package.
- Currently, `ReadStatTables.jl` only supports reading files. Write support is experimental and not fully developed.
- You can read and write files from different locations by providing the full or relative path instead of just the file name. For more information on 
specifying robust and complex file paths, refer to the [Filesystem](https://docs.julialang.org/en/v1/base/file/#Filesystem) section in the Julia documentation.
- To obtain a `Vector` with all the column names of a `DataFrame`, you can use the `names` function. This is particularly useful when examining 
`DataFrame`s with a large number of columns.
- `DataFramesMeta.jl` imports `DataFrames.jl`, allowing you to import only `DataFramesMeta.jl` and still have access to the functions from `DataFrames.jl`.
- You can select a group of columns from a `DataFrame` using the `@select` macro provided by `DataFramesMeta.jl`.
- Instead of specifying which columns you want to select, you can specify the columns that you **don't** want to select using the `Not` operator,
which need to be called with `$()` (e.g. `@select <DataFrame> $(Not(column_name))`).
- You can select the rows in a `DataFrame` that satisfy a condition using the `@[r]subset` macro.
- The row version of a `DataFramesMeta.jl` macro can be accessed by adding an `r` before the macro name (e.g., `@rsubset`, `@rtransform`, etc.). 
These versions are useful as they eliminate the need to broadcast all operations inside the call, but there are cases where it is not possible to do so.
- To remove rows that have `missing` values in a column, you can use `@rsubset <DataFrame> !ismissing(:column_name)`.
- The `@[r]transform` macro allows you to create a new column or modify an existing one.
- The `@astable` macro enables access to intermediate calculations within a `DataFramesMeta.jl` macro call and allows operations on multiple columns simultaneously.
- By appending `!` at the end of a macro call (e.g., `@[r]transform!` or `select!`), you can modify the original `DataFrame` instead of creating a new one.
- The `groupby` function is used to group data in a `DataFrame` based on specific columns. When used together with `@combine`, it enables 
applying operations on grouped data and generating new aggregated results.
- The `@by` macro provides a concise alternative to using `groupby` and `@combine`. It allows grouping data and applying operations in a single call.
- Including `length(:column)` in a `@combine` or `@by` call will return the number of rows in each grouped `DataFrame` as part of the aggregated results. 
The column name used does not affect the results.
- You can perform all your data wrangling operations in a single block using `@chain`. This block can include both `DataFramesMeta.jl` macros and functions 
such as `rename`. Additionally, `@chain` passes the `DataFrame` as an argument to every function and macro call. For example, inside a `@chain` block, 
you can write `@groupby <column>` instead of `@groupby <DataFrame> <column>`.

## Summary of Basic Commands

| Action                                    | Command                              | Observations                                    |
|-------------------------------------------|--------------------------------------|-------------------------------------------------|
| Get the current working directory         | `pwd()`  | Equivalent to running `pwd` in the shell | 
| Change the current working directory      | `cd(<path>)` | Equivalent to running `cd <path>` in the shell |
| Enter the `shell>` mode in the Julia REPL | Type `;` in the REPL | |
| Read a CSV file                           | `CSV.read(<filepath>, <sink>)` | The sink argument will be a `DataFrame` most of the time |
| Write a CSV file                          | `CSV.write(<filepath>, <DataFrame>)` | |
| Change the column names | `rename(<DataFrame>, <Dict>)` or `rename(<function>, <DataFrame>)` | Using the function version can be useful to apply the same type of change to all the columns in the `DataFrame` |
| Read an Excel file | `DataFrame(XLSX.readtable(<filepath>, <sheet>))` | |
| Write an Excel file | `XLSX.writetable(<filepath>, <DataFrame>)` | |
| Inspect the sheet names of an Excel file | `XLSX.readxlsx(<filepath>)` and `XLSX.sheetnames(<result of readxlsx>)` (optional) | The result of `XLSX.readxlsx` will print a table containing the sheet names. You can optionally then run `XLSX.sheetnames` on the result of `readxlsx` to get a `Vector` with all the sheet names |
| Read a SAS file (.sasb7dat and .xpt) | `DataFrame(readstat(<filepath>))` | | | 
| Get the column names of a `DataFrame` | `names(<DataFrame>)` | | |
| Get the values from a `DataFrame`'s column | `DataFrame.column_name`, `DataFrame[!, column_name]` or `DataFrame[:, column_name]` | The dot syntax is more readable and easier to type, but the indexing syntax could be more intuitive for some users. Using `:` when indexing returns a copy of the column, while using `!` returns the original column from the `DataFrame` (you could use the result of indexing with `!` to modify the source `DataFrame`) |
| Select one or more columns from a `DataFrame` | `@select <DataFrame> column1 column2 ...` | Can also be done through indexing, but the `@select` macro is more convenient and expressive |
| Use the row version of a `DataFramesMeta.jl` macro | `@r<macro>` (e.g `@rsubset`, `@rtransform`, etc.) | |
| Filter rows in a `DataFrame` using a boolean expression | `@[r]subset <DataFrame> <expression>` | |  
| Determine whether a variable is of `Type` `Missing` | `ismissing(<var>)` | Can be used with `@[r]subset` to remove missing values from a `DataFrame` | 
| Create or modify a column | `@[r]transform <DataFrame> <expression>` | The expression is written in the assignment form (e.g. `:column_name = <column value>`). If you want to create a new column, then the assignment should be for a column name that doesn't exist in the `DataFrame`. If you use an existing column name, `@[r]transform` will modify that column. |  
| Access intermediate calculations and manipulate multiple columns at the same time | Include `@astable` inside a macro call | Should be included before the expressions corresponding to the macro call (e.g. `@[r]transform <DataFrame> @astable <expression>`) |
| Use the in-place (mutating) version of a macro | Add `!` add the end (e.g `@[r]transform!`) | This will apply the changes to the original `DataFrame`, instead of creating a new one |
| Group data in a `DataFrame` according to one or more columns | `groupby(<DataFrame>, <columns>)` | If you want to use more than one column, `<columns>` should be a `Vector` of column names |  
| Apply operations on a grouped `DataFrame` to create aggregated results | `@combine <DataFrame> <expressions>` | |
| Group a `DataFrame` and apply operations to create aggregated results | `@by <DataFrame> <grouping columns> <expressions>` | It is equivalent to `groupby(<DataFrame>, <grouping columns>)` and then `@combine <grouped DataFrame> <expessions>` |
| Perform all data wrangling operations in a single block | `@chain <DataFrame> <block>` | It is not necessary to pass the `DataFrame` as an argument to the macros and functions used inside of the `@chain` block | 

## Glossary

CSV files

: CSV stands for **C**omma-**S**eparated **V**alues. It is a popular file format that uses lines to represent rows (observations)
and commas (`,`) to separate values (although other characters such as `;` can also be used).

Sink (from `CSV.read`)

: It is the second positional argument from `CSV.read` and is used to specify where to store or materialize the parsed data from the CSV file.
Most of the time you will want to set use a `DataFrame` (`CSV.read(<filename>, DataFrame)`)

Excel

: Excel is a widely used spreadsheet program developed by Microsoft. Excel files typically have the `.xls` and `.xlsx` extensions, but the `.xlsx` extension
should be preferred.

SAS data files

: Data format used and created by the SAS statistical software. They come in two common extensions: `.sas7bdat` and `.xpt`. These files can be read in Julia 
using the `ReadStatTables.jl` package.

`DataFrame`

: `DataFrame`s are a versatile and widely used data structure that represents tabular data. You can use them in Julia through the `DataFrames.jl` package.

`DataFrames.jl`

: Julia package that allows working with `DataFrames` in Julia. It has a similar design and functionality to other well-known packages such as 
[`pandas`](https://pandas.pydata.org/) from Python or [`dplyr`](https://dplyr.tidyverse.org/) from R.

`DataFramesMeta.jl`

: A powerful package in Julia that extends the functionality of `DataFrames.jl`, enabling advanced data manipulation and transformation. 
It provides a concise and expressive syntax for defining data transformations through the use of macros.

## Get in touch

If you have any suggestions or want to get in touch with our education team,
please send an email to <training@pumas.ai>.

## License

This content is licensed under [Creative Commons Attribution-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-sa/4.0/).

[![CC BY-SA 4.0](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)
