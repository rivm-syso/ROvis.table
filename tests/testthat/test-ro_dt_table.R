# Tests for dt_table function

# Very basic test, namely does it return a datatable object?
# Functional test to be included
test_that("ro_dt_table returns a datatable object", {
  test_data <- data.frame(
    col1 = c("A", "B", "C"),
    col2 = c(1, 2, 3)
  )

  result <- ro_dt_table(
    data = test_data,
    caption = "Test Table"
  )

  expect_s3_class(result, "datatables")
  expect_s3_class(result, "htmlwidget")
})
