#' Reactable theme following Rijksoverheid huisstijl.
#' @description
#' Creates a `reactableTheme` object with table styling according to the
#' Rijksoverheid huisstijl.
#'
#' @importFrom ROvis.utils ro_check_if_font_available
#'
#' @param base_family Character. Font family to use for table text. Default is
#'   "RijksoverheidSansWebText". If not installed, Verdana is used, then Arial,
#'   then the first font found on your device, whichever is installed first.
#' @param sorting Logical. If `TRUE`, extra space is added to the right
#'   in the column header for sort arrows. Default `FALSE`.
#'
#' @return A `reactable::reactableTheme` object.
#' @export
#' @family reactable
ro_reactable_theme <- function(
    base_family = "RijksoverheidSansWebText",
    sorting = FALSE
) {
  check_string(base_family)

  base_family <- ro_check_if_font_available(
    target_font_family = base_family
  )

  header_padding <- if (sorting) "10px" else "3px"

  reactable::reactableTheme(
    tableStyle = list(
      border = "1px solid #bababa",
      borderCollapse = "collapse",
      fontFamily = base_family
    ),
    headerStyle = list(
      fontFamily = base_family,
      fontWeight = "normal",
      fontStyle = "normal",
      fontSize = "13px",
      textAlign = "right",
      paddingTop = "1px",
      paddingBottom = "1px",
      paddingLeft = "3px",
      paddingRight = header_padding,
      borderBottom = "1px solid #222222",
      borderLeft = "none",
      borderRight = "none",
      borderTop = "none"
    ),
    cellStyle = list(
      fontFamily = base_family,
      fontWeight = "normal",
      fontStyle = "normal",
      fontSize = "13px",
      textAlign = "right",
      paddingTop = "1px",
      paddingBottom = "1px",
      paddingLeft = "3px",
      paddingRight = "3px",
      border = "none"
    )
  )
}

#' Custom CSS for reactable tables
#'
#' @description
#' Returns a Shiny tags object with custom CSS for reactable tables,
#' with table styling according to the Rijksoverheid huisstijl.
#'
#' @importFrom shiny tags HTML
#'
#' @param sorting Logical. If `TRUE`, custom sorting arrows are shown in the
#'   column headers. If `FALSE`, only the default arrows are hidden.
#'   Default `TRUE`.
#'
#' @return A `shiny.tag` with a `<head>` tag that contains custom CSS
#'   for reactable tables.
#' @export
#' @family reactable
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(reactable)
#'
#' ui <- tagList(
#'   tags$html(
#'     lang = "en",
#'     tags$head(
#'       tags$title("Reactable table")
#'     ),
#'     tags$body(
#'       fluidPage(
#'
#'         # Apply the custom reactable CSS theme
#'         ro_reactable_css(sorting = FALSE),
#'
#'         tags$div(
#'           id = "table-title",
#'           role = "heading",
#'           "Description title of the table"
#'        ),
#'
#'         tags$div(
#'          id = "table-info",
#'           class = "sr-only",
#'           textOutput("table_info")
#'         ),
#'
#'         tags$div(
#'           id = "table-wrapper",
#'           role = "table",
#'           `aria-labelledby` = "table-title",
#'           `aria-describedby` = "table-info",
#'           reactableOutput("mytable")
#'         )
#'       )
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'   # data
#'   data <- iris
#'
#'   # Description for screen readers
#'   output$table_info <- renderText({
#'     paste("Table with ", nrow(data), "rows and ", ncol(data), "columns.")
#'   })
#'
#'   # Render the reactable table
#'   output$mytable <- renderReactable(
#'     reactable(
#'       data,
#'       defaultColDef = colDef(align = "right", sortable = FALSE),
#'       theme = ro_reactable_theme(sorting = FALSE)
#'     )
#'   )
#'
#' }
#'
#' shinyApp(ui, server)
#' }

ro_reactable_css <- function(sorting = FALSE) {
  arrow_css <- if (sorting) {
    "
    /* Hide the extra sort arrow span */
    .reactable .rt-th .rt-sort-left {
      display: none !important;
    }

    /* Custom sorting arrows based on aria-sort */
    .reactable .rt-th {
      position: relative;
      cursor: pointer;
    }

    /* Unsorted: double arrow */
    .reactable .rt-th[aria-sort='none']::after,
    .reactable .rt-th:not([aria-sort])::after {
      content: '\\2195';
      position: absolute;
      right: 4px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 16px;
      line-height: 1;
      color: #888888;
    }

    /* Ascending: up arrow */
    .reactable .rt-th[aria-sort='ascending']::after {
      content: '\\2191';
      position: absolute;
      right: 4px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 16px;
      line-height: 1;
      color: #44688f;
      font-weight: 700;
    }

    /* Descending: down arrow */
    .reactable .rt-th[aria-sort='descending']::after {
      content: '\\2193';
      position: absolute;
      right: 4px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 16px;
      color: #44688f;
      font-weight: 700;
    }
    "
  } else {
    "
    /* Hide the extra sort arrow span */
    .reactable .rt-th .rt-sort-left {
      display: none !important;
    }
    "
  }

  shiny::tags$head(
    shiny::tags$style(
      shiny::HTML(paste0(
        "
         /* Visually hidden class for screen readers */
          .sr-only {
          position: absolute;
          width: 1px;
          height: 1px;
          padding: 0;
          margin: -1px;
          overflow: hidden;
          clip: rect(0, 0, 0, 0);
          border: 0;
        }

        /* Caption styling (if a caption is used) */
        .reactable .rt-table caption {
          caption-side: top;
          text-align: right;
          font-weight: normal;
          font-style: normal;
          font-size: 14px;
          padding: 1px 3px;
          color: #505050;
        }

        /* Vertical line after first column header */
        .reactable .rt-thead .rt-tr > .rt-th:first-child {
          border-right: 1px solid #222222 !important;
        }

        /* Vertical line after first column in body */
        .reactable .rt-tbody .rt-tr-group .rt-tr > .rt-td:first-child {
          border-right: 1px solid #222222 !important;
        }

        /* Zebra striping */
        .reactable .rt-tbody .rt-tr-group:nth-child(odd) {
          background-color: #f2f2f2;
        }
        .reactable .rt-tbody .rt-tr-group:nth-child(even) {
          background-color: #ffffff;
        }

        /* Hover effect */
        .reactable .rt-tbody .rt-tr-group:hover {
          background-color: #44688f;
          color: #ffffff;
        }

        /* Selected row */
        .reactable .rt-tr-group.rt-selected,
        .reactable .rt-tr-group.rt-selected .rt-td {
          background-color: #44688f !important;
          color: #ffffff !important;
        }

        /* Focus indicators: table cells & header */
        .reactable .rt-td:focus,
        .reactable .rt-th:focus {
          outline: 2px dotted #000 !important;
          box-shadow: none !important;
          border: none !important;
        }

        /* Pagination buttons */
        .reactable .rt-pagination button:focus,
        .reactable .rt-pagination button:focus-visible {
          outline: 2px dotted #000 !important;
          outline-offset: 2px !important;
          box-shadow: none !important;
        }
        .reactable .rt-pagination button[aria-current='page'] {
          border: 2px solid #949494 !important;
        }
        ",
        arrow_css
      ))
    )
  )
}
