# Translated into R by Ed D. J. Berry (github.com/eddjberry)
# from functions written by Paul Bays (paulbays_2009.com) in Matlab

# This function maps the input values (y) onto the circular space -pi to pi.
# If the inputs are in degrees then divide by 180*pi. However, if the degrees
# are in the range 180 to 0 (e.g. bar orientations) then divide by 90*pi

#' Random vonmises
#'
#' \code{randomvonmises}
#'
#' @param Y  a vec
#' @param bound pi
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Best, D. and Fisher, N. (1979). Applied Statistics, 24, 152-157.
#'
#' @export

wrap <- function(Y, bound = pi) {
  X <- ((Y + bound) %% (bound*2)) - bound
  return(X)
}
