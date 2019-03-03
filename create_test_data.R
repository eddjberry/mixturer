# create test von mises data

set.seed(1295)

response <- randomvonmises(1000, 0, 1)
target <- response + rnorm(1000, 0, 0.01)

df_test_von_mises <- data.frame(response, target)

saveRDS(df_test_von_mises,
        'tests/testthat/data/df_test_von_mises.rds')
