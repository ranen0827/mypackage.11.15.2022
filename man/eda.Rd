% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eda.R
\name{eda}
\alias{eda}
\title{eda}
\usage{
eda(model_df)
}
\arguments{
\item{model_df}{Data frame containing potential variables from the dataset}
}
\value{
Model diagnostics diagram, described as follows:

1) Scatterplot between variables at lower triangle of the matrix

2) Histogram and name of variables at diagonal

3) Correlation coefficients at upper triangle of the matrix
}
\description{
Exploratory Data Analysis of the selected variables from linear model
}
\examples{
## SLR (Simple Linear Regression)
model_SLR = lm_mat("mpg", c("cyl"), mtcars, beta0 = TRUE)
eda(model_SLR$selected)

## MLR (Multiple Linear Regression with intercept)
model_MLR1 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = TRUE)
eda(model_MLR1$selected)

## MLR (Multiple Linear Regression without intercept)
model_MLR2 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = FALSE)
eda(model_MLR2$selected)

}
\author{
Shushun Ren, email: \email{shushunr@umich.edu}
}
