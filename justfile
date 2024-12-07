[private]
default:
    just --list

ours := "sample-typst-acmsmall"

# watch typst file
typst:
    typst watch {{ ours }}.typ

# diff the pdfs
diff:
    watchexec --watch {{ ours }}.pdf "diff-pdf --output-diff=diff.pdf sample-acmsmall.pdf {{ ours }}.pdf || true"

# run `typst` and `watch` recipes in parallel
watch:
    just parallog typst diff


# utility for running multiple recipes in parallel
[positional-arguments]
[private]
parallog +args:
    #!/usr/bin/env bash
    trap "kill 0" EXIT SIGINT SIGTERM
    align=$((1 + `printf "%s\n" "$@" | wc -L`))
    while (("$#")); do
        color=$((31 + ("$#" % 6)))
        prefix=`printf "\033[${color};m%+${align}s\033[0m" "$1"`
        FORCE_COLOR=1 just $1 2>&1 | sed "s/^/${prefix} │ /;" &
        shift
    done
    wait -n

