test_that("eda function works", {
  model <- lm_mat("Sepal.Length", c("Sepal.Width", "Petal.Length", "Petal.Width"), iris, beta0 = TRUE)
  expect_equal(eda(model$selected), "plot complete")
})

