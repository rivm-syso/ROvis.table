test_that("ro_dt_theme applies the font resolved by ro_check_if_font_available", {
  local_mocked_bindings(
    ro_check_if_font_available = function(target_font_family) "Verdana"
  )
  css <- ro_dt_theme()$children[[1]]$children[[1]]
  expect_true(grepl("Verdana", css, fixed = TRUE))
})

test_that("ro_dt_theme errors for an unavailable custom font", {
  expect_error(
    ro_dt_theme(base_family = "Not an installed font"),
    "Can't find"
  )
})
