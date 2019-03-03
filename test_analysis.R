
library(dplyr)

source("mixture_model_functions.R")

d <- read.csv("test_data.csv")

d$response_rad <- wrap(d$response/90*pi)
d$target_rad <- wrap(d$target/90*pi)

d1 <- d %>%
  filter(id == "pilot1")

d2 <- d %>%
  filter(id == "pilot2")


(ests1 = JV10_fit(X = d1$response_rad , Tg  = d1$target_rad))

(ests2 = JV10_fit(X = d2$response_rad , Tg  = d2$target_rad))

# looping over df; the tar.var argument actually defaults to "target" and
# res.var defaults to response but I've included them here for ease of reading.

JV10_df(d, tar.var = "target_rad", res.var = "response_rad")
