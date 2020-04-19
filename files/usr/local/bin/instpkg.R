#!/usr/local/bin/Rscript --vanilla --default-packages=utils
args <- commandArgs(TRUE)

options(repos =
    c(
        CRAN = paste0("https://cran.microsoft.com/snapshot/", args[1L]),
        mlr3learners = "https://mlr3learners.github.io/mlr3learners.drat"
    ),
    download.file.method = "libcurl",
    menu.graphics = FALSE
)

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

quit("no", as.numeric(inherits(try(install(args[-1L])), "try-error")))
