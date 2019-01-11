# fail2stop

When you periodically execute tasks, there are often situations such that: it should be stopped after many failures, but it sometimes fails even if there are no problems.
This is the script to use in such a situation.

タスクを定期実行させているとき「何度も何度も連続して失敗するなら実行を止めてほしいが、たまに失敗することはあるのでそれは無視してほしい」という場面がありますが、そのような時に使うためのスクリプトです。

## Usage

``` sh
./fail2stop [-v] [-n LIMIT] [-d DECREASE] FILE COMMAND...
```

## Example

``` sh
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock echo success
success
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
FAIL
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
$ ./fail2stop file.lock sh -c 'echo FAIL ; false'
```
