#!/bin/bash
#
# Usage: ./inst.sh [-r] [-t]
# Where: -r indicates removal, -t indicates perform a test invocation

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
have_real=$(type -p realpath)
[ "${have_real}" ] && SCRIPT_PATH="$(realpath $SCRIPT_PATH)"
cd $(dirname "${SCRIPT_PATH}")
cd ..

CFG="nvim-AstroNvimV4"
CFDIR="${HOME}/.config/${CFG}"

clean_data() {
  rm -rf "${HOME}/.local/share/${CFG}"
  rm -rf "${HOME}/.local/state/${CFG}"
  rm -rf "${HOME}/.cache/${CFG}"
}

have_lman=$(type -p lazyman)
if [ "${have_lman}" ]; then
  lazyman -R -N ${CFG} -y
else
  clean_data
fi
rm -rf ${CFDIR}
if [ "$1" == "-r" ]; then
  clean_data
else
  cp -a astronvim_v4 ${CFDIR}
  export NVIM_APPNAME="${CFG}"
  printf "\n\nInitializing ${CFG} ..."
  nvim --headless "+Lazy! sync" +qa
  printf " done\n"
  [ "$1" == "-t" ] && {
    vim ${CFDIR}/lua/configuration.lua
    nvim ${CFDIR}/lua/configuration.lua
  }
fi
