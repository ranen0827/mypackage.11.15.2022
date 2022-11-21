#'@title lm_mat
#'
#'@details Gets the matrix notation and basic information
#'from outcome(Y) and predictors(X) constructing a linear model.
#'
#'@param Y_lab the name of the outcome(Y) variable (characters)
#'@param X_lab the name(s) of the predictor(s) (characters)
#'@param data data frame from which the variables are selected
#'@param beta0 Intercept should be included if `beta0`=`TRUE`, or not if `beta0`=`FALSE`.
#'
#'
#'
#'@return basic information from Y and X, as well as matrix notations frequently used
#'
#'@examples
#'## SLR (Simple Linear Regression)
#'lm_mat("mpg", c("cyl"), mtcars, beta0 = TRUE)
#'
#'## MLR (Multiple Linear Regression with intercept)
#'lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = TRUE)
#'lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = TRUE)
#'
#'## MLR (Multiple Linear Regression without intercept)
#'lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = FALSE)
#'
#'@export
#'
#'
#'
# MLR beta coefficient
## input: data, output: design matrix of the model
## model preparations

## define design matrix, outcome, dimensions
lm_mat <- function(Y_lab, X_lab, data, beta0 = TRUE) {
  ## potential_error: "data" not a data frame --> stop
  if (!is.data.frame(data))
    stop("param 'data' must be a data frame")
  ## potential_error: Y_lab or X_lab not in the data frame --> stop
  if (!(Y_lab %in% names(data)) || !all((X_lab %in% names(data)))) {
    stop(gettextf(
      "name of X or Y not in the %s data frame",
      as.character(substitute(data))
    ),
    domain = NA)
  }
  Y <- as.matrix(data[,Y_lab])
  X <- as.matrix(data[,X_lab])
  # beta0 adds another column of "1"
  if (beta0){X <- cbind(rep(1, nrow(data)), X)}
  colnames(X) <- NULL
  rownames(X) <- NULL
  ## potential_error: about design matrix (...)

  H = X %*% solve(t(X) %*% X) %*% t(X)
  Y_hat <- H %*% Y
  return(list(xvar = X_lab,
              yvar = Y_lab,
              Dataset = data,
              selected = data[,c(Y_lab, X_lab)],
              beta0 = beta0,
              N = nrow(X),
              p = ncol(X),
              X = X,
              Y = Y,
              H = H,
              Y_hat = Y_hat,
              residuals = c(Y - Y_hat)))
}


