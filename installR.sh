R <<EOF
options("http://cran.us.r-project.org")
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

# universal solution and move this to future scripts folder 
    ## need to figure out the nested EOF in bash first 
# what about Rprofile and libpaths
