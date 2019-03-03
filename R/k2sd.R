
# Returns the standard deviation of a wrapped normal distribution
# corresponding to a Von Mises concentration parameter of K


#' k2sd
#'
#' \code{k2sd}
#'
#' @param K concentration
#'
#' @references Adapted from Matlab code by Paul Bays (https://www.paulbays.com/code.php)
#' Ref: Topics in Circular Statistics, S. R. Jammalamadaka & A. Sengupta
#'
#' @export
#'

k2sd <- function(K){
  if(K == 0){
    S = Inf
    } else if(is.infinite(K)){
      S = 0
      } else {
        S = sqrt(-2 * log(besselI(K, 1) / besselI(K, 0)))
      }
  return(S)
}



