context('Circular stats')

test_data_path <- dir(getwd(), recursive = TRUE, pattern = "df_test_von_mises.rds", full.names = TRUE)

df_test_von_mises <- readRDS(test_data_path)

test_that('circular mean is correct', {
  mu = cir_mean(df_test_von_mises$response)
  expect_equal(mu, 0.03877408)
})

test_that('circular SD is correct', {
  std = cir_sd(df_test_von_mises$response)
  expect_equal(std, 1.196833, tolerance = 1e-06)
})

test_that('sd2k is correct', {
  std = cir_sd(df_test_von_mises$response)
  k = sd2k(std)
  expect_equal(k, 1.117059, tolerance = 1e-06)
})

test_that('k2sd is correct', {
  std = cir_sd(df_test_von_mises$response)
  k = sd2k(std)
  std2 = k2sd(k)
  expect_equal(std, std2, tolerance = 0.005)
})
