context('Bays mixture model')

# might want to test for multiple values moving forward

test_data_path <- dir(getwd(), recursive = TRUE, pattern = "df_test_mixture_model.rds", full.names = TRUE)

df_test_mixture_model <- readRDS(test_data_path)

# use bays_2009_fit_df
df_parameters <-
  bays_2009_fit_df(
    df_test_mixture_model,
    id.var = 'id',
    tar.var = 'target',
    res.var = 'response',
    nt.vars = c('nt1', 'nt2', 'nt3')
  )

# use bays_2009_fit
list_parameters <-
  bays_2009_fit(
    df_test_mixture_model$response,
    df_test_mixture_model$target,
    as.matrix(df_test_mixture_model[, c('nt1', 'nt2', 'nt3')])
  )

#======================================
# Results
#======================================

# check the _df and _fit functions agree
test_that('bays_2009_fit_df() and bays_2009_fit() agree', {
  expect_equal(df_parameters[1, -1], list_parameters$B)
})

test_that('K is correct', {
  K <- df_parameters$K
  expect_equal(K, 9.55256654331945)
})

test_that('Pt is correct', {
  Pt <- df_parameters$Pt
  expect_equal(Pt, 0.803038512906887)
})

test_that('Pn is correct', {
  Pn <- df_parameters$Pn
  expect_equal(Pn, 0.105513478074523)
})

test_that('Pu is correct', {
  Pu <- df_parameters$Pu
  expect_equal(Pu, 0.0914480090185902)
})

#======================================
# Errors
#======================================

test_that('Different nrow for X and Tg', {
  X = matrix(runif(50), ncol = 2)
  Tg = matrix(runif(50), ncol = 1)

  expect_error(bays_2009_fit(X, Tg), 'Error: Input not correctly dimensioned')
})

test_that('X > 2 cols', {
  X = matrix(runif(100), ncol = 4)
  Tg = matrix(runif(25), ncol = 1)

  expect_error(bays_2009_fit(X, Tg), 'Error: Input not correctly dimensioned')
})

test_that('Tg > 1 col', {
  X = matrix(runif(50), ncol = 1)
  Tg = matrix(runif(100), ncol = 2)

  expect_error(bays_2009_fit(X, Tg), 'Error: Input not correctly dimensioned')
})

test_that('Different nrow for X and NT', {
  X = matrix(runif(50), ncol = 1)
  Tg = matrix(runif(50), ncol = 1)
  NT = matrix(runif(100), ncol = 4)

  expect_error(bays_2009_fit(X, Tg, NT),
               'Error: Input not correctly dimensioned')
})
