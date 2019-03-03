# Translated into R by Ed D. J. Berry (github.com/eddjberry)
# from functions written by Paul Bays (paulbays.com) in Matlab

# Ref: Bays PM, Catalao RFG & Husain M. The precision of visual working
# memory is set by allocation of a shared resource. Journal of Vision
# 9(10): 7, 1-11 (2009)

# Return Maximum likelihood parameter B for a mixture model describing
# recall responses X in terms of target (T), non-target (NT) and
# uniform responses.

# Inputs should be radians within the range -pi, pi
# X should be a vector of responses
# T should be a vector of targets
# NT should be a matrix of non-target orientations

# Returns a 1 row dataframe with 4 parameters:
# K = concentration of Von Mises distribution - response variability
# pT = probability of responding with target value
# pN = probability of none target response
# pU = probability of uniform response

# If the argument return.ll is true then it will also return log-likelihood

#' JV10_df
#'
#' \code{JV10_df}
#'
#' @inheritParams JV10_error
#' @param NT non target matrix
#' @param return.ll logic return log liklihood
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Bays PM, Catalao RFG & Husain M. The precision of visual working
# memory is set by allocation of a shared resource. Journal of Vision
# 9(10): 7, 1-11 (2009)
#'
#' @export
#'

JV10_fit <- function(X, Tg, NT = replicate(NROW(X), 0), return.ll = TRUE) {
  if(NCOL(X) > 2 | NCOL(Tg) > 1 | NROW(X) != NROW(Tg) | (any(NT != 0) & NROW(NT) != NROW(X) | NROW(NT) != NROW(Tg))) {
    stop("Error: Input not correctly dimensioned", call. = FALSE)
  }
  n = NROW(X)

  nn = ifelse(any(NT != 0), NCOL(NT), 0)

  # Start parameters
  K = c(1, 10, 100)
  N = c(0.01, 0.1, 0.4)
  U = c(0.01, 0.1, 0.4)

  if(nn == 0) {N = 0}

  loglik = -Inf

  # Parameter estimates
  for(i in seq_along(K)) {
    for(j in seq_along(N)) {
      for(k in seq_along(U)) {
        est_list = JV10_function(X = X, Tg = Tg, NT = NT, B_start = c(K[i], 1-N[j]-U[k], N[j], U[k]))
        if (est_list$ll > loglik & !is.nan(est_list$ll) ) {
          loglik = est_list$ll
          B = est_list$b
        }
      }
    }
  }

  if(return.ll == TRUE) {
    return(list(B = B, LL = loglik))
  } else {
    return(B)
  }
}
