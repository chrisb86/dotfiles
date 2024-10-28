# Autoload additional functions

if [[ -d "${ZAUTOLOADDIR}" ]]; then

    fpath=($fpath ${ZAUTOLOADDIR})

    # Load functions
    for func in ${ZAUTOLOADDIR}/*; do
        autoload -Uz ${func:t}
    done
fi