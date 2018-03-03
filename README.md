# simple-test-framework

This is a simple test framework based on bash. 

The structure of the directries are:

```
.
├── cases                   # the directory is where all test cases are placed
│   └── demo-test.case      # a file denotes a test case suite, the file name should end with the '.case' suffix
├── lib                     # the directory is where all common tools are placed
│   ├── assert.sh           # the file name of tools should end with the '.sh' suffix
│   ├── cases.sh
│   ├── common.sh
│   └── log.sh
├── logs                    # the directory is where all test logs places
├── README.md
└── run.sh                  # the script to start test
```
