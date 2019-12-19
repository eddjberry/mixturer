#' Circular mean
#'
#'#' @aliases cir_bias
#'
#' \code{cir_sd} takes of vector of radians and returns the circular equivalent of the standard deviation
#'
#' @inheritParams cir_sd
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#'
#' @export

cir_mean <- function(x) {

  if(any(abs(x) > pi)) {
    stop("Input values must be in radians, range -pi to pi", call. = TRUE)
  }

  atan2(sum(sin(x)), sum(cos(x)))

}
