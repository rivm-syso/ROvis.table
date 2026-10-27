# Tests for ro_reactable_theme function

test_that("ro_reactable_theme returns a reactable theme object", {
  theme <- ro_reactable_theme()

  # reactableTheme returns a list of class 'reactableTheme'
  expect_s3_class(theme, "reactableTheme")
  expect_type(theme, "list")

  # It should have tableStyle, headerStyle, cellStyle elements
  expect_true("tableStyle" %in% names(theme))
  expect_true("headerStyle" %in% names(theme))
  expect_true("cellStyle" %in% names(theme))
})

test_that("ro_reactable_theme sets some font family", {
  theme <- ro_reactable_theme()
  expect_type(theme$tableStyle$fontFamily, "character")
})

test_that("ro_reactable_theme validates base_family", {
  expect_error(ro_reactable_theme(base_family = 123), "string", ignore.case = TRUE)
  expect_error(ro_reactable_theme(base_family = NULL))
})

test_that("ro_reactable_theme errors for an unavailable custom font", {
  expect_error(
    ro_reactable_theme(base_family = "Not an installed font"),
    "Can't find"
  )
})

# Tests for ro_reactable_css function

test_that("ro_reactable_css returns a head tag", {
  res <- ro_reactable_css()
  expect_s3_class(res, "shiny.tag")
  expect_equal(res$name, "head")
})

test_that("ro_reactable_css includes base CSS", {
  res <- ro_reactable_css()

  css <- res$children[[1]]$children[[1]]
  css <- paste(css, collapse = "\n")

  expect_true(grepl(".sr-only", css, fixed = TRUE))
  expect_true(grepl(".reactable .rt-table caption", css, fixed = TRUE))
  expect_true(grepl(".reactable .rt-tbody .rt-tr-group:nth-child(odd)", css, fixed = TRUE))
})

test_that("ro_reactable_css includes sorting CSS when sorting = TRUE", {
  res <- ro_reactable_css(sorting = TRUE)

  # Extract the HTML object produced by shiny::HTML()
  html_obj <- res$children[[1]]$children[[1]]

  # Convert to a single character string
  css <- paste(as.character(html_obj), collapse = "\n")

  # Now grepl works on 'css'
  expect_true(grepl(".reactable .rt-th[aria-sort='none']::after", css, fixed = TRUE))
  expect_true(grepl(".reactable .rt-th[aria-sort='ascending']::after", css, fixed = TRUE))
  expect_true(grepl(".reactable .rt-th[aria-sort='descending']::after", css, fixed = TRUE))
})

test_that("ro_reactable_css omits sorting CSS when sorting = FALSE", {
  res <- ro_reactable_css(sorting = FALSE)
  html_obj <- res$children[[1]]$children[[1]]
  css <- paste(as.character(html_obj), collapse = "\n")

  expect_false(grepl(".reactable .rt-th[aria-sort='none']::after", css, fixed = TRUE))
  expect_false(grepl(".reactable .rt-th[aria-sort='ascending']::after", css, fixed = TRUE))
  expect_false(grepl(".reactable .rt-th[aria-sort='descending']::after", css, fixed = TRUE))

  # Still hides the extra sort arrow span
  expect_true(grepl(".reactable .rt-th .rt-sort-left", css, fixed = TRUE))
})
