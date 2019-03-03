#' Circular bias
#'
#'#' @aliases cir_mean
#'
#' \code{cir_sd} takes of vector of radians and returns the circular equivalent of the standard deviation
#'
#' @inheritParams cir_sd
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#'
#' @export

cir_bias <- function(x) {
  cir_mean(x)
}
