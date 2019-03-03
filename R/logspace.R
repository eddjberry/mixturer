#' k2sd
#'
#' \code{k2sd}
#'
#' @param a a
#' @param b b
#' @param n n
#'
#' @references http://r.789695.n4.nabble.com/logarithmic-seq-tp900431p900433.html
#'
#' @export
#'


logspace <- function(a, b, n) exp(log(10)*seq(a, b, length.out=n))
