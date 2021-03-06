#' bays_2009_error_df
#'
#' \code{bays_2009_error_df}
#'
#' @inheritParams bays_2009_fit_df
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Bays PM, Catalao RFG & Husain M. The precision of visual working
# memory is set by allocation of a shared resource. Journal of Vision
# 9(10): 7, 1-11 (2009)
#'
#' @export
#'

bays_2009_error_df <- function(d, id.var = "id", tar.var = "target", res.var = "response"){
  id <- d[, id.var]

  l <- split(d, id)

  paras <- data.frame(id = FALSE, precision = FALSE, bias = FALSE)

  for(i in seq_along(l)) {
    df <- as.data.frame.list(l[i], col.names = colnames(l[i]))

    X <- as.matrix(df[, res.var])
    Tg <- as.matrix(df[tar.var])

    B <- bays_2009_error(X, Tg)

    id <- as.character(df[1, id.var])

    paras[i, 1] <- id
    paras[i,2:3] <- B
  }
  return(paras)
}
