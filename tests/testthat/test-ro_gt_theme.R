test_that("ro_gt_theme works and all styling choices are working", {
  expect_snapshot(mtcars |>
                    # id is necessary to keep  div id in html the same
                    ro_gt_theme(groupname_col = "cyl", id = "abc") |>
                    gt::tab_header(title = "mtcars", subtitle = "Open dataset from dplyr") |>
                    # needs to be html otherwise random changes
                    gt::as_raw_html())
})

gt_object_test <- mtcars |>
  ro_gt_theme()

test_that("output is a gt object", {
  expect_identical(class(gt_object_test)[1],
                   "gt_tbl")
})
