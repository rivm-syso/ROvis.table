#' datatable table to be used with DT
#'
#' @description
#' Rendering an accessible, keyboard-navigable (with customJS) data table
#' table with options for sorting and page length.
#'
#' @importFrom DT datatable JS
#'
#' @param data Data frame or tibble. The data to display in the table.
#' @param caption Character. Table caption/title (displayed above the table).
#' @param sorting Logical. Should column sorting be enabled? Default is \code{FALSE}.
#' @param pagelength Integer. Number of rows to display per page. Default is \code{10}.
#'
#' @return data table html
#' @export
#' @family DT
#'
#' @examples
#' # In your Shiny server:
#' if (interactive()) {
#' ro_dt_table(
#'   data = my_data,
#'   caption = "Aantal gevallen per groep",
#'   sorting = TRUE,
#'   pagelength = 20
#' )
#' }
ro_dt_table <- function(data, caption, sorting = FALSE, pagelength = 10) {
  dt_df <- datatable(
    data,
    caption = caption,
    rownames = FALSE,
    selection = "none",
    options = list(
      dom = "tp",
      ordering = sorting,
      # horizontal scrollbar disabled, otherwise you will get two tables
      # which is not desirable for accessibility
      scrollX = FALSE,
      pageLength = pagelength,
      language = list(
        paginate = list(
          first = "Eerste pagina",
          previous = "Vorige pagina",
          `next` = "Volgende pagina",
          last = "Laatste pagina"
        )
      )
    ),
    callback = JS(
      "
          // Add ARIA role and label to pagination
          function addPaginationARIA() {
            var $container = $(table.table().container());
            var $paginate = $container.find('.dataTables_paginate');

            // Add role and aria-label to pagination
            $paginate.attr('role', 'navigation');
            $paginate.attr('aria-label', 'Paginering');
          }

          // Add Pagina to the page numbers of the table
          function addPaginationLabels() {
            var $pagBtns = $(table.table().container()).find('.dataTables_paginate .paginate_button');
            $pagBtns.each(function(){
              var $btn = $(this);
              var txt = $btn.text().trim();
              if(/^[0-9]+$/.test(txt)) {
                // Voeg een visueel verborgen span toe als die nog niet bestaat
                if ($btn.find('.visually-hidden').length === 0) {
                  $btn.append('<span class=\"visually-hidden\">Pagina </span>');
                }
                $btn.attr('aria-label', 'Pagina ' + txt);
              }
            });
          }

          table.on('draw', function() {
            addPaginationARIA();
            addPaginationLabels();
          });
          table.on('init', function() {
            addPaginationARIA();
            addPaginationLabels();
          });
          addPaginationARIA();
          addPaginationLabels();

          // Remove aria-live label
          if (!window.ariaLiveObserverInitialized) {
            window.ariaLiveObserverInitialized = true;

            function removeAriaLive() {
              $('[aria-live]').each(function() {
                if (!$(this).hasClass('status-message')) {
                  $(this).removeAttr('aria-live');
                }
              });
            }

            $(document).on('shiny:connected', removeAriaLive);
            $(document).on('shiny:value', removeAriaLive);

            const observer = new MutationObserver(removeAriaLive);
            observer.observe(document.body, { childList: true, subtree: true });
          };


          "
    )
  )

  return(dt_df)
}
