#' Generate Custom Multiple Choice Item Responses Based on Item Scores
#'
#' For each item score provided in `item_data`, this function assigns a capital letter as
#' multiple choice response. A score of 1 is always transformed into the corresponding letter
#' in the `correct` vector, whereas a score of 0 is transformed into a random other letter within
#' the range defined in `resp.cat`.
#'
#'
#'@param item_data List. Each element is a numeric exam score (between 0 and 1) for a student.
#'@param resp.cat Numeric value. The number of response categories per item in the exam.
#'@param correct Character vector with length of n_item. Specifies the solution to each exam question.
#'
#'@return A data.frame containing the capital letter responses for as many exams as
#'specified in GenerateData, where the number of correct responses approximates the respective ability..
#'
#'@examples
#'# Suppose a student has an exam score of 0.7, there are 10 items:
#' item_data = c(1,0,1,0,1,1,1,0,1,1)
#'# Generate the correct solutions to the 10 exam items:
#' correct <- sample(LETTERS[1:6], 10, replace = T)
#' # Generate the response data of that person:
#' .CustomResponses(item_data, n_cat = 6, correct = correct)
#'

.CustomResponses <- function(item_data, n_cat=4, correct){
  response_df <- as.data.frame(item_data)

  for (i in 1:ncol(response_df)){

    # wrong answers
    wrong <- setdiff(LETTERS[1:n_cat], correct[i])

    # replace 1's with correct response
    response_df[response_df[, i] == 1, i] <- correct[i]

    # replace 0's with random wrong responses
    response_df[response_df[, i] == 0, i] <- sample(wrong,
                                                    sum(response_df[, i] == 0),
                                                    replace = TRUE)}

  return(response_df)}
