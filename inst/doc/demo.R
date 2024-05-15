## ----setup, echo = FALSE, results='hide'--------------------------------------
# suppressPackageStartupMessages(library(srcpkgs))

# setup a temp dir
root_dir <- tempfile()
dir.create(root_dir)
file.copy('srcpkgs_lotr_demo', root_dir, recursive = TRUE)
workdir <- file.path(root_dir, 'srcpkgs_lotr_demo')
knitr::opts_knit$set(root.dir = workdir) # set directory for other chunks

## ----devtools_setup, results = 'hide'-----------------------------------------
suppressPackageStartupMessages(library(devtools))
pkgs <- c('bilbo', 'frodo', 'hobbits', 'legolas', 'galadriel', 'elves', 'gimli', 'aragorn', 'gandalf', 'lotr')

## ----devtools_load, error = TRUE----------------------------------------------
load_all('lotr')

## ----devtools_load2, error = TRUE---------------------------------------------
load_all('hobbits')

## ----devtools_load3, message = FALSE------------------------------------------
document('frodo')
load_all('frodo')
document('bilbo')
load_all('frodo')
document('hobbits')
load_all('hobbits')

document('legolas')
load_all('legolas')
document('galadriel')
load_all('galadriel')
document('elves')
load_all('elves')

document('gimli')
load_all('gimli')
document('aragorn')
load_all('aragorn')
document('gandalf')
load_all('gandalf')

## ----devtools_load_final------------------------------------------------------
document('lotr')
load_all('lotr')

# use it
str(lotr())

## ----devtools_edit1-----------------------------------------------------------
names(lotr()$hobbits)

## ----devtools_edit2-----------------------------------------------------------
lines <- readLines('hobbits/R/main.R')
cat(lines, sep = '\n')

## ----devtools_edit3-----------------------------------------------------------
edited_lines <- grep('bilbo', lines, invert = TRUE, value = TRUE)
writeLines(edited_lines, 'hobbits/R/main.R')

## ----devtools_edit4-----------------------------------------------------------
load_all('lotr')
names(lotr()$hobbits)

## ----devtools_edit5-----------------------------------------------------------
load_all('hobbits')
names(lotr()$hobbits)

## ----devtools_edit6, error = TRUE---------------------------------------------
unloadNamespace('hobbits')

## ----devtools_edit7-----------------------------------------------------------
devtools::unload('hobbits')

## ----devtools_edit8, error = TRUE---------------------------------------------
lotr()

## ----devtools_edit9, error = TRUE---------------------------------------------
load_all('hobbits')
names(lotr())

## ----srcpkgs_setup------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
library(srcpkgs)
options(width = 200)
print(get_srcpkgs())

## ----srcpkgs_unload1----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
plan <- pkg_unload('bilbo')
print(plan)

## ----srcpkgs_unload2----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
for (pkg in get_srcpkgs()) pkg_unload(pkg)

## ----srcpkgs_load1------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
plan <- pkg_load('lotr')
print(plan)
print(names(lotr()))

## ----srcpkgs_edit1------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
lotr()$hobbits$frodo

lines <- readLines('frodo/R/main.R')
cat(lines, sep = '\n')

edited_lines <- sub('sting', 'sword', lines)
writeLines(edited_lines, 'frodo/R/main.R')

## ----srcpkgs_edit2------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
plan <- pkg_load('lotr')
print(plan)

## ----srcpkgs_edit3------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
lotr()$hobbits$frodo$weapons

