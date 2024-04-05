#!/bin/bash
#
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
have_real=$(type -p realpath)
[ "${have_real}" ] && SCRIPT_PATH="$(realpath $SCRIPT_PATH)"
cd $(dirname "${SCRIPT_PATH}")
cd ..

V4DIR="astronvim-template"

[ -d ${V4DIR} ] && mv ${V4DIR} ${V4DIR}-$$

git clone https://github.com/AstroNvim/template ${V4DIR}

[ -d ${V4DIR}-$$ ] && {
  diff -b -r -x '.git' ${V4DIR} ${V4DIR}-$$ > /dev/null && {
    rm -rf ${V4DIR}-$$
    exit 0
  }
  echo "Previous AstroNvim v4 template backed up as ${V4DIR}-$$"
}
