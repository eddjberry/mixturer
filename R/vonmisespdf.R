#' Random vonmises
#'
#' \code{randomvonmises}
#'
#' @inheritParams randomvonmises
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Best, D. and Fisher, N. (1979). Applied Statistics, 24, 152-157.
#'
#' @export

vonmisespdf <- function(X, MU, K) {
  p = exp(K * cos(X-MU)) / (2 * pi * besselI(K, 0))
  return(p)
}
