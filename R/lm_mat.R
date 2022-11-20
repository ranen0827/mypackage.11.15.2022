# MLR beta coefficient
## input: data, output: design matrix of the model
## model preparations
lm_mat <- function(Y_lab, X_lab, data, beta0 = TRUE) {
  ## potential_error: "data" not a data frame --> stop
  if (!is.data.frame(data))
    stop("param 'data' must be a data frame")
  ## potential_error: Y_lab or X_lab not in the data frame --> stop
  if (!(Y_lab %in% names(data)) || !(X_lab %in% names(data))) {
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

  return(list(N = nrow(X),
              X = X,
              Y = Y,
              H = H))
}


# solve beta0 using matrix notation

b <- function(){
  return(a=c(2,1))
}

# test
#> names(mtcars)
#[1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec"
#[8] "vs"   "am"   "gear" "carb"
#> lm(mpg~cyl+disp, mtcars)
#Call:
#  lm(formula = mpg ~ cyl + disp, data = mtcars)
#Coefficients:
#  (Intercept)          cyl         disp
#34.66099     -1.58728     -0.02058
lm_mat("mpg", c("cyl","disp"), mtcars)
