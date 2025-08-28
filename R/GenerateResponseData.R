#' Generate Multiple Choice Item Responses Based on Item Scores
#'
#' For each item score provided in `item_data`, this function assigns a multple choice 
#' response between A and D. A score of 1 is always transformed into A, whereas
#' a score of 0 is transformed into B, C or D by random.
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
#' .GenerateResponseData(item_data = c(1,0,1,0,1,1,1,0,1,1))
#' 

.GenerateResponseData <- function(item_data) {
  
  response_df <- as.data.frame(item_data)
  response_df[response_df == 1] <- "A"
  incorrect <- sample(c("B","C","D"), length(response_df[response_df == 0]), replace = TRUE)
  response_df[response_df == 0] <- incorrect
  return(response_df)}
