#===============================================================================
#     File: run_case.sh
#  Created: 05/30/2017, 14:50
#   Author: Bernie Roesler
#
#  Description: Run VLM data case and store output
#   Usage: ./run_case matlab_file.m
#
#===============================================================================

if [ $# -eq 1 ]; then 
    fileroot=${1%.*}  # Strip extension
else
    fileroot='hello'
fi


if [ -f "${fileroot}.m" ]; then
    # Prepend date and time to filename for ID
    date_str=$(date +'%y%m%d_%H%M')
    diary_name="${date_str}_${fileroot}_diary.txt"
    matlab_cmd="diary('${diary_name}'); ${fileroot}; exit"

    rm -f "${diary_name}"    # clean slate
    matlab -nosplash -nodisplay -r "${matlab_cmd}"

    # E-mail me upon completion
    if [ "$?" -eq 0 ]; then
        email_string="Your code $fileroot has finished successfully!"
    else
        email_string="Your code $fileroot has exited with some errors!"
    fi

    mail -s "$(hostname) simulation complete!" bernard.roesler@gmail.com <<-EOF
	${email_string}
	EOF

else
    printf "Usage: ./run_case [valid-matlab-code-file.m]\n" 1>&2
    exit 1
fi

echo "done."
exit 0
#===============================================================================
#===============================================================================
