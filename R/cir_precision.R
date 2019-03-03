#' Circular Precision
#'
#' \code{cir_sd} takes of vector of radians and returns the circular equivalent of the standard deviation
#'
#' @inheritParams JV10_error
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#'
#' @export
#'
cir_precision <- function(X, Tg = 0) {
  if(any(abs(X) > pi) | any(abs(Tg) > pi)) {
    stop("Error: Input values must be in radians, range -PI to PI", call. = FALSE)
  }
  if(any(dim(X)) != any(dim(Tg))) {
    stop("Error: Inputs must have the same dimensions", call. = FALSE)
  }

  E = wrap(X - Tg) # error: diff between response and target

  # Precision
  N = NROW(X)

  x = logspace(-2, 2, 100)
  P0 = caTools::trapz(x, N / (sqrt(x) * exp(x + (N * exp(-x))))) # expected precision under uniform distribution

  1 / cir_sd(E) - P0
}
