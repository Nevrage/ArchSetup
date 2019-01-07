R --no-save <<EOF
options(repos= "http://cran.us.r-project.org")
install.packages("tidyverse")
install.packages("knitr")
install.packages("rmarkdown")
install.packages("kableExtra")
install.packages("lintr")
install.packages("shiny")
install.packages("devtools")
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec(name = 'ir34', displayname = 'R 3.4.4')
devtools::install_github("jalvesaq/colorout")
install.packages("sf")
EOF

# How to do nested EOF in bash
# what about Rprofile and libpaths
