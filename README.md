# Recreating Linear Model Function
## Fall 2024
## The function _my_lm_ recreates a multiple linear regression model nearly identical to the build-in R function _lm_. The function uses matrix operations (built into R) and the package _glue_, which can be installed via _Install.packages(‘glue’)_. 

## When calling the function my_lm, it requires three parameters:
### Data: the name of the dataframe in R with the variables of interest for the linear regression. Data must be imported into R before it can be entered as a parameter into the model.
### Outcome: the column name in the data dataframe that will be the outcome variable. When inputting as a parameter, should be entered as a list. 
### Predictors: the column name(s) in the data that will be the predictors. When inputting as a parameter, should be entered as a list:

## The test case of the function is the built-in dataset _airquality_ in R. The function checks conditions of the data, searching for missing values and character column vectors to remove. The output is a table consisting of the intercept and beta estimate names, their estimates, the standard error, t-value, and p-value. A summary of the multiple R-squared and F-statistic follow. 
