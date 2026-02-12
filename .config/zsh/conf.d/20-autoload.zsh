# Autoload additional functions

if [[ -d "${ZAUTOLOADDIR}" ]]; then

  fpath=(${ZAUTOLOADDIR} $fpath)

  # Load functions
  for func in ${ZAUTOLOADDIR}/*; do
    autoload -Uz ${func:t}
  done
fi
