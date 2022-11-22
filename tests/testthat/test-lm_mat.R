test_that("lm_mat only accept dataframe/vector to be parameter 'data'", {
  expect_error(lm_mat("Sepal.Length", c("Sepal.Width", "Petal.Length", "Petal.Width"), as.matrix(iris), beta0 = TRUE))
  expect_error(lm_mat("Sepal.Length", c("Sepal.Width", "Petal.Length", "Petal.Width"), as.list(iris), beta0 = TRUE))
  })


test_that("lm_mat cannot deal with variables' name not in the given dataset", {
  expect_error(lm_mat("Sepal.Lengt", c("Sepal.Width", "Petal.Length", "Petal.Width"), iris, beta0 = TRUE))
  expect_error(lm_mat("Sepal.Length", c("Sepal.Widt", "Petal.Length", "Petal.Width"), iris, beta0 = TRUE))
  expect_error(lm_mat("Sepal.Lengt", c("Sepal.Width", "Petal.Length"), iris, beta0 = TRUE))
  expect_error(lm_mat("Sepal.Lengt", c("Sepal.Width", "Petal.Lenth"), iris))
  })

test_that("lm_mat function works", {
  model <- lm_mat("Sepal.Length", c("Sepal.Width", "Petal.Length", "Petal.Width"), iris, beta0 = TRUE)
  X <- matrix(c(rep(1,nrow(iris)), iris[,"Sepal.Width"], iris[,"Petal.Length"], iris[,"Petal.Width"]),nrow(iris),4)
  expect_equal(model$H, X %*% solve(t(X) %*% X) %*% t(X))
})
