# 基于shell的简单的测试框架

这个测试框架是基于shell的，它的用例与公共库都用shell写

该工程的结构如下：

```
.
├── cases                   # 用例所在目录
│   └── demo-test.case      # 用例文件，文件名必须以'.case'后缀结尾，否则不当用例文件对待
│                           # 用例文件中的方法，如果名字以'test_'前缀开头，则被认为是测试用例
│                           # 将被执行；如果不以该前缀开头，则被认为是普通方法
│
├── common                  # 公共文件目录
│   └── lib                 # 文件必需以'.sh'后缀结尾，如果不是，则不予识别
│       ├── assert.sh       # 循环查找文件，脚本可以在子目录中。
│       ├── color.sh        # 配置文件，可以放在`common/conf/env.sh`中
│       ├── common.sh
│       ├── logging.sh
│       └── test.sh
├── logs                    # 日志文件目录
├── README.md
└── run.sh                  # 测试启动脚本
```

用例需要的其它工具需要提前安装，比如`curl`, `jq`等

使用说明

```
$ ./run.sh -h
./run.sh  -a                       : 跑所有用例
./run.sh  -r <report file>         : 跑指定报告文件中失败的用例
./run.sh  -h                       : 打印帮助信息
```
