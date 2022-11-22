test_that("model_diag function works", {
  model <- lm_mat("mpg", c("drat", "disp", "wt"), mtcars, beta0 = TRUE)
  expect_equal(length(model_diag(model)$layer), 8)
})
