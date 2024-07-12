#!/usr/bin/env bash

LOCAL_DIR=$(dirname $(readlink -f ${0}))

LOCAL_FILE=sdml.ctags

if [[ "$OSTYPE" == "win32" ]]; then
    CONFIG_PATH="${HOMEDRIVE}${HOMEPATH}/ctags.d"
else
    if [[ -d "${HOME}/.ctags.d" ]]; then
        CONFIG_PATH="${HOME}/.ctags.d"
    elif [[ -n ${XDG_CONFIG_HOME} && -d "${XDG_CONFIG_HOME}/ctags" ]]; then
        CONFIG_PATH="${XDG_CONFIG_HOME}/ctags"
    elif [[ -n ${XDG_CONFIG_HOME} && -d "${XDG_CONFIG_HOME}" ]]; then
        CONFIG_PATH="${XDG_CONFIG_HOME}/ctags"
    else
        CONFIG_PATH="${HOME}/.config/ctags"
    fi
fi

if [[ ${1} == "remove" ]]; then
    echo "Removing installed file ${CONFIG_PATH}/${LOCAL_FILE}"
    rm "${CONFIG_PATH}/${LOCAL_FILE}"
else
    if [[ ! -d ${CONFIG_PATH} ]]; then
        echo "Creating config directory ${CONFIG_PATH}"
        mkdir -p ${CONFIG_PATH}
    fi

    if [[ ${1} == "copy" ]]; then
        echo "Copying from ${CONFIG_PATH}/${LOCAL_FILE} to ${LOCAL_DIR}/${LOCAL_FILE}"
        cp "${CONFIG_PATH}/${LOCAL_FILE}" "${LOCAL_DIR}/${LOCAL_FILE}"
    elif [[ ${1} == "link" || -z ${1} ]]; then
        echo "Linking from ${CONFIG_PATH}/${LOCAL_FILE} to ${LOCAL_DIR}/${LOCAL_FILE}"
        ln -s "${LOCAL_DIR}/${LOCAL_FILE}" "${CONFIG_PATH}/${LOCAL_FILE}"
    else
        echo "Unknown option: ${1}, expecting (copy|link|remove)"
    fi
fi
