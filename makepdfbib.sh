#!/bin/bash
# Compile LaTeX WITH bibliography
makepdfbib()
{
  # include synctex zipped file for linking to pdf file
  pdfcommand='pdflatex -synctex=1 -interaction=nonstopmode -file-line-error'

  # remove aux files and compile
  texclean && $pdfcommand $1
  
  # make sure first attempt exited successfully
  if [ $? -eq 0 ]; then
    # run BiBTeX on each .bib file
    for i in $("ls" *.tex)
    do
      doc=$(echo $i | sed 's/\..*//')     # strip file extension
      bibtex $doc
    done

    # compile twice more and open the pdf output
    $pdfcommand $1 && $pdfcommand $1
  else  # there are errors in the tex, exit
    return 1
  fi
}
