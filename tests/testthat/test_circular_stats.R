context('Circular stats')

test_data_path <- dir(getwd(), recursive = TRUE, pattern = "df_test_von_mises.rds", full.names = TRUE)

df_test_von_mises <- readRDS(test_data_path)

#======================================
# Results
#======================================

test_that('circular mean is correct', {
  mu = cir_mean(df_test_von_mises$response)
  expect_equal(mu, 0.03877408)
})

test_that('circular SD is correct', {
  # passing in as a vector
  std = cir_sd(df_test_von_mises$response)
  expect_equal(std, 1.196833, tolerance = 1e-06)

  # passing in a row matrix
  std = cir_sd(matrix(df_test_von_mises$response, nrow = 1))
  expect_equal(std, 1.196833, tolerance = 1e-06)
})

# taken from issue #5
test_that('sd2k is correct', {
  expect_equal(sd2k(0.3659424), 7.995975, tolerance = 1e-06)
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

  # check passing in 0 returns Inf
  expect_equal(k2sd(0), Inf)

  # check passing in Inf returns 0
  expect_equal(k2sd(Inf), 0)
})

#======================================
# Errors
#======================================

test_that('cir_mean error is correct', {
  expect_error(cir_mean(1:4), 'Input values must be in radians, range -pi to pi')
})

test_that('cir_sd error is correct', {
  expect_error(cir_sd(1:4), 'Input values must be in radians, range -pi to pi')
})

test_that('cir_precision errors are correct', {
  expect_error(cir_precision(X = 0:4, Tg = -2:2),
               'Input values must be in radians, range -pi to pi')

  expect_error(cir_precision(X = -2:2, Tg = 0:4),
               'Input values must be in radians, range -pi to pi')

  expect_error(cir_precision(X = -1:2, Tg = -2:2),
               'Inputs must have the same length')

  expect_error(cir_precision(X = -2:2, Tg = -1:2),
               'Inputs must have the same length')
})
