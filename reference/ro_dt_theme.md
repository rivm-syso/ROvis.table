# Custom DT Table CSS Styling

![\[DT\]](figures/group-DT.svg)  
  
Returns a Shiny tags object containing custom CSS styles for DT tables,
following preliminary Rijksoverheid huisstijl.

## Usage

``` r
ro_dt_theme(base_family = "RijksoverheidSansWebText", sorting = FALSE)
```

## Arguments

- base_family:

  Character. Font family to use for table text. Default is
  "RijksoverheidSansWebText". If not installed, Verdana is used, then
  Arial, then the first font found on your device, whichever is
  installed first.

- sorting:

  Logical. If `TRUE`, column headers are moved, to make space for
  arrows. if `FALSE`, right-aligned. Default is `FALSE`.

## Value

A `shiny.tags` object with a `<head>` tag containing custom CSS for DT
tables.

## See also

Other DT:
[`ro_dt_table()`](https://rivm-syso.github.io/ROvis.table/reference/ro_dt_table.md)

## Examples

``` r
if (interactive()) {
  ui <- fluidPage(
    ro_dt_theme(sorting = FALSE),
    DTOutput("mytable")
  )
  server <- function(input, output, session) {
    output$mytable <- renderDT(datatable(iris, rownames = FALSE, options(list(ordering=FALSE))))
  }
  shinyApp(ui, server)
}
```
