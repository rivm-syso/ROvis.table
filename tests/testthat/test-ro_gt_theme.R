test_that("ro_gt_theme works and all styling choices are working", {
  expect_snapshot(
    mtcars |>
      # id is necessary to keep  div id in html the same
      ro_gt_theme(groupname_col = "cyl", id = "abc") |>
      gt::tab_header(title = "mtcars", subtitle = "Open dataset from dplyr") |>
      # needs to be html otherwise random changes
      gt::as_raw_html()
  )
})

gt_object_test <- mtcars |>
  ro_gt_theme()

test_that("output is a gt object", {
  expect_identical(class(gt_object_test)[1], "gt_tbl")
})

test_that("ro_gt_theme stays quiet about font resolution by default", {
  local_mocked_bindings(
    ro_check_if_font_available = function(base_family) {
      message("mocked font message")
      "Verdana"
    }
  )
  expect_no_message(mtcars |> ro_gt_theme())
})

test_that("ro_gt_theme surfaces the font message when ROfont = TRUE", {
  local_mocked_bindings(
    ro_check_if_font_available = function(base_family) {
      message("mocked font message")
      "Verdana"
    }
  )
  expect_message(mtcars |> ro_gt_theme(ROfont = TRUE), "mocked font message")
})

test_that("ro_gt_theme does not use the RO font when ROfont = FALSE, even if installed", {
  local_mocked_bindings(
    ro_check_if_font_available = function(base_family) "RijksoverheidSansWebText"
  )
  html <- mtcars |> ro_gt_theme() |> gt::as_raw_html()
  expect_true(grepl("Verdana", html, fixed = TRUE))
  expect_false(grepl("RijksoverheidSansWebText", html, fixed = TRUE))
})
