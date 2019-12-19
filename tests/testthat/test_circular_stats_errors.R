context('Circular stats errors')

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

