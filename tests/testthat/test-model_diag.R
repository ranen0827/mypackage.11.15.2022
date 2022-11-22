test_that("model_diag function works", {
  model <- lm_mat("Sepal.Length", c("Sepal.Width", "Petal.Length", "Petal.Width"), iris, beta0 = TRUE)
  expect_equal(length(model_diag(model)$layer), 8)
})
