# BS803 Final Project
# Reghan Lanning
setwd('/Users/reghanlanning/Desktop/MSABF24/BS806')
gas_vapor <- read.csv('gas_vapor.csv')
install.packages('glue')
library(glue)

# where data is a dataset of interest, outcome is entered as a 'string' and is a column name of the dataset
my_lm <- function(data,outcome,predictors) {
  Intercept <- rep(1, nrow(data))
  predictors <- setdiff(predictors, outcome)
  x <- data.frame(Intercept)
  
  for (i in predictors) {
    if (i %in% colnames(data) && is.numeric(data[[i]]) || is.integer(data[[i]])) {
      x <- cbind(x, data[i])  
    } else {
      print(glue("Predictor '{i}' is not numeric and will be excluded."))
    }
  }
  
  print(x)

  x <- as.matrix(x)

  y <- as.numeric(data[[outcome]])
  
  txx <- t(x)%*%x # transpose of x * x
  txy <- t(x)%*%y # transpose of x * y
  
  beta <- solve(txx)%*%(txy) # inverse of transpose of x * x, transpose x * y
  beta <- round(beta, 4)
  RSS <- t(y)%*%y - t(beta)%*%t(x)%*%y
  
  s.2 <- as.numeric(RSS/(nrow(x)-(length(predictors)-1) - 1)) # where n = 32, p (# of x's) = 4, - 1 (to represent intercept)
  diag_matrix <- (s.2)*solve(t(x)%*%x)
  
  std_error <- sqrt(diag(diag_matrix))
  std_error <- round(std_error,4)
  
  
  print(glue('Beta Coefficients for Predictors:'))
  
  print(glue('{colnames(x)} {beta}  Std Error:{std_error}')) # beta coefficients

  SSREG <- t(beta)%*%t(x)%*%y - length(y)*mean(y)**2
  SYY <- t(y)%*%y - length(y)*mean(y)**2
  
  Rsq <- (1 - (RSS/SYY))
  
  print(glue('Multiple R-Squared: {Rsq}'))
  
  MSR <- SSREG / (ncol(x) - 1)
  MSE <- RSS / (nrow(x)-ncol(x))
  F.stat <- MSR / MSE
  
  p.val <- 1-pf(F.stat,(ncol(x) - 1),(nrow(x)-ncol(x)))
  print(glue('F-Statistic: {F.stat} on {(ncol(x) - 1)} and {(nrow(x)-ncol(x))} DF, p-value = {p.val}'))
}

# test cases
my_lm(gas_vapor,'y',my_predictors)
my_predictors = c('x1','x2','x3','char_column','x4')
gas_vapor$char_column <- sample(letters, 32, replace = TRUE)
