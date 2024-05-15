demo library `LOTR` to exemplify srcpkgs
=========================================

This dummy library of R source packages to exemplify the R package 
[srcpkgs](https://github.com/kforner/srcpkgs)

# prerequisites

install the `srcpkgs` package! (cf https://github.com/kforner/srcpkgs/blob/main/README.md)

# usage

## checkout this repository

```
cd "whereever_you_want_to_work"
git checkout https://github.com/kforner/srcpkgs_lotr_demo.git`
cd srcpkgs_lotr_demo
```

## basic usage


```
# start clean (remove generated roxygen documentation)
make clean

# run R
R

```

### using the hacked R loaders

```
library(srcpkgs)

### using hacked library
# be sure to hack the loaders.
# TODO: describe how it could be done automatically
hack_r_loaders()

library(lotr)
# everything was loaded
str(characters_by_race())

```

### using srcpkgs::pkg_load()

```
library(srcpkgs)


library(lotr)
# everything was loaded
str(characters_by_race())

```

