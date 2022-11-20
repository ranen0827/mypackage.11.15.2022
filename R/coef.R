coef <- function(model_mat){
  X <- model_mat$X
  Y <- model_mat$Y
  H <- model_mat$H
  n <- model_mat$N
  ## coefficients beta (including beta 0)
  beta <- solve(t(X) %*% X) %*% t(X) %*% Y
  Y_hat <- H %*% Y
  resids <- Y - Y_hat
  SSE <- t(resids) %*% resids
  SSY <- t(Y-mean(Y)) %*% (Y-mean(Y))
  SSR <- SSY - SSE
  ## calculating R_square and Adjusted R square
  R_square <- 1 - SSE/SSY
  Adj.R_square <- 1- (SSE/(n-nrow(beta)))/(SSY/(n-1))
  # sigma_sqr_hat <- SSE/dfE = SSE/(n-p)
  sigma_sqr <- t(resids) %*% resids /(nrow(data)-leng(X_lab)-beta0)
  # variance beta hat
  var_beta_hat <- sigma_sqr * solve(t(X) %*% X)


  coef_tbl <- data.frame(
    Estimate = beta,
    Std.Error = sqrt(diag(var_beta_hat)),
    confint = ,
    t_value = beta / sqrt(diag(var_beta_hat)),
    p_value =
  )
  return(list(coefficents = coef_tbl,
              Adj.R_square = Adj.R_square,
              R_square = R_square))
}
