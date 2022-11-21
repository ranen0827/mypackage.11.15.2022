#'eda
#'
#'Exploratory Data Analysis of the selected variables from linear model
#'
#'@param model_df Data frame containing potential variables from the dataset
#'
#'
#'@return Diagram matrices containing scatterplot between variables (at lower triangle of the matrix),
#'histogram and name of certain variables (at diagonal), as well as correlation coefficients (at upper triangle of the matrix)
#'
#'@examples
#'## SLR (Simple Linear Regression)
#'model_SLR = lm_mat("mpg", c("cyl"), mtcars, beta0 = TRUE)
#'eda(mtcars[,c(model_SLR$yvar, model_SLR$xvar)])
#'
#'## MLR (Multiple Linear Regression with intercept)
#'model_MLR1 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = TRUE))
#'eda(mtcars[,c(model_MLR1$yvar, model_MLR1$xvar)])
#'
#'## MLR (Multiple Linear Regression without intercept)
#'model_MLR2 = lm_mat("mpg", c("cyl", "disp"), mtcars, beta0 = FALSE))
#'eda(mtcars[,c(model_MLR2$yvar, model_MLR2$xvar)])
#'
#'@export
#'
#'
#'



eda <- function(model_df){
  panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
  {
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- abs(cor(x, y))
    txt <- format(c(r, 0.123456789), digits = digits)[1]
    txt <- paste0(prefix, txt)
    if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex = cex.cor * r)
  }
  panel.hist <- function(x, ...)
  {
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(usr[1:2], 0, 1.5) )
    h <- hist(x, plot = FALSE)
    breaks <- h$breaks; nB <- length(breaks)
    y <- h$counts; y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
  }
  pairs(model_df, lower.panel = panel.smooth, upper.panel = panel.cor, diag.panel = panel.hist)
}


