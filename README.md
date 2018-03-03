# simple-test-framework

[中文README](README-zh.md)

This is a simple test framework based on bash. 

The structure of the directries are:

```
.
├── cases                   # the directory is where all test cases are placed
│   └── demo-test.case      # a file denotes a test case suite, the file name should end 
│                           # with the '.case' suffix. The cases file allow user to define 
│                           # non-case functions. the cases function name should start 
│                           # with the 'test_' prefix, e.g. test_demo_api. and other 
│                           # functions are all treated as non-case functions
│
├── common                  # the directory is where all common tools are placed
│   └── lib                 # the file name of tools should end with the '.sh' suffix
│       ├── assert.sh       # other files are ignored. it detects the scripts recursively
│       ├── test.sh
│       ├── color.sh
│       ├── common.sh
│       └── logging.sh
├── logs                    # the directory is where all test logs places
├── README.md
└── run.sh                  # the script to start test
```

some other tools required by the cases should pre-exist before run the cases, like `curl`, `jq`, etc.

USAGES

```
$ ./run.sh -h
./run.sh  -a                       : run all test cases
./run.sh  -r <report file>         : run all failed test cases in the report file
./run.sh  -h                       : show this help and exit
```
