#' list the available hobbits
#' @return hobbit names as character
#' @export
hobbits <- function() {
  res <- list()
  # N.B: easier to edit programmatically in the vignette this way
  res$frodo <- frodo::frodo() # in imports
  res$bilbo <- bilbo() 

  res
}
