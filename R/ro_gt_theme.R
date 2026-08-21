#' Use a standardized theme for gt tables
#'
#' @description
#' `r ROvis.utils::ro_group_badge('gt')`
#' This function implements a stylized theme for gt tables.
#'
#' @importFrom gt gt tab_options cols_align sub_missing opt_row_striping
#'   tab_style cells_title cell_text cells_column_labels cells_row_groups
#'   cells_body everything where px
#' @importFrom systemfonts system_fonts
#' @importFrom ROvis.utils ro_color
#'
#' @param df  Dataframe.
#' @param ROfont Default is FALSE, will change to TRUE for next major release (1.0.0).
#'  If Rijksoverheid font is not available on your device, Verdana will be used.
#' @param ... For internal use. Leave empty.
#' @family gt
#' @return gt table object.
#' @export
#'
#' @examples
#' \dontrun{
#' ro_gt_theme(df)
#' }
ro_gt_theme <- function(df, ROfont = FALSE, ...) {
  # add check if df is a dataframe
  check_data_frame(df)
  check_bool(ROfont)

  if (
    ROfont &&
      "RijksoverheidSansWebText" %in% system_fonts()$family
  ) {
    font <- "RijksoverheidSansWebText"
  } else {
    font <- "Verdana"
  }

  gt(df, ...) |>
    # add styling for title cells
    tab_style(
      locations = cells_title(groups = "title"),
      cell_text(
        color = ro_color("lintblauw"),
        weight = "bold"
      )
    ) |>
    # here is some extra text
    tab_style(
      locations = cells_title(groups = "subtitle"),
      cell_text(
        color = "black",
        style = "italic",
        font = font
      )
    ) |>
    tab_style(
      cell_text(
        weight = "bold",
        color = "black",
        font = font
      ),
      locations = cells_column_labels(everything())
    ) |>
    # adjust styling for the row groups labels
    tab_style(
      locations = cells_row_groups(groups = everything()),
      cell_text(
        font = font,
        weight = "bold"
      )
    ) |>
    # adjust styling for the body of the table
    tab_style(
      locations = cells_body(
        columns = everything(),
        rows = everything()
      ),
      cell_text(font = font)
    ) |>
    # Include row stripes
    opt_row_striping(
      row_striping = TRUE
    ) |>
    # Fill empty cells with "-"
    sub_missing(
      columns = everything(),
      missing_text = "-"
    ) |>
    # Right align all numeric columns
    cols_align(
      align = "right",
      columns = where(is.numeric)
    ) |>
    # remove column labels and add other styling options
    tab_options(
      heading.align = "left",
      heading.title.font.size = px(20),
      heading.title.font.weight = "bold",
      heading.padding = px(4),
      table_body.hlines.style = "none",
      table.border.top.style = "hidden",
      column_labels.hidden = FALSE,
      column_labels.border.bottom.width = px(2),
      column_labels.padding.horizontal = px(8),
      row_group.padding = px(10),
      row_group.border.top.width = px(0),
      row_group.border.bottom.width = px(5),
      row_group.padding.horizontal = px(0)
    )
}
