#' repmat
#'
#' \code{repmat}
#'
#' @param X X
#' @param nn nn
#'
#' @references Adapted from  adapted from http://haky-functions.blogspot.co.uk/2006/11/repmat-function-matlab.html
#'
#' @export
#'

repmat = function(X, nn){
  mx = NROW(X)
  nx = NCOL(X)
  if(nn > 0){
    return(matrix(data = X, nrow = mx, ncol = nx*nn))
  } else {
    return(matrix(nrow = mx, ncol = nn))
  }
}
