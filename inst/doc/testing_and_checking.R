## ----setup, include = FALSE---------------------------------------------------
## N.B: we need to setup and make available the demo collection of packages "srcpkgs_lotr_demo"
# setup a temp dir
root_dir <- tempfile()
dir.create(root_dir)
file.copy('srcpkgs_lotr_demo', root_dir, recursive = TRUE)
workdir <- file.path(root_dir, 'srcpkgs_lotr_demo')
knitr::opts_knit$set(root.dir = workdir) # set directory for other chunks


## ----srcpkgs_setup, results = "markup"----------------------------------------

library(srcpkgs)
print(names(get_srcpkgs()))
# cat(clitable::cli_table(as.data.frame(get_srcpkgs())), sep = "\n")

## ----no_tests, results = "markup"---------------------------------------------
print(pkgs_test(reporter = "silent"))

## ----dummy_tests--------------------------------------------------------------
add_dummy_test_to_srcpkg <- function(srcpkg, with_failures = TRUE, with_errors = TRUE, with_warnings = TRUE) {
  withr::local_dir(srcpkg$path)
  dir.create("tests/testthat", recursive = TRUE, showWarnings = FALSE)

  .write_test <- function(name, code, test = name) {
    writeLines(sprintf(r"-----{
    test_that("%s", {
      %s
    })
    }-----", name, code), sprintf("tests/testthat/test-%s.R", test))
  }

  .write_test("success", "expect_true(TRUE)")
  if (with_failures) {
    .write_test("failure", "expect_true(FALSE)")
    .write_test("mixed", "expect_true(FALSE);expect_true(TRUE)")
  }
  .write_test("skip", 'skip("skipping");expect_true(FALSE)')
  if (with_errors) .write_test("errors", 'expect_true(TRUE);stop("Arghh");expect_true(TRUE)')
  if (with_warnings)  .write_test("warning", 'expect_true(FALSE);warning("watch out");expect_true(FALSE)')
  if (with_failures && with_errors)
    writeLines(r"-----{
    test_that("misc1", {
      expect_true(FALSE)
      expect_true(TRUE)
    })
    test_that("misc2", {
      expect_true(FALSE)
      skip("skipping")
    })
    test_that("misc3", {
      expect_true(TRUE)
      expect_true(TRUE)
    })
    test_that("misc4", {
      expect_true(TRUE)
      warning("fais gaffe")
      stop("aie")
      expect_true(TRUE)
    })
    }-----", "tests/testthat/test-misc.R")

  writeLines(sprintf(r"-----{
    library(testthat)
    library(%s)

    test_check("%s")
  }-----", srcpkg$package, srcpkg$package), "tests/testthat.R")
}
i <- 0
for (pkg in get_srcpkgs()) {
  add_dummy_test_to_srcpkg(pkg, i %% 3 == 1, i %% 7 == 1, i %% 5 == 1)
  i <- i + 1
}

## ----with_tests, results = "markup"-------------------------------------------
# N.B: we use the silent testthat reporter because we only want to get the results as tables
test_results <- pkgs_test(reporter = "silent")
print(test_results)

## ----pkgs_test_methods, results = "markup"------------------------------------
print(as.data.frame(test_results))
print(summary(test_results))
print(as.logical(test_results))

print(test_results$bilbo)
print(as.data.frame(test_results$lotr))
print(summary(test_results$lotr))
print(as.logical(test_results$aragorn))

## ----subset-------------------------------------------------------------------
small_collection <- get_srcpkgs(filter = "elves|galadriel|legolas")

## ----fixing-------------------------------------------------------------------
.fix_description <- function(path, lst) {
  df <- read.dcf(path, all = TRUE)
  df2 <- utils::modifyList(df, lst)
  write.dcf(df2, path)
}
for (pkg in small_collection) {
  .fix_description(file.path(pkg$path, "DESCRIPTION"), list(Suggests = "testthat"))
}

## ----checking, results = "markup"---------------------------------------------
check_results <- pkgs_check(small_collection, quiet = TRUE)
print(check_results)

## ----pkgs_check_methods, results = "markup"-----------------------------------
print(as.data.frame(check_results))
print(summary(check_results))
print(as.logical(check_results))

print(check_results$bilbo)
print(as.data.frame(check_results$lotr))
print(summary(check_results$lotr))
print(as.logical(check_results$aragorn))

