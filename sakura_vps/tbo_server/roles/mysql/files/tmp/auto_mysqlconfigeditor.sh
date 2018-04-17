#!/usr/bin/expect
##
## Copyright (c) 2017 TATEIWA-SHACHU, LLC. All rights reserved.
##
##  mysql_config_editor コマンドの実行を自動化する
##

#
# コマンドライン引数を配列化
#
set args [split $argv " "]
if {$argc != 4} {
  exit 1
}

#
# 配列要素を変数に設定
#
set login-path [lindex $args 0]
set user [lindex $args 1]
set passwd [lindex $args 2]
set host [lindex $args 3]
#
# パスワードにセミコロンが含まれていると変数代入時に
# ブレース文字{} が含まれるためこれを除去
#
regsub -all -- {^{|}$} $passwd {} passwd
set sharp-included [regexp {#} $passwd]

set timeout 5
log_user 1

spawn /usr/bin/mysql_config_editor set -G ${login-path} -u ${user} -h ${host} -p

expect {
  "Enter password: " {
    if {${sharp-included}} {
      # 両端にダブルクォートを入れているのは[MySQL Bugs: #74691]への対応である。
      send "\"${passwd}\"\n"
    } else {
      send "${passwd}\n"
    }
    exp_continue
  } " Continue? (Press y|Y for Yes, any other key for No) : " {
    send "y\n"
    exp_continue
  }
}

exit 0
