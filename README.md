
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mypackage.11.15.2022

<!-- badges: start -->

[![R-CMD-check](https://github.com/ranen0827/mypackage.11.15.2022/workflows/R-CMD-check/badge.svg)](https://github.com/ranen0827/mypackage.11.15.2022/actions)
[![Codecov test
coverage](https://codecov.io/gh/ranen0827/mypackage.11.15.2022/branch/master/graph/badge.svg)](https://app.codecov.io/gh/ranen0827/mypackage.11.15.2022?branch=master)
<!-- badges: end -->

## Simple/Multiple Linear Regression model

If a single predictor X that has a linear relationship with a response
y, we can build a regression model to analyze their relationship.

-   Consider a SLR (Simple Linear Regression) model:

    ![Y\_{i} = \\beta\_{0}+\\beta\_{1}X\_{i}+\\epsilon\_{i}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Y_%7Bi%7D%20%3D%20%5Cbeta_%7B0%7D%2B%5Cbeta_%7B1%7DX_%7Bi%7D%2B%5Cepsilon_%7Bi%7D "Y_{i} = \beta_{0}+\beta_{1}X_{i}+\epsilon_{i}")
-   Consider a MLR (Multiple Linear Regression) model:

    ![Y\_{i} = \\beta\_{0}+\\beta\_{1}X\_{i}+\\beta\_{2}X\_{i}+...+\\beta\_{p-1}X\_{i}+\\epsilon\_{i}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Y_%7Bi%7D%20%3D%20%5Cbeta_%7B0%7D%2B%5Cbeta_%7B1%7DX_%7Bi%7D%2B%5Cbeta_%7B2%7DX_%7Bi%7D%2B...%2B%5Cbeta_%7Bp-1%7DX_%7Bi%7D%2B%5Cepsilon_%7Bi%7D "Y_{i} = \beta_{0}+\beta_{1}X_{i}+\beta_{2}X_{i}+...+\beta_{p-1}X_{i}+\epsilon_{i}")

## Regression Model without intercept

-   Sometimes we may not need intercept (e.g. Categorical variables with
    all dummy variables included in the model), we can conduct linear
    regression model without intercept, the model looks like this:  

    ![Y\_{i} = \\beta\_{1}X\_{i}+\\beta\_{2}X\_{i}+...+\\beta\_{p-1}X\_{i}+\\epsilon\_{i}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Y_%7Bi%7D%20%3D%20%5Cbeta_%7B1%7DX_%7Bi%7D%2B%5Cbeta_%7B2%7DX_%7Bi%7D%2B...%2B%5Cbeta_%7Bp-1%7DX_%7Bi%7D%2B%5Cepsilon_%7Bi%7D "Y_{i} = \beta_{1}X_{i}+\beta_{2}X_{i}+...+\beta_{p-1}X_{i}+\epsilon_{i}")

## Functions

-   `lm_mat()` gives basic information of the variables from the linear
    model, as well as matrix notations useful for further calculation
-   `coef1()` creates coefficient table of the linear model, calculate R
    squared and Adjusted R squared, as well as covariance matrix of the
    model
-   `model_diag()` creates useful diagrams for model diagnostics (using
    residuals
    ![\\hat{\\epsilon}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7B%5Cepsilon%7D "\hat{\epsilon}"),
    fitted values
    ![\\hat{Y}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7BY%7D "\hat{Y}")
    and original values
    ![\\hat{Y}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7BY%7D "\hat{Y}"))
-   `eda()` creates useful diagrams for *Exploratory Data Analysis*
    (EDA) of the variables selected from data frames

## Installation

You can install the development version of package.test.11.15 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ranen0827/mypackage.11.15.2022", build_vignettes = T)
```

## Usage

This is a basic example which shows you how to solve a common problem:

``` r
library(package.test.11.15)
## load dataset mtcars
head(mtcars)
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

## lm_mat() function -->
model <- lm_mat("mpg", c("drat", "disp", "wt"), mtcars, beta0 = TRUE)
names(model)
#>  [1] "xvar"      "yvar"      "Dataset"   "selected"  "beta0"     "N"        
#>  [7] "p"         "X"         "Y"         "H"         "Y_hat"     "residuals"

## coef1() function -->
coef1(model)
#> $Coefficients
#>                Estimate   Std.Error    t_value      p_value Sig.
#> (Intercept) 31.04325728 7.099791769  4.3724180 0.0001537253  ***
#> drat         0.84396531 1.455050731  0.5800247 0.5665366794     
#> disp        -0.01638916 0.009578313 -1.7110692 0.0981268355    .
#> wt          -3.17248250 1.217156605 -2.6064703 0.0144951539    *
#> 
#> $F_test
#>    F_value df1 df2      p_value Sig.
#>   33.78303   3  28 1.920364e-09  ***
#> 
#> $Signif.codes
#> [1] "0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1"
#> 
#> $Adj.R_square
#> [1] 0.7603385
#> 
#> $R_square
#> [1] 0.7835315
#> 
#> $Covariance_matrix
#>             (Intercept)         drat          disp           wt
#> (Intercept) 50.40704316 -9.826936403 -4.214550e-03 -4.295412797
#> drat        -9.82693640  2.117172629  3.350457e-03  0.447391094
#> disp        -0.00421455  0.003350457  9.174408e-05 -0.009014825
#> wt          -4.29541280  0.447391094 -9.014825e-03  1.481470200
```

``` r
## model_diag() function -->
model_diag(model)
#> `geom_smooth()` using formula 'y ~ x'
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="man/figures/README-model_diagnostics-1.png" width="100%" />

``` r
## eda() function -->
eda(mtcars[,c(model$yvar, model$xvar)])
```

<img src="man/figures/README-eda-1.png" width="100%" />

    #> [1] "plot complete"
