# Getting Started with ROvis.table

ROvis.table provides two ways to build accessible, Rijksoverheid-styled
tables:
[`ro_gt_theme()`](https://rivm-syso.github.io/ROvis.table/reference/ro_gt_theme.md)
for static `gt` tables, and
[`ro_dt_table()`](https://rivm-syso.github.io/ROvis.table/reference/ro_dt_table.md)
(with
[`ro_dt_theme()`](https://rivm-syso.github.io/ROvis.table/reference/ro_dt_theme.md))
for interactive, keyboard-navigable `DT` tables.

``` r

library(ROvis.table) # nolint: missing_package_linter
```

## Static tables with gt

Apply
[`ro_gt_theme()`](https://rivm-syso.github.io/ROvis.table/reference/ro_gt_theme.md)
to a `gt` table built from any data frame:

``` r

ro_gt_theme(head(mtcars, 5))
```

| mpg  | cyl | disp | hp  | drat | wt    | qsec  | vs  | am  | gear | carb |
|------|-----|------|-----|------|-------|-------|-----|-----|------|------|
| 21.0 | 6   | 160  | 110 | 3.90 | 2.620 | 16.46 | 0   | 1   | 4    | 4    |
| 21.0 | 6   | 160  | 110 | 3.90 | 2.875 | 17.02 | 0   | 1   | 4    | 4    |
| 22.8 | 4   | 108  | 93  | 3.85 | 2.320 | 18.61 | 1   | 1   | 4    | 1    |
| 21.4 | 6   | 258  | 110 | 3.08 | 3.215 | 19.44 | 1   | 0   | 3    | 1    |
| 18.7 | 8   | 360  | 175 | 3.15 | 3.440 | 17.02 | 0   | 0   | 3    | 2    |

## Interactive tables with DT

[`ro_dt_table()`](https://rivm-syso.github.io/ROvis.table/reference/ro_dt_table.md)
wraps [`DT::datatable()`](https://rdrr.io/pkg/DT/man/datatable.html)
with accessible defaults (ARIA-labelled pagination, sensible page
length). Pair it with
[`ro_dt_theme()`](https://rivm-syso.github.io/ROvis.table/reference/ro_dt_theme.md)
in a Shiny UI for consistent styling:

``` r

ro_dt_table(
  data = head(mtcars, 20),
  caption = "Motor Trend car road tests",
  sorting = TRUE,
  pagelength = 10
)
```

In a Shiny app, add
[`ro_dt_theme()`](https://rivm-syso.github.io/ROvis.table/reference/ro_dt_theme.md)
alongside your `DTOutput()`:

``` r

library(shiny)

ui <- fluidPage(
  ro_dt_theme(sorting = TRUE),
  DT::DTOutput("mytable")
)

server <- function(input, output, session) {
  output$mytable <- DT::renderDT(
    ro_dt_table(mtcars, caption = "Motor Trend car road tests", sorting = TRUE)
  )
}

shinyApp(ui, server)
```
