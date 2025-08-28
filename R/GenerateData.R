#' Generate Synthetic Exam Data Based on Beta-Distributed Abilities
#' 
#' Creates fully synthetic multiple-choice exam data, simulating latent student  
#' abilities using a beta distribution.
#' 
#' Given shape parameters and the number of students, the function generates students' latent  
#' ability values between 0 and 1. Exam scores are simulated by introducing variation  
#' around these ability values. Item scores are derived from exam scores based on  
#' the computed number of correct responses per exam. The function returns either raw  
#' item scores (0/1) or multiple-choice responses (A-D), where 'A' represents a correct answer.
#'
#'@param n_stud Numeric value. Number of students/rows in the desired dataset.
#'@param n_exam Numeric value. Number of exams to generate data for.
#'@param n_item Numeric value. Number of items per exam.
#'@param shape1 Numeric value. Corresponds to first shape parameter of a beta distribution. 
#'Impacts underlying ability distribution for the data generation. Defaults to 10. 
#'@param shape2 Numeric value. Corresponds to second shape parameter of a beta distribution. 
#'Impacts underlying ability distribution for the data generation. Defaults to 3.
#'@param responses Logical. If TRUE, output consists of multiple-choice responses 
#'('A' for correct, 'B'-'D' for incorrect). If FALSE, output contains binary item scores 
#'(0 = incorrect, 1 = correct). Defaults to TRUE.
#'
#'@return A data frame containing either numeric item scores or categorical responses. 
#'The rows represent the students. The columns represent the items across all exams. 
#'
#'@examples
#' # Generate data with default parameters
#' GenerateData(n_stud = 100, n_exam = 3, n_item = 20)
#'
#' # Customize shape parameters
#' GenerateData(n_stud = 50, n_exam = 2, n_item = 10, shape1 = 8, shape2 = 5)
#'
#'@export


GenerateData <- function(n_stud, n_exam, n_item, shape1 = 10, shape2 = 3, responses = TRUE) {
  # step 1: students' abilities
  students_abilities <- rbeta(n = n_stud, shape1 = shape1, shape2 = shape2)
  
  # step 2: students' exam scores
  exam_data <- lapply(students_abilities, .GenerateExamData, n_exam = n_exam)
  
  # step 3: students' item scores
  item_df <- as.data.frame(t(sapply(exam_data, .GenerateItemData, n_item = n_item))) 
  
  exam_ids <- sprintf("%02d", rep(seq_len(n_exam), each = n_item))
  item_ids <- sprintf("%02d", rep(seq_len(n_item), times = n_exam))
  colnames(item_df) <- paste0(exam_ids, "_", item_ids)
  
  # step 4 (optional): turn scores into responses A,B,C,D
  if (responses) {
    response_df <- .GenerateResponseData(item_df)
    return(response_df)
  } else {
    return(item_df)
  }
  
}

# DEFAULT_SHAPE1 <- 10
# DEFAULT_SHAPE2 <- 3
# GenerateData <- function(n_stud, n_exam, n_item, shape1 = DEFAULT_SHAPE1, shape2 = DEFAULT_SHAPE2, responses = TRUE) {
# ??


