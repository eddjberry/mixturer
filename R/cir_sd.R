#------------------------------------------------------------------------------
#' Circular standard deviation
#'
#' \code{cir_sd} takes of vector of radians and returns the circular equivalent of the standard deviation
#'
#' @param x A vector of radians in the range -pi to pi
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#'
#' @export

cir_sd <- function(x) {

  if(any(abs(x) > pi)) {
    stop("Input values must be in radians, range -pi to pi", call. = TRUE)
  }

  if(NROW(x) == 1) { x = t(x) }

  R = sqrt(sum(sin(x))^2 + sum(cos(x))^2) / NROW(x)

  sqrt(-2 * log(R))
}
