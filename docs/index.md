---
title: Pumas-AI Data Wrangling Workshop 
description: Template for data wrangling workshop covering data I/O and the use of DataFramesMeta.
---

[![CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-sa/4.0/)

This workshop is an **introduction to data wrangling in Julia** with a focus on data I/O and `DataFramesMeta.jl`. We will cover the following topics: 

- **Reading and writing data**:
    - CSV files
    - Excel (`.xlsx`) files
    - SAS (`.sasb7dat` and `.xpt`)

- **Select**:
    - Selecting specific columns and rows using `@select` and `@subset` macros

- **Transform**:
    - Applying transformations to one or more columns using the `@transform` macro

- **Grouping and combining**:
    - Grouping data using the `groupby` function
    - Combining groups and summarizing data using the `@combine` and `@by` macros

- **Chaining**:
    - Perform all data wrangling operations in a single block using the `@chain` macro

!!! success "Prerequisites"

    We recommend users being familiar with Julia syntax, especially variables and types.

    The formal requirements are the [Julia Syntax Workshop](https://pumasai-labs.github.io/Julia-Workshop/)
    and its pre-requisites.

## Schedule

| Time (HH:MM) | Activity                 | Description                                 |
|--------------|--------------------------|---------------------------------------------|
| 00:00        | Setup                    | Download files required for the workshop    |
| 00:25        | Reading and writing data | Showcase `01-files.jl`                      |
| 00:40        | Select                   | Showcase `02-select.jl`                     |
| 00:50        | Transform                | Showcase `03-transform.jl`                  |
| 01:00        | Grouping and combining   | Showcase `04-grouping.jl`                   |
| 01:05        | Chaining                 | Showcase `05-chaining.jl`                   |
| 01:15        | Closing remarks          | See if there are any questions and feedback |

## Get in touch

If you have any suggestions or want to get in touch with our education team,
please send an email to <training@pumas.ai>.

## Authors

- Juan José González Oneto - <j.oneto@pumas.ai>

## License

This content is licensed under [Creative Commons Attribution-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-sa/4.0/).

[![CC BY-SA 4.0](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)
