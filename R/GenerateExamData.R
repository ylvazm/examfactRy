#' Generate Exam Scores with Controlled Variation Around Ability
#'
#' This function simulates exam scores by introducing controlled variance around  
#' a predefined student ability level. 
#'
#' The process consists of three steps:
#' 1. Sample raw deviation values from a beta distribution,  
#'    where the shape parameters control the spread of variance.  
#' 2. Center the sampled deviations around the student's ability, ensuring  
#'    that the final scores reflect realistic performance fluctuations.  
#' 3. Constrain the output scores between 0 and 1, maintaining valid probability-like values.  
#'
#' The form of the beta distribution to draw deviation values from depends on the student's ability:  '
#' `shape1` is predefined to 10, whereas `shape2` is informed by the students' ability, 
#' assigning a higher value to students with higher ability.
#' This ensures that higher-performing students have less fluctuation in their exam  
#' scores, while lower-performing students experience more variation.
#' 
#'@param ability Numeric value. A student's latent ability score between 0 and 1.
#'@param n_exam Numeric value. Number of exams to generate data for.
#'
#'@return A numeric vector of length `n_exam` containing simulated exam scores.
#'
#'@examples
#' # Generate exam scores for a student with ability 0.6 across 5 exams
#' .GenerateExamData(ability = 0.6, n_exam = 5)


.GenerateExamData <- function(ability, n_exam){ 
  
  if (ability <= 0.25) {
    shape2 <- 20
  } else if (ability >0.25 & ability <= 0.5) {
    shape2 <- 30
  } else if (ability >0.5 & ability <= 0.75) {
    shape2 <- 40
  } else {
    shape2 <- 50
  }
  
  exam_var <- rbeta(n = n_exam, shape1 = 10, shape2 = shape2) 
  exam_dev <- exam_var - mean(exam_var) 
  value_out <- round(ability + exam_dev, 2)
  value_out <- pmin(pmax(value_out, 0), 1) 
  return(value_out)
}
