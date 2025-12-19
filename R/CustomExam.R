#' Generate Customized Synthetic Exam Data Based on Beta-Distributed Abilities
#'
#' Creates fully synthetic customized multiple-choice exam data for one exam,
#' simulating latent student ability using a beta distribution.
#'
#' Given shape parameters and the number of students, the function generates students' latent
#' ability values between 0 and 1. The exam score and item scores are derived from the
#' given ability level and the number of items in the exam. The function returns either raw  item scores (0/1) or
#' multiple-choice responses in capital letters. Options for customizing the exam data are:
#'
#'@param n_stud Numeric value. Number of students/rows in the desired dataset.
#'@param n_item Numeric value. Number of items in the exam.
#'@param shape1 Numeric value. Corresponds to first shape parameter of a beta distribution.
#'Impacts underlying ability distribution for the data generation. Defaults to 10.
#'@param shape2 Numeric value. Corresponds to second shape parameter of a beta distribution.
#'Impacts underlying ability distribution for the data generation. Defaults to 3.
#'@param responses Logical. If TRUE, output consists of multiple-choice responses in capital letters.
#'If FALSE, output contains binary item scores '(0 = incorrect, 1 = correct). Defaults to TRUE.
#'@param resp_cat Numeric value. Number of response options per item. Defaults to 4 (A-D).
#'@param correct Vector. A vector containing the sequence of correct responses to the exam items as characters.
#'Defaults to c(rep("A",n_item)).
#'
#'@return A data frame containing either numeric item scores or categorical responses.
#'The rows represent the students. The columns represent the items.
#'
#'@examples
#'Generate custom exam responses for a 5-question single-choice exam with a custom correct response vector:
#'CustomExam(n_stud=5,n_item=5, shape1=5, shape2=5, n_cat=5, correct=c("A","B","C","D","E"))
#'
#'@export

CustomExam <- function(n_stud, n_item, shape1=10, shape2=3, responses = TRUE,
                       n_cat = 4, correct = c(rep("A",n_item))) {
  # step 1: students' abilities
  students_abilities <- rbeta(n = n_stud, shape1 = shape1, shape2 = shape2)

  # step 2: students' item scores
  item_df <- as.data.frame(t(sapply(students_abilities, .GenerateItemData, n_item = n_item)))

  item_ids <- sprintf("%02d", rep(seq_len(n_item)))
  colnames(item_df) <- paste0("item", "_", item_ids)

  # step 4 (optional): turn scores into responses as capital letters
  if (responses) {
    response_df <- .CustomResponses(item_df, n_cat = n_cat, correct = correct)
    return(response_df)
  } else {
    return(item_df)
  }


}





