#!/bin/bash

# Exit codes
SUCCESS=0
INVALID_ARGUMENT_ERROR=1
YOU_NEED_NO_CHANGES_BEFORE_RUN_CLEANUP_ERROR=3

# Default arguments' values
AUTO_COMMIT=yes

echo ""
echo "--- --- ---"
echo "Alright Cleanup Code Command-Line Tool"
echo "Default settings:"
echo "- auto commit re-formatted code (-a): '${AUTO_COMMIT}'"
echo "--- --- ---"
echo ""

while getopts a: flag; do
    case "${flag}" in
    a) AUTO_COMMIT=${OPTARG} ;;
    *)
        echo ""
        echo "--- --- ---"
        echo "Invalid argument's flag is not handled"
        echo "--- --- ---"
        echo ""
        exit ${INVALID_ARGUMENT_ERROR}
        ;;
    esac
done

if [ "${AUTO_COMMIT}" != "yes" ] && [ "${AUTO_COMMIT}" != "no" ]; then
    echo ""
    echo "--- --- ---"
    echo "INVALID ARGUMENT OF '-a' equals '${AUTO_COMMIT}'"
    echo "Set 'yes' or 'no' or omit to use default equals 'no'"
    echo "--- --- ---"
    echo ""
    exit ${INVALID_ARGUMENT_ERROR}
fi

UN_STAGED_CHANGES=$(git diff --name-only)
if [ -z "${UN_STAGED_CHANGES}" ]; then
    echo ""
    echo "--- --- ---"
    echo "Right, there are no un-staged changes"
    echo "--- --- ---"
    echo ""
else
    echo ""
    echo "--- --- ---"
    echo "There are un-staged changes"
    echo "Commit them before run the script"
    echo "--- --- ---"
    echo ""

    git diff --name-only
    exit ${YOU_NEED_NO_CHANGES_BEFORE_RUN_CLEANUP_ERROR}
fi

STAGED_UNCOMMITTED=$(git diff --staged --name-only)
if [ -z "${STAGED_UNCOMMITTED}" ]; then
    echo ""
    echo "--- --- ---"
    echo "Right, there is no any changes, repo is ready to cleanup"
    echo "--- --- ---"
    echo ""
else
    echo ""
    echo "--- --- ---"
    echo "There are staged, uncommitted changes"
    echo "Commit them before run the script"
    echo "--- --- ---"
    echo ""

    git diff --staged --name-only
    exit $YOU_NEED_NO_CHANGES_BEFORE_RUN_CLEANUP_ERROR
fi

#
# Parse arguments and put them into an array to call command
# I'm at a loss for words to describe how I managed to nail this function
# Once again I understand why all Ops always looks stressed out
#
INPUT_JB_CLEANUP_CODE_ARG="--profile=Almost Full Cleanup --disable-settings-layers=SolutionPersonal --verbosity=INFO"
ARG_DELIMITER="--"
S=${INPUT_JB_CLEANUP_CODE_ARG}${ARG_DELIMITER}
COMMAND_ARG_ARRAY=()

while [[ $S ]]; do
    ITEM="${S%%"$ARG_DELIMITER"*}"
    if [ -n "${ITEM}" ]; then
        if [ "${ITEM:0-1}" == " " ]; then
            ITEM="${ITEM::-1}"
        fi
        COMMAND_ARG_ARRAY+=("--${ITEM}")
    fi
    S=${S#*"$ARG_DELIMITER"}
done

echo ""
echo "--- --- ---"
echo "Let's get started, keep calm and wait, it may take few moments"
for arg in "${COMMAND_ARG_ARRAY[@]}"; do
    echo "Command argument: [${arg}]"
done
echo "--- --- ---"
echo ""

#
# For first run un-comment the two commands down below
# Don't forget add manifesto file `jetbrains.resharper.globaltools`
# See the manifesto file here: `./.config/dotnet-tools.json`
#
# dotnet tool restore
# dotnet tool update --global JetBrains.ReSharper.GlobalTools
#

jb cleanupcode "${COMMAND_ARG_ARRAY[@]}" ReSharperCleanupCodeDemo.sln

RE_FORMATTED_FILES=$(git diff --name-only)

if [ -z "$RE_FORMATTED_FILES" ]; then
    echo ""
    echo "--- --- ---"
    echo "No files re-formatted, everything is clean, congratulation!"
    echo "--- --- ---"
    echo ""
    exit $SUCCESS
fi

if [ $AUTO_COMMIT = "no" ]; then
    echo ""
    echo "--- --- ---"
    echo "There is re-formatted code but it will not be auto committed"
    echo "--- --- ---"
    echo ""
    exit $SUCCESS
fi

echo ""
echo "--- --- ---"
echo "There are re-formatted files to be committed"
echo "--- --- ---"
echo ""

git diff --name-only

for FILE in "${RE_FORMATTED_FILES[@]}"; do
    git add $FILE
done

echo ""
echo "--- --- ---"
echo "Staged files to be committed"
echo "--- --- ---"
echo ""

git diff --staged --name-only

echo ""
echo "--- --- ---"
echo "Create commit"
echo "--- --- ---"
echo ""

git commit -m "Re-format code by JetBrains CleanupCode Tool"

echo ""
echo "--- --- ---"
echo "Commit created"
echo "--- --- ---"
echo ""

git status

echo ""
echo "--- --- ---"
echo "All re-formatted code has been committed with success"
echo "--- --- ---"
echo ""
exit $SUCCESS
