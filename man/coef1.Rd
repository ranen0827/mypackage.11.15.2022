% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coef1.R
\name{coef1}
\alias{coef1}
\title{coef1}
\usage{
coef1(model)
}
\arguments{
\item{model}{the list derived from lm_mat() function}
}
\value{
Coefficient table of the linear model, R squared and Adjusted R squared, as well as covariance matrix of the model

\item{Coefficients}{The coefficients table of the linear model containing estimates of the parameter, standardized error, t-value, p-value as well as its significance}
\item{F-test}{F-test result containing F-value, 2 separate degrees of freedom, and p-value}
\item{Signif.codes}{Significance level defined by default}
\item{Adj.R_square}{Adjusted R-square of the model}
\item{R_square}{R-square of the model}
\item{Covariance_matrix}{Covariance_matrix of the model}
}
\description{
Parameter estimation and inference of the linear model
}
\examples{
## SLR (Simple Linear Regression)
model_SLR = lm_mat("mpg", c("cyl"), mtcars, beta0 = TRUE)
coef1(model_SLR)

## MLR (Multiple Linear Regression with intercept)
model_MLR1 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = TRUE)
coef1(model_MLR1)

## MLR (Multiple Linear Regression without intercept)
model_MLR2 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = FALSE)
coef1(model_MLR2)

}
\author{
Shushun Ren, email: \email{shushunr@umich.edu}
}
