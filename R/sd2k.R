#' sd2k
#'
#' \code{sd2k}
#'
#' @param S std
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Ref: Topics in Circular Statistics, S. R. Jammalamadaka & A. Sengupta
#'
#' @export
#'

sd2k <- function(S){

  R = exp(-S^2 / 2)

  K = 1 / R^3 - 4 * R^2 + 3 * R

  K[R < 0.85] = -0.4 + 1.39 * R[R < 0.85] + 0.43 / (1 - R[R < 0.85])

  K[R < 0.53] = 2 * R[R < 0.53] + R[R < 0.53]^3 + (5 * R[R < 0.53]^5) / 6

  return(K)
}
