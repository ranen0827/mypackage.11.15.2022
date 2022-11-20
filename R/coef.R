### Estimation: betahat and var(betahat) ###
### Inference: t statistic and p val for H0: beta = 0 ###
coef <- function(model){
  beta0 <- model$beta0
  data <- model$Dataset
  X_lab <- if(beta0){c("(Intercept)",model_mat$xvar)}else{model_mat$xvar}
  X <- model$X
  Y <- model$Y
  H <- model$H
  n <- model$N
  p <- model$p
  ## coefficients beta (including beta 0)
  beta <- solve(t(X) %*% X) %*% t(X) %*% Y
  resids <- Y - Y_hat
  SSE <- t(resids) %*% resids
  SSY <- t(Y-mean(Y)) %*% (Y-mean(Y))
  SSR <- SSY - SSE
  ## calculating R_square and Adjusted R square
  R_square <- 1 - SSE/SSY
  Adj.R_square <- 1- (SSE/(n-nrow(beta)))/(SSY/(n-1))
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
                                ifelse(x>0,"***")))))
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
              Signif.codes = c("0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1"),
              Adj.R_square = c(Adj.R_square),
              R_square = c(R_square),
              Covariance_matrix = var_beta_hat))
}



summary(model)
'
Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept) 34.66099    2.54700  13.609 4.02e-14 ***
cyl         -1.58728    0.71184  -2.230   0.0337 *
disp        -0.02058    0.01026  -2.007   0.0542 .
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.055 on 29 degrees of freedom
Multiple R-squared:  0.7596,	Adjusted R-squared:  0.743
F-statistic: 45.81 on 2 and 29 DF,  p-value: 1.058e-09
'
a = lm_mat("mpg", c("cyl","disp"), mtcars)
coef(a)

