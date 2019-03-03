#' JV10_df
#'
#' \code{JV10_df}
#'
#' @param d dataframe
#' @param id.var id variable string
#' @param tar.var target variable
#' @param res.var response variable
#' @param nt.vars optional non target vars
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Bays PM, Catalao RFG & Husain M. The precision of visual working
# memory is set by allocation of a shared resource. Journal of Vision
# 9(10): 7, 1-11 (2009)
#'
#' @export
#'

JV10_df <- function(d, id.var = "id", tar.var = "target", res.var = "response", nt.vars = NULL){
  id <- d[, id.var]

  l <- split(d, id)

  paras <- data.frame(id = FALSE, K = FALSE, Pt = FALSE, Pn = FALSE, Pu = FALSE)

  for(i in seq_along(l)) {
    df <- as.data.frame.list(l[i], col.names = colnames(l[i]))

    X <- as.matrix(df[, res.var])
    Tg <- as.matrix(df[tar.var])

    if(is.null(nt.vars)) {
      B <- JV10_fit(X, Tg, return.ll = FALSE)
    } else {
      NT = as.matrix(df[,nt.vars])
      B <- JV10_fit(X, Tg, NT, FALSE)
    }
    id <- as.character(df[1, id.var])
    paras[i, 1] <- id
    paras[i,2:5] <- B
  }
  return(paras)
}
