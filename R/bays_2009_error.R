#' bays_2009_error
#'
#' \code{bays_2009_error}
#'
#' @param X response vector radians
#' @param Tg target orientations in radians
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Bays PM, Catalao RFG & Husain M. The precision of visual working
# memory is set by allocation of a shared resource. Journal of Vision
# 9(10): 7, 1-11 (2009)
#'
#' @export
#'

bays_2009_error <- function(X, Tg = 0) {
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

  P = (1 / cir_sd(E)) - P0

  # Bias
  B = cir_mean(E)

  return(data.frame(precision = P, bias = B))
}
