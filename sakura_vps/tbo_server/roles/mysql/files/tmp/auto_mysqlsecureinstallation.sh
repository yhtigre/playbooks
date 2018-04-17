#!/usr/bin/expect
##
## Copyright (c) 2017 TATEIWA-SHACHU, LLC. All rights reserved.
##
##  mysql_secure_installation コマンドの実行を自動化する
##

#
# コマンドライン引数を配列化
#
set args [split $argv " "]
if {$argc != 1} {
  exit 1
}

#
# 配列要素を変数に設定
#
set passwd [lindex $args 0]
#
# パスワードにセミコロンが含まれていると変数代入時に
# ブレース文字{} が含まれるためこれを除去
#
regsub -all -- {^{|}$} $passwd {} passwd

set timeout 5
log_user 1

spawn /usr/bin/mysql_secure_installation

expect {
  "Enter password for user root: " {
    send "${passwd}\n"
    exp_continue
  } "New password: " {
    send "${passwd}\n"
    exp_continue
  } "Re-enter new password: " {
    send "${passwd}\n"
    exp_continue
  } "Change the password for root ? ((Press y|Y for Yes, any other key for No) : " {
    send "n\n"
    exp_continue
  } "Remove anonymous users? (Press y|Y for Yes, any other key for No) : " {
    send "y\n"
    exp_continue
  } "Disallow root login remotely? (Press y|Y for Yes, any other key for No) : " {
    send "y\n"
    exp_continue
  } "Remove test database and access to it? (Press y|Y for Yes, any other key for No) : " {
    send "y\n"
    exp_continue
  } "Reload privilege tables now? (Press y|Y for Yes, any other key for No) : " {
    send "y\n"
    exp_continue
  }
}

exit 0
