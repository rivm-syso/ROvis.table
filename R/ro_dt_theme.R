#' Custom DT Table CSS Styling
#'
#' @description
#' Returns a Shiny tags object containing custom CSS styles for DT tables,
#' following preliminary RIVM huisstijl.
#'
#' @importFrom shiny tags HTML
#' @importFrom ROvis.utils ro_check_if_font_available
#'
#' @param base_family Character. Font family to use for table text. Default is "Arial".
#' @param sorting Logical. If \code{TRUE}, column headers are left-aligned;
#'   if \code{FALSE}, right-aligned. Default is \code{FALSE}.
#'
#' @return A \code{shiny.tags} object with a \code{<head>} tag containing
#' custom CSS for DT tables.
#' @export
#' @family DT
#' @examples
#' if (interactive()) {
#'   ui <- fluidPage(
#'     ro_dt_theme(base_family = "Arial", sorting = FALSE),
#'     DTOutput("mytable")
#'   )
#'   server <- function(input, output, session) {
#'     output$mytable <- renderDT(datatable(iris, options(list(ordering=FALSE))))
#'   }
#'   shinyApp(ui, server)
#' }
#'
ro_dt_theme  <- function(
  base_family = "RijksoverheidSansWebText",
  sorting = FALSE
) {
  check_string(base_family)
  ro_check_if_font_available(base_family = base_family)

  if (sorting) {
    header_align <- "left"
  } else {
    header_align <- "right"
  }

  tags$head(
    tags$style(
      HTML(
        sprintf(
          "
          /* Override DataTables selection color variables */
          table.dataTable {
            --dt-row-selected: 68, 104, 143;
            --dt-row-selected-text: 255, 255, 255;
            --dt-row-selected-link: 255, 255, 255;
          }

          /* Base table structure */
          table.dataTable {
            border: 1px solid #bababa !important;
            border-collapse: collapse !important;
          }

          /* Caption styling */
          caption {
            caption-side: top;
            text-align: left;
            font-family: %s;
            font-weight: normal;
            font-style: normal;
            font-size: 14px;
            padding: 1px 3px;
            color: #505050;
          }

          /* Column headers: fonts, alignment, borders */
          table.dataTable thead th {
            font-family: %s;
            font-weight: normal !important;
            font-style: normal;
            font-size: 13px;
            text-align: %s !important;
            padding: 1px 3px !important;
            border-bottom: 2px solid #222222 !important;
            border-left: none !important;
            border-right: none !important;
            border-top: none !important;
          }

          /* Vertical line after first column header */
          table.dataTable.display thead th:first-child {
            border-right: 1px solid #222222 !important;
          }

          /* Table body cells: fonts, alignment, borders */
          table.dataTable tbody td {
            font-family: %s;
            font-weight: normal;
            font-style: normal;
            font-size: 13px;
            text-align: right;
            padding: 1px 3px;
            border: none !important;
          }

          /* Vertical line after first column in body */
          table.dataTable.display tbody td:first-child {
            border-right: 1px solid #222222 !important;
          }

          /* Row styling: zebra striping */
          table.dataTable.display tbody tr.odd {
            background-color: #f2f2f2 !important;
          }
          table.dataTable.display tbody tr.even {
            background-color: #fff !important;
          }

          /* Row styling: hover effect */
          table.dataTable.display tbody tr:hover {
            background-color: #44688f !important;
            color: white !important;
          }

          /* Row styling: selected row cells */
          table.dataTable tbody tr.selected td,
          table.dataTable tbody tr.selected th {
            background-color: #44688f !important;
            color: white !important;
            box-shadow: none !important;
          }

          /* Sorting arrows: contrast */
          table.dataTable thead .sorting:before,
          table.dataTable thead .sorting:after {
            color: #535353 !important;
            opacity: 1 !important;
          }

          /* Pagination: button borders */
          .dataTables_wrapper .dataTables_paginate .paginate_button.current {
            border: 2px solid #949494 !important;
          }

          /* Scroll styling: header borders */
          div.dataTables_scrollHead table.dataTable thead th {
            border-bottom: none !important;
          }
          div.dataTables_scrollHead table {
            border-bottom: none !important;
          }

          /* Scroll styling: body borders */
          div.dataTables_scrollBody table {
            border-top: none !important;
          }

          /* Scroll styling: header cell bottom line */
          table.dataTable thead th,
          table.dataTable thead td {
            border-bottom: 1px solid #222 !important;
          }

          /* Focus indicators: table cells */
          table.dataTable tbody th:focus,
          table.dataTable tbody td:focus,
          table.dataTable thead th:focus {
            outline: 2px dotted #000 !important;
            box-shadow: none !important;
            border: none !important;
          }

          /* Focus indicators: pagination buttons */
          .dataTables_paginate .paginate_button:focus,
          .dataTables_paginate .paginate_button:focus-visible {
            outline: 2px dotted #000 !important;
            outline-offset: 2px !important;
            box-shadow: none !important;
          }
          ",
          base_family,
          base_family,
          header_align,
          base_family
        )
      )
    )
  )
}
