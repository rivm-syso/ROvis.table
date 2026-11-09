# datatable table to be used with DT

![\[DT\]](figures/group-DT.svg)  
  
Rendering an accessible, keyboard-navigable (with customJS) data table
table with options for sorting and page length.

## Usage

``` r
ro_dt_table(data, caption, sorting = FALSE, pagelength = 10)
```

## Arguments

- data:

  Data frame or tibble. The data to display in the table.

- caption:

  Character. Table caption/title (displayed above the table).

- sorting:

  Logical. Should column sorting be enabled? Default is `FALSE`.

- pagelength:

  Integer. Number of rows to display per page. Default is `10`.

## Value

data table html

## See also

Other DT:
[`ro_dt_theme()`](https://rivm-syso.github.io/ROvis.table/reference/ro_dt_theme.md)

## Examples

``` r
# In your Shiny server:
if (interactive()) {
ro_dt_table(
  data = my_data,
  caption = "Aantal gevallen per groep",
  sorting = TRUE,
  pagelength = 20
)
}
```
