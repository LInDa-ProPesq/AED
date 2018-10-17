# install rmarkdown
install.packages("rmarkdown")

# loading library rmarkdown
#library(rmarkdown)

# install tinytex
#install.packages("tinitex")
library(tinytex)
#install_tinytex(force = TRUE, dir = "auto", repository = "ctan", extra_packages = NULL)
#tinytex_root()
# [1] "C:\\projetos\\project-rmarkdown\\auto"
use_tinytex(from = "C:\\projetos\\project-rmarkdown\\auto")
#Use of uninitialized value in bitwise or (|) at C:\projetos\project-rmarkdown\auto\texmf-dist\scripts\texlive\tlmgr.pl line 1482.
#Restart R and your editor and check if tinytex::tinytex_root() points to C:\projetos\project-rmarkdown\auto
