#region `git` aliases.

# Unset existing `git` aliases.
unalias gl gd gt gc gpp gs gk gb 2>/dev/null


# Parse leading `-C` options for custom `git` functions.
_git_parse_C() {
    # Initialize the number of consumed arguments.
    REPLY=0

    # While the first argument is `-C` (i.e., change directory).
    while [[ "${1-}" == "-C" ]]; do
        # If there are fewer than two arguments.
        if (( $# < 2 )); then
            # User feedback.
            printf '%s\n' "${funcstack[2]:-${FUNCNAME[1]:-unknown}}: -C requires a directory" >&2

            # Return an error.
            return 2
        fi

        # Otherwise, append the first two arguments to the `gitOptions` array.
        gitOptions+=("$1" "$2")

        # Shift twice to remove the processed arguments from the list.
        shift 2

        # Increment the number of consumed arguments.
        (( REPLY += 2 ))
    done

    return 0
}


# Define the `gl` function for `git` logging with stash support.
gl() {
    # Declare a local array for `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Declare a local array for storing the optional stash reference.
    local -a stashRefs=()

    # Check whether a stash reference exists in the selected repository.
    if git "${gitOptions[@]}" rev-parse --verify -q refs/stash >/dev/null; then
        # Append the stash reference if it exists.
        stashRefs+=("refs/stash")
    fi

    # Call `git log` with the accumulated options, optional stash reference, and remaining arguments.
    git "${gitOptions[@]}" log --graph --all --pretty=tformat:'%C(auto)%h%d %s %C(green)' "${stashRefs[@]}" "$@"
}


# Define the `gll` function for `git` logging with stash support and relative time.
gll() {
    # Declare a local array for `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Declare a local array for storing the optional stash reference.
    local -a stashRefs=()

    # Check whether a stash reference exists in the selected repository.
    if git "${gitOptions[@]}" rev-parse --verify -q refs/stash >/dev/null; then
        # Append the stash reference if it exists.
        stashRefs+=("refs/stash")
    fi

    # Call `git log` with the accumulated options, optional stash reference, and remaining arguments.
    git "${gitOptions[@]}" log --graph --all --pretty=format:'%C(auto)%h%d %s %C(green)(%cr | %C(dim cyan)%an%C(green))' "${stashRefs[@]}" "$@"
}


# Define a function for displaying `git` diff.
gd() {
    # Declare a local array `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Call `git diff` with the accumulated options and any remaining arguments.
    git "${gitOptions[@]}" diff --unified=1 --color-words "$@"
}


# Define a function for counting `git` commits.
gt() {
    # Declare a local array for `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Call `git rev-list` with the accumulated options and any remaining arguments.
    git "${gitOptions[@]}" rev-list --all --count "$@"
}


# Define a function for creating a `git` commit with a message.
gc() {
    # Declare a local array for `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Call `git commit` with the accumulated options and the supplied commit message.
    git "${gitOptions[@]}" commit -m "$1" "${@:2}"
}


# Define a function for pulling `git` changes with pruning.
gpp() {
    # Declare a local array for `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Call `git pull` with the accumulated options and any remaining arguments.
    git "${gitOptions[@]}" pull --prune "$@"
}


# Define a function for displaying `git` status.
gs() {
    # Declare a local array for `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Call `git status` with the accumulated options and any remaining arguments.
    git "${gitOptions[@]}" status "$@"
}


# Define a function for checking out `git` branches or files.
gk() {
    # Declare a local array for `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Call `git checkout` with the accumulated options and any remaining arguments.
    git "${gitOptions[@]}" checkout "$@"
}


# Define a function for managing `git` branches.
gb() {
    # Declare a local array for `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Call `git branch` with the accumulated options and any remaining arguments.
    git "${gitOptions[@]}" branch "$@"
}


# Define a function for managing `git` worktrees.
gw() {
    # Declare a local array for `git` options.
    local -a gitOptions=()

    # Declare a local variable for the number of consumed arguments.
    local -i REPLY

    # Parse leading `-C` options, returning immediately on failure.
    _git_parse_C "$@" || return

    # Remove the consumed arguments from the function's positional parameters.
    shift "$REPLY"

    # Call `git worktree` with the accumulated options and any remaining arguments.
    git "${gitOptions[@]}" worktree "$@"
}


# If the shell is `zsh`, define and register the completions.
if [[ -n "${ZSH_VERSION-}" ]]; then
    # Define a reusable completion function for custom `git` functions.
    _git_function_completion() {
        # Initialize the internal `git` command index.
        local -i __git_cmd_idx

        # Collect leading `-C` arguments for repository-aware completion.
        local -a __git_C_args
        local -i index

        # For each argument in the command line, starting from the second one.
        for (( index = 2; index + 1 < CURRENT; index += 2 )); do
            # If the argument is not `-C`, break the loop.
            [[ "${words[index]}" == "-C" ]] || break

            # Otherwise, append the `-C` argument and its value to the `__git_C_args` array.
            __git_C_args+=( "-C" "${words[index+1]}" )
        done

        # If completing the directory immediately after a leading `-C` option.
        if (( index == CURRENT - 1 )) && [[ "${words[index]}" == "-C" ]]; then
            # Delegate directory completion to `zsh`.
            _directories

            # Return without invoking `git` completion.
            return
        fi

        # Delegate completion to existing `git` completion function.
        _git
    }

    # Associate each `git` alias with its corresponding completion.
    compdef _git_function_completion \
        gl=git-log \
        gll=git-log \
        gd=git-diff \
        gt=git-rev-list \
        gc=git-commit \
        gpp=git-pull \
        gs=git-status \
        gk=git-checkout \
        gb=git-branch \
        gw=git-worktree
fi

#endregion


# Command aliases.
alias ls="ls -la -G -h"
