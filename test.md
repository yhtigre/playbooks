# README - playbooks

## 概要
開発環境用オールインワンサーバを構築するPlayBook。


## 使い方
0) init用各種変数群のカスタマイズ

```
devel-single/
│
└── init
    ├── ansible.cfg
    ├── group_vars
    │   └── init
    │       ├── vars.yml
    │       └── vault.yml            0.1) vault_password02 へrootのパスワードを記述する
    ├── hosts                        0.2) サーバのIPアドレスを記述する
    ├── init.yml
    └── roles
        └── init                     0.3) 基本的に変更する必要はないが、vladminの公開鍵を配置するので鍵を変更する場合は
            ├── files                     filesディレクトリ以下のファイルを更新する必要あり
            ├── tasks
            └── vars
```

1) initプレイブックを実行する

```
$ cd init
$ ansible-playbook init.yml
```

2) dev_server用各種変数群のカスタマイズ
```
devel-single/
│
├── dev_server
    ├── ansible.cfg
    ├── dev_server.yml
    ├── group_vars
    │   └── dev_server
    │       ├── vars.yml              2.1) ansible_ssh_private_key_file へvladminの秘密鍵ファイルを記述する
    │       │                         2.2) certs_server_name へサーバ証明書用コモンネームを記述する
    │       │                         2.3) service_name へ適当なサービス名を記述する(DB名やドキュメントルートのパスの一部になります)
    │       └── vault.yml             2.4) vault_password01 へvladminのパスワードを記述する
    ├── hosts                         2.5) サーバのIPアドレスを記述する
    └── roles
        ├── apps
        │   ├── files
        │   ├── tasks
        │   └── vars
        ├── certs
        │   ├── handlers
        │   ├── tasks
        │   └── vars
        ├── httpd
        │   ├── tasks
        │   ├── templates
        │   └── vars
        ├── mysql
        │   ├── files
        │   ├── tasks
        │   └── vars
        ├── network
        │   ├── handlers
        │   ├── tasks
        │   └── vars
        ├── php
        │   ├── files
        │   ├── tasks
        │   └── vars
        └── system
            ├── files
            ├── handlers
            ├── tasks
            └── vars
```

3) dev_serverプレイブックを実行する

```
$ cd dev_server
$ ansible-playbook dev_server.yml
```
