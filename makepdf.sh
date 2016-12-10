#!/bin/bash
# Compile LaTeX WITHOUT bibliography
makepdf()
{
  # include synctex zipped file for linking to pdf file
  pdfcommand='pdflatex -synctex=1 -interaction=nonstopmode -file-line-error'
  texclean && $pdfcommand $1 && $pdfcommand $1
}
