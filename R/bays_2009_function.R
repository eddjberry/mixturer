# Translated into R by Ed D. J. Berry (github.com/eddjberry)
# from functions written by Paul Bays (paulbays_2009.com) in Matlab

# Ref: Bays PM, Catalao RFG & Husain M. The precision of visual working
# memory is set by allocation of a shared resource. Journal of Vision
# 9(10): 7, 1-11 (2009)

# Returns a list where the first element in a single row data frame
# of parameter estimates and the second is a single log likelihood value
# Returns a list where the first element in a single row data frame
# of parameter estimates and the second is a single log likelihood value

#' bays_2009_function
#'
#' \code{bays_2009_function}
#'
#' @inheritParams bays_2009_fit
#' @param B_start starting params
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Bays PM, Catalao RFG & Husain M. The precision of visual working
# memory is set by allocation of a shared resource. Journal of Vision
# 9(10): 7, 1-11 (2009)
#'
#'
#'

bays_2009_function <- function(X, Tg,
                          NT = replicate(NROW(X), 0),
                          B_start = NULL) {

  if(NCOL(X) > 2 | NCOL(Tg) > 1 | NROW(X) != NROW(Tg) | (any(NT != 0) & NROW(NT) != NROW(X) | NROW(NT) != NROW(Tg))) {
    stop("Error: Input not correctly dimensioned", call. = FALSE)
  }

  if((!(is.null(B_start))) & (any(B_start[1] < 0, B_start[2:4] < 0, B_start[2:4] > 1, abs(sum(B_start[2:4]) - 1) > 10^-6))) {
    stop("Error: Invalid model parameters", call. = FALSE)
  }

  max_iter = 10^4; max_dLL = 10^-4

  n = NROW(X)

  nn = ifelse(any(NT != 0), NCOL(NT), 0)

  # Default starting parameter

  if(is.null(B_start)) {
    K = 5; Pt = 0.5
    Pn = ifelse(nn > 0, 0.3, 0)
    Pu = 1 - Pt - Pn
  } else {
    K = B_start[1]; Pt = B_start[2]
    Pn = B_start[3]; Pu = B_start[4]
  }

  E = wrap(X - Tg)

  if(nn > 0){
    NE = wrap(replicate(nn, X, 'matrix') - NT)
  } else {
    NE = replicate(nn, X, 'matrix')
  }

  LL = 0; dLL = 1; iter = 1

  while(TRUE) {
    iter = iter + 1

    Wt = Pt * vonmisespdf(E, 0, K)
    Wg = Pu * replicate(n, 1) / (2 * pi)

    if(nn == 0){
      Wn = matrix(nrow = NROW(NE), ncol = NCOL(NE))
    } else {
      Wn = Pn/nn * vonmisespdf(NE, 0, K)
    }

    W = rowSums(cbind(Wt, Wg, Wn))

    dLL = LL - sum(log(W))
    LL = sum(log(W))

    if(abs(dLL) < max_dLL | iter > max_iter | is.nan(dLL)) {
      break
    }

    Pt = sum(Wt / W) / n
    Pn = sum(rowSums(Wn) / W) / n
    Pu = sum(Wg / W) / n

    rw = c((Wt / W), (Wn / replicate(nn, W, 'matrix')))

    S = c(sin(E), sin(NE)) ; C = c(cos(E), cos(NE))
    r = c(sum(sum(S * rw)), sum(sum(C * rw)))

    if(sum(sum(rw, na.rm = T)) == 0) {
      K = 0
    } else {
      R = sqrt(sum(r^2)) / sum(sum(rw))
      K = circular::A1inv(R)
    }

    if(n <= 15) {
      if(K < 2) {
        K = max(K - 2 / (n * K), 0)
      } else {
        K = K * (n - 1)^3 / (n^3 + n)
      }
    }
  }


  if(iter > max_iter) {
    warning('bays_2009_function:MaxIter','Maximum iteration limit exceeded.', call. = FALSE)
    B = c(NaN, NaN, NaN, NaN); LL = NaN
  } else {
    B = data.frame(K = K, Pt = Pt, Pn = Pn, Pu = Pu)
  }

  return(list(b = B, ll = LL))

}
