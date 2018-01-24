update-log() {
    [[ $# == 2 ]] || return 1
    HOURS=$1
    MSG=$2
    ssh eh169@csserver.evansville.edu 'echo "'$(date +%m/%d/%Y)'|'${HOURS}'|'"${MSG}"'" >> www_home/497logfile.txt'
}
