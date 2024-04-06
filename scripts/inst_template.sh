#!/bin/bash
#
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
have_real=$(type -p realpath)
[ "${have_real}" ] && SCRIPT_PATH="$(realpath $SCRIPT_PATH)"
cd $(dirname "${SCRIPT_PATH}")
cd ..

CFG="nvim-Template"
CFDIR="${HOME}/.config/${CFG}"
V4DIR="astronvim-template"

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
  [ -d ${V4DIR} ] || {
    git clone https://github.com/AstroNvim/template ${V4DIR}
  }
  cp -a ${V4DIR} ${CFDIR}
  export NVIM_APPNAME="${CFG}"
  printf "\n\nInitializing ${CFG} ..."
  nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1
  nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1
  nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1
  nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1
  printf " done\n"
  nvim ${CFDIR}/lua/plugins/treesitter.lua
fi
