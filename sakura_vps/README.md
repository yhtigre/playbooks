# README - playbooks

## 概要
さくらVPS上へWEB+DBサーバを構築するサンプル。

## 使い方
0) 各種変数群のカスタマイズ

```
.
└── playbooks
    ├── init
    │   ├── ansible.cfg
    │   ├── group_vars
    │   │   └── init
    │   │       ├── vars.yml     <== カスタマイズ
    │   │       └── vault.yml    <== カスタマイズ
    │   ├── hosts
    │   ├── init.yml
    │   └── roles
    │       └── init
    :
    │
    │
    └── tbo_server
        ├── .ansible_vault_pass
        ├── ansible.cfg
        ├── group_vars
        │   └── tbo_server
        │       ├── vars.yml     <== カスタマイズ
        │       └── vault.yml    <== カスタマイズ
        ├── hosts
        ├── roles
        │   ├── apps
        │   ├── certs
        │   ├── httpd
        │   ├── mysql
        │   ├── network
        │   ├── php
        │   └── system
        :
        └── tbo_server.yml
```


1) initプレイブックを実行する

```
$ cd init
$ ansible-playbook init.yml --vault-password-file=.ansible_vault_pass
```

2) tbo_serverプレイブックを実行する

```
$ cd tbo_server
$ ansible-playbook tbo_server.yml --vault-password-file=.ansible_vault_pass
```
