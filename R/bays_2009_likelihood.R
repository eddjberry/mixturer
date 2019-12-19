#' bays_2009_likelihood
#'
#' \code{bays_2009_likelihood}
#'
#' @inheritParams bays_2009_fit
#' @param B params
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Bays PM, Catalao RFG & Husain M. The precision of visual working
# memory is set by allocation of a shared resource. Journal of Vision
# 9(10): 7, 1-11 (2009)
#'
#'
#'

bays_2009_likelihood <- function(B, X, Tg, NT = replicate(NROW(X), 0)) {
  if(NCOL(X) > 2 | NCOL(Tg) > 1 | NROW(X) != NROW(Tg) | (any(NT != 0) & NROW(NT) != NROW(X) | NROW(NT) != NROW(Tg))) {
    stop("Error: Input not correctly dimensioned", call. = FALSE)
  }
  if(B[1] < 0 | any(B[2:4] < 0) | any(B[2:4] > 1) | abs(sum(B[2:4]) - 1) > 10^-6) {
    stop("Error: Invalid model parameters")
  }

  n = NROW(X)

  E = wrap(X - Tg)

  Wt = B[2] * vonmisespdf(E, 0, B[1])
  Wu = B[4] * matrix(1, nrow = n, ncol = 1) / (2 * pi)

  if(any(NT != 0)) {
    L = rowSums(cbind(Wt, Wu))
  } else {
    nn = NCOL(NT)
    NE = wrap(replicate(nn, X, 'matrix') - NT)
    Wn = B[3] / nn * vonmisespdf(NE, 0, B[1])
    L = rowSums(cbind(Wt, Wn, Wu))
  }

  LL = sum(log(L))

  return(data.frame(LL = LL, L = L))

}
