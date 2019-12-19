#' Circular Precision
#'
#' \code{cir_sd} takes of vector of radians and returns the circular equivalent of the standard deviation
#'
#' @inheritParams bays_2009_error
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#'
#' @export
#'
cir_precision <- function(X, Tg = 0) {

  if(length(X) != length(Tg) & length(Tg) > 1) {
    stop("Inputs must have the same length", call. = TRUE)
  }

  if(any(abs(X) > pi) | any(abs(Tg) > pi)) {
    stop("Input values must be in radians, range -pi to pi", call. = TRUE)
  }


  E = wrap(X - Tg) # error: diff between response and target

  # Precision
  N = NROW(X)

  x = logspace(-2, 2, 100)
  P0 = caTools::trapz(x, N / (sqrt(x) * exp(x + (N * exp(-x))))) # expected precision under uniform distribution

  1 / cir_sd(E) - P0
}
