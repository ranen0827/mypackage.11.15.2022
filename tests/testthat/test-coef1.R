test_that("coef1 function works when beta0 = TRUE", {
  model <- lm_mat("mpg", c("drat", "disp", "wt"), mtcars, beta0 = TRUE)
  coef1 <- coef1(model)
  model1 <- lm(mpg~drat+disp+wt, mtcars)

  expect_equal(coef1$R_square, summary(model1)$r.squared)
  expect_equal(coef1$Adj.R_square, summary(model1)$adj.r.squared)

})

test_that("coef1 function works when beta0 = FALSE", {
  model <- lm_mat("mpg", c("drat", "disp", "wt"), mtcars, beta0 = FALSE)
  coef1 <- coef1(model)
  model1 <- lm(mpg~-1+drat+disp+wt, mtcars)

  expect_equal(coef1$R_square, summary(model1)$r.squared)
  expect_equal(coef1$Adj.R_square, summary(model1)$adj.r.squared)

})
