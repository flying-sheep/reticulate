python_has_module <- function(python, module) {
  code <- paste("import", module)
  args <- c("-E", "-c", shQuote(code))
  status <- system2(python, args, stdout = FALSE, stderr = FALSE)
  status == 0L
}

python_version <- function(python) {
  code <- "import platform; print(platform.python_version())"
  args <- c("-E", "-c", shQuote(code))
  output <- system2(python, args, stdout = TRUE, stderr = FALSE)
  sanitized <- gsub("[^0-9.-]", "", output)
  numeric_version(sanitized)
}

python_module_version <- function(python, module) {
  fmt <- "import %1$s; print(%1$s.__version__)"
  code <- sprintf(fmt, module)
  args <- c("-E", "-c", shQuote(code))
  output <- system2(python, args, stdout = TRUE, stderr = FALSE)
  numeric_version(output)
}
