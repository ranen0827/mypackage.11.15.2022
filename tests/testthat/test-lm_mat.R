test_that("lm_mat only accept dataframe/vector to be parameter 'data'", {
  expect_error(lm_mat("mpg", c("drat", "disp", "wt"), as.matrix(mtcars), beta0 = TRUE))
  expect_error(lm_mat("mpg", c("drat", "disp", "wt"), as.list(mtcars), beta0 = TRUE))
  })


test_that("lm_mat cannot deal with variables' name not in the given dataset", {
  expect_error(lm_mat("mp", c("drat", "disp", "wt"), mtcars), beta0 = TRUE)
  expect_error(lm_mat("mpg", c("drt", "disp", "wt"), mtcars), beta0 = TRUE)
  expect_error(lm_mat("mp", c("dis", "wt"), mtcars), beta0 = TRUE)
  expect_error(lm_mat("mp", c("dis", "wt"), mtcars))
  })

test_that("lm_mat cannot deal with variables' name not in the given dataset", {
  model <- lm_mat("mpg", c("drat", "disp", "wt"), mtcars, beta0 = TRUE)
  X <- matrix(c(rep(1,nrow(data)), data[,x[1]], data[,x[2]]),nrow(data),3)
  expect_equal(model$H, X %*% solve(t(X) %*% X) %*% t(X))
})
