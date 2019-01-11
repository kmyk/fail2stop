#!/bin/bash
set -e
cd "$(dirname "$0")"
script="../fail2stop"

echo '[*] $ shellcheck' "$script" >&2
shellcheck $script

fail2stop() {
    echo '[*] $' "$script" "$@" >&2
    "$script" "$@"
}

atexit() {
    [[ -n ${tmpfile1} ]] && rm -f "$tmpfile1"
    [[ -n ${tmpfile2} ]] && rm -f "$tmpfile2"
}
trap atexit EXIT
trap 'rc=$? ; trap - EXIT ; atexit ; exit $rc' INT PIPE TERM
tmpfile1=$(mktemp)
tmpfile2=$(mktemp)


echo '[!] test 1' >&2
: > "$tmpfile2"
fail2stop "$tmpfile1" echo foo >> "$tmpfile2"
fail2stop "$tmpfile1" echo bar >> "$tmpfile2"
fail2stop "$tmpfile1" pwd >> "$tmpfile2"
[[ "$(cat "$tmpfile2")" = $'foo\nbar\n'"$PWD" ]]
echo '[+] OK' >&2


echo '[!] test 2' >&2
rm "$tmpfile1"
: > "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 0 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 1 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 2 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 3 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 4 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 5 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 6 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 7 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 8 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 9 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 10 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 11 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 12 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 13 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 14 ; true' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 15 ; false' >> "$tmpfile2"
[[ "$(cat "$tmpfile2")" = '0123456789' ]]
echo '[+] OK' >&2


echo '[!] test 3' >&2
rm "$tmpfile1"
: > "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 0 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 1 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 2 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 3 ; false' >> "$tmpfile2"
fail2stop "$tmpfile1" sh -c 'echo -n 4 ; true' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 5 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 6 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 7 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 8 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 9 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 10 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 11 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 12 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 13 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 14 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 15 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 16 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 17 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 18 ; false' >> "$tmpfile2"
! fail2stop "$tmpfile1" sh -c 'echo -n 19 ; false' >> "$tmpfile2"
[[ "$(cat "$tmpfile2")" = '01234567891011121314' ]]
echo '[+] OK' >&2


echo '[!] test 4' >&2
rm "$tmpfile1"
: > "$tmpfile2"
! fail2stop -n 1 "$tmpfile1" false
! fail2stop -n 1 "$tmpfile1" true
! fail2stop -n 1 "$tmpfile1" true
echo '[+] OK' >&2


echo '[!] test 5' >&2
rm "$tmpfile1"
: > "$tmpfile2"
fail2stop -n 3 -d 1 "$tmpfile1" true
! fail2stop -n 3 -d 1 "$tmpfile1" false
! fail2stop -n 3 -d 1 "$tmpfile1" false
fail2stop -n 3 -d 1 "$tmpfile1" true
! fail2stop -n 3 -d 1 "$tmpfile1" false
fail2stop -n 3 -d 1 "$tmpfile1" true
! fail2stop -n 3 -d 1 "$tmpfile1" false
! fail2stop -n 3 -d 1 "$tmpfile1" false
! fail2stop -n 3 -d 1 "$tmpfile1" true
! fail2stop -n 3 -d 1 "$tmpfile1" true
echo '[+] OK' >&2
