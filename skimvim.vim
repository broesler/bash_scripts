
# set hidden
# if bufexists('$file')
#   exe ":buffer " . bufnr('$file')
# else
#   edit ${file// /\ } " replace spaces with escaped spaces
# endif
# $line
