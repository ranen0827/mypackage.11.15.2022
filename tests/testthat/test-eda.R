test_that("eda function works", {
  model <- lm_mat("mpg", c("drat", "disp", "wt"), mtcars, beta0 = TRUE)
  expect_equal(eda(model$selected), "plot complete")
})

