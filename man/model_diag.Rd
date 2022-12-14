% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_diag.R
\name{model_diag}
\alias{model_diag}
\title{model_diag}
\usage{
model_diag(model)
}
\arguments{
\item{model}{the list derived from lm_mat() function}
}
\value{
Diagrams for model diagnostics, including the following plots:

1) Normal Q-Q plot;

2) Scatterplot between Fitted values (Y hat) vs. Residuals;

3) Histogram of residuals;

4) Scatterplot between Fitted values (Y hat) vs. Original Values (Y)
}
\description{
Model diagnostics of the established Linear Model
}
\examples{
## SLR (Simple Linear Regression)
model_SLR = lm_mat("mpg", c("cyl"), mtcars, beta0 = TRUE)
model_diag(model_SLR)

## MLR (Multiple Linear Regression with intercept)
model_MLR1 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = TRUE)
model_diag(model_MLR1)

## MLR (Multiple Linear Regression without intercept)
model_MLR2 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = FALSE)
model_diag(model_MLR2)

}
\author{
Shushun Ren, email: \email{shushunr@umich.edu}
}
