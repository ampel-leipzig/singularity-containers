#!/usr/local/bin/Rscript --vanilla --default-packages=utils
args <- commandArgs(TRUE)

repos <- structure(c(CRAN="https://cran.wu.ac.at"))
options(repos=repos, menu.graphics=FALSE)
rm(repos)

install <- function(pkgs, ...) {
    capture <- function(e) {
        if (inherits(e, "warning") || inherits(e, "error")) {
            catch <-
                grepl("package.*(is|are) not available", e$message) ||
                grepl(
                    "installation of package.*had non-zero exit status",
                    e$message
                )
            if (catch) {
                stop(e$message, call. = FALSE)
            }
        }
    }
    if (length(pkgs)) {
        withCallingHandlers(install.packages("BiocManager"), warning = capture)
        withCallingHandlers(
            BiocManager::install(
                pkgs,
                ask = FALSE,
                clean = TRUE,
                Ncpus = 3L,
                update = TRUE, 
                checkBuilt = TRUE, 
                INSTALL_opts = c("--strip", "--no-docs", "--no-multiarch")
            ),
            warning = capture
        )
    }
}

quit("no", as.numeric(inherits(try(install(args)), "try-error")))
