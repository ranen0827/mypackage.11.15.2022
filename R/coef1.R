#'@title coef1
#'
#'@description Parameter estimation and inference of the linear model
#'
#'@param model the list derived from lm_mat() function
#'
#'
#'@return Coefficient table of the linear model, R squared and Adjusted R squared, as well as covariance matrix of the model
#'
#'\item{Coefficients}{The coefficients table of the linear model containing estimates of the parameter, standardized error, t-value, p-value as well as its significance}
#'\item{F-test}{F-test result containing F-value, 2 separate degrees of freedom, and p-value}
#'\item{Signif.codes}{Significance level defined by default}
#'\item{Adj.R_square}{Adjusted R-square of the model}
#'\item{R_square}{R-square of the model}
#'\item{Covariance_matrix}{Covariance_matrix of the model}
#'
#'
#'
#'@examples
#'## SLR (Simple Linear Regression)
#'model_SLR = lm_mat("mpg", c("cyl"), mtcars, beta0 = TRUE)
#'coef1(model_SLR)
#'
#'## MLR (Multiple Linear Regression with intercept)
#'model_MLR1 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = TRUE)
#'coef1(model_MLR1)
#'
#'## MLR (Multiple Linear Regression without intercept)
#'model_MLR2 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = FALSE)
#'coef1(model_MLR2)
#'
#'@importFrom stats pf pt
#'@export
#'
#'
#'@author Shushun Ren, email: \email{shushunr@umich.edu}
#'

### Estimation: betahat and var(betahat)
### Inference: t statistic and p val for H0: beta = 0
coef1 <- function(model){
  beta0 <- model$beta0
  data <- model$Dataset
  X_lab <- if(beta0){c("(Intercept)",model$xvar)}else{model$xvar}
  X <- model$X
  Y <- model$Y
  H <- model$H
  n <- model$N
  p <- model$p
  Y_hat <- model$Y_hat
  ## coefficients beta (including beta 0)
  beta <- solve(t(X) %*% X) %*% t(X) %*% Y
  resids <- Y - Y_hat
  SSE <- t(resids) %*% resids
  SSY <- t(Y-mean(Y)) %*% (Y-mean(Y))
  if(!beta0){SSY <- t(Y) %*% (Y)}
  SSR <- SSY - SSE
  ## calculating R_square and Adjusted R square
  R_square <- 1 - SSE/SSY
  Adj.R_square <- 1- (SSE/(n-p))/(SSY/(n-1))
  if(!beta0){Adj.R_square <- 1- (SSE/(n-p))/(SSY/(n))}
  # sigma_sqr_hat <- SSE/dfE = SSE/(n-p)
  sigma_sqr <- (t(resids) %*% resids) /(n-p)
  # variance beta hat
  var_beta_hat <- c(sigma_sqr) * solve(t(X) %*% X)
  colnames(var_beta_hat) <- X_lab
  rownames(var_beta_hat) <- X_lab

  ## inference: t, F and p-value
  t_value <- c(beta) / sqrt(diag(var_beta_hat))
  F_value <- c((SSR/(p-1)) / (SSE/(n-p)))
  pf_value <- c((1-pf(q=abs(F_value), df1=p-1,df2=n-p)))
  pt_value <- c(2*(1-pt(q=abs(t_value), df=n-p)))

  sig.level <- function(x){
    ifelse(x>0.1," ",
           ifelse(x>0.05,".",
                  ifelse(x>0.01,"*",
                         ifelse(x>0.001,"**",
                                ifelse(x>0,"***"," ")))))
  }

  coef_tbl <- data.frame(
    Estimate = c(beta),
    Std.Error = sqrt(diag(var_beta_hat)),
    t_value = t_value,
    p_value = pt_value,
    Sig. = sig.level(pt_value),
    row.names = X_lab
  )
  F_test <- data.frame(
    F_value = F_value, df1 = p-1, df2 = n-p, p_value = pf_value, Sig. = sig.level(pf_value),
    row.names = ' '
  )
  return(list(Coefficients = coef_tbl,
              F_test = F_test,
              Signif.codes = c("0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1"),
              Adj.R_square = c(Adj.R_square),
              R_square = c(R_square),
              Covariance_matrix = var_beta_hat))
}




