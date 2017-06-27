#!/bin/csh
unset foo
if ( ! $?foo ) then
    echo foo was unset
    set foo # "do the right thing"
else if ( "$foo" = "You lose" ) then
    echo $foo
endif
