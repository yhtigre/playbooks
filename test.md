# README - playbooks

## 概要
開発環境用オールインワンサーバを構築するPlayBook。


## 使い方
0) 各種変数群のカスタマイズ

```
devel-single/
│
└── init
    ├── ansible.cfg
    ├── group_vars
    │   └── init
    │       ├── vars.yml
    │       └── vault.yml            vault_password02 へrootのパスワードを記述する
    ├── hosts                        サーバのIPアドレスを記述する
    ├── init.yml
    └── roles
        └── init
            ├── files
            ├── tasks
            ├── templates
            └── vars
```

1) initプレイブックを実行する

```
$ cd init
$ ansible-playbook init.yml
```


```
devel-single/
│
├── README.md
├── dev_server
    ├── ansible.cfg
    ├── dev_server.yml
    ├── group_vars
    │   └── dev_server
    │       ├── vars.yml
    │       └── vault.yml
    ├── hosts
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

1) initプレイブックを実行する

```
$ cd init
$ ansible-playbook init.yml
```

2) dev_serverプレイブックを実行する

```
$ cd dev_server
$ ansible-playbook dev_server.yml
```
