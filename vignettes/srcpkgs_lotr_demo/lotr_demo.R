# N.B: the current dir should be set above that folder
library(devtools)
load_all('srcpkgs', export_all = FALSE)

library(lotr)

get_srcpkgs()



pkg_load('lotr')
pkg_load('hobbits')
hobbits()
pkg_unload('hobbits')
