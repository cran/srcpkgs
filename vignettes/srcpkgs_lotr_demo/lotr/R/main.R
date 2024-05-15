#' list all characters
#' @return as a list
#' @importFrom elves elves
#' @export
lotr <- function() {
  list(
    hobbits = hobbits(),
    elves = elves(),
    dwarves = dwarves(),
    humans = humans(),
    ainur = ainur()
  )
}

#' @importFrom gimli gimli
dwarves <- function() {
  list(gimli = gimli())
}

#' @importFrom aragorn aragorn
humans <- function() {
  list(aragorn = aragorn())
}

#' @importFrom gandalf gandalf
ainur <- function() {
  list(gandalf = gandalf())
}
