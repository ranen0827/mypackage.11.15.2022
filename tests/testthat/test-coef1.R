test_that("coef1 function works when beta0 = TRUE", {
  model <- lm_mat("Sepal.Length", c("Sepal.Width", "Petal.Length", "Petal.Width"), iris, beta0 = TRUE)
  coef1 <- coef1(model)
  model1 <- lm(Sepal.Length~Sepal.Width+Petal.Length+Petal.Width, iris)

  expect_equal(coef1$R_square, summary(model1)$r.squared)
  expect_equal(coef1$Adj.R_square, summary(model1)$adj.r.squared)

})

test_that("coef1 function works when beta0 = FALSE", {
  model <- lm_mat("Sepal.Length", c("Sepal.Width", "Petal.Length", "Petal.Width"), iris, beta0 = FALSE)
  coef1 <- coef1(model)
  model1 <- lm(Sepal.Length~-1+Sepal.Width+Petal.Length+Petal.Width, iris)

  expect_equal(coef1$R_square, summary(model1)$r.squared)
  expect_equal(coef1$Adj.R_square, summary(model1)$adj.r.squared)

})
