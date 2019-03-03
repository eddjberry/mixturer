context('Mixture model')

# might want to test for multiple values moving forward

test_data_path <- dir(getwd(), recursive = TRUE, pattern = "df_test_mixture_model.rds", full.names = TRUE)

df_test_mixture_model <- readRDS(test_data_path)

df_parameters <-
  JV10_df(
    df_test_mixture_model,
    id.var = 'id',
    tar.var = 'target',
    res.var = 'response',
    nt.vars = c('nt1', 'nt2', 'nt3')
  )

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
