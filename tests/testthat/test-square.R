test_that("multiplication works", {
  expect_equal(square(2), 4)
  expect_equal(square(1:3), c(1,4,9))
})
