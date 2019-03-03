context('Precision-bias')

test_data_path <-
  dir(
    getwd(),
    recursive = TRUE,
    pattern = "df_test_von_mises.rds",
    full.names = TRUE
  )

df_test_von_mises <- readRDS(test_data_path)



test_that('cir_precision is correct', {
  precision = cir_precision(df_test_von_mises$response)
  expect_equal(precision, 0.4657962, tolerance = 1e-06)
})


# JV10_error

test_that('cir_precision is correct', {
  df_expected <-
    data.frame(precision = 96.3414991002543, bias = 0.000237071797288786)

  df_output <-
    JV10_error(df_test_von_mises$response, df_test_von_mises$target)

  expect_equal(df_output, df_expected)
})
