#!/bin/csh
tar cf temp.tar no.such.file
if ( $status == 0 ) echo "Good news! No error."
