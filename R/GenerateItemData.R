#' Generate Item Scores Based on Exam Scores
#'
#' For each exam score provided in `exam_data`, this function computes the required
#' number of correct responses by multiplying the exam score by the total number of items
#' (`n_item`) and rounding the result. It then creates a binary response vector of length
#' `n_item`, randomly assigning the computed number of correct responses (coded as 1) and the
#' remainder as incorrect (coded as 0).
#' 
#'@param exam_data List. Each element is a numeric exam score (between 0 and 1) for a student.
#'@param n_item Numeric value. Number of items per exam.
#'
#'@return A numeric vector containing binary item scores (0/1) for a single exam, where the
#'   number of 1's approximates the respective exam score. In the context of the package,
#'   this output is used to construct a matrix with student responses.
#'
#'@examples
#' # Suppose a student has an exam score of 0.7 and there are 10 items:
#' exam_score <- 0.7
#' .GenerateItemData(exam_data = list(exam_score), n_item = 10)


.GenerateItemData <- function(exam_data, n_item) { 
  
  unlist(lapply(exam_data, function(exam_score) { 
    n_correct <- round(exam_score * n_item) # compute number of correct responses 
    item_scores <- rep(0, n_item) # initialize response vector
    if (n_correct > 0) { # update response vector unless exam score = 0 
      item_scores[sample(n_item, n_correct)] <- 1 
    }
    return(item_scores)
  }))
}
