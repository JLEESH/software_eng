# compile tree.c
gcc --coverage -o tree -g tree.c

# set-up a directory for logs (can be ignored)
mkdir -p logs

# test some simple cases
# Note: the second command does in fact increase coverage
./tree
./tree > /dev/null

# test --help and --version
./tree --help
./tree --version

# test as many options as possible
./tree -adlfiqNpugsDFtxASnC -H . -L 50 -R -P tree -I *.c -o logs/log . ..

# don't test seemingly conflicting options/options that supersede each other
./tree -alfiqpugsDFtxAn -L 10 -H . -R -P tree -I *.c -o logs/log ..
./tree -adlfiNpugsDFtxSC -L 10 -H . -R -o /dev/null ..

# tests that create(d) visually pleasing logs (and test the -I option properly)
# increases coverage but are of little real interest
./tree -alqFAn . -R -I *.c -o logs/logA ..
./tree -alqFSC . -I *.c -o logs/logB ..

# trigger findino() by creating a loop using symbolic links
mkdir -p dirA
mkdir -p dirB
ln -sf ../dirA dirB/link_dirA
ln -sf ../dirB dirA/link_dirB
./tree -adl -o logs/log_findino .

# trigger -L argument missing or 0
./tree -L 0
./tree -L

# trigger invalid argument
./tree -B

# trigger [error opening dir]
./tree ./dummy

# trigger [error opening dir], but with -H enabled
./tree ./dummy -H .



## Note: features cumbersome to emulate (e.g. virtual memory exhaustion) not tested
## some other features to do with COL_XXXX were also mostly left untouched
## to keep the time spent on the assignment reasonable (i.e. prioritise test cases)
## Non-exhaustive list of some untested statements and branches may be included in report

# examples (leftover TODO's):
# TODO: overflow MAXDIRLEVEL (create a lot of directories -> not good for SSDs' lifespan)
# TODO: trigger virtual memory exhaustion (resource intensive)
# TODO: trigger invalid filename
# TODO: trigger error while opening file
# TODO: test more of the patmatch code
# TODO: a variety of other options and conditions (e.g. branches that deal with S_IFSOCK, S_IFIFO etc.)

#------ JUST TEST MORE BRANCHES -----
# test more colours by using a directory with more file types
# /dev is a sufficiently common directory that satisfies the requirement
./tree /dev #-o /dev/null

# take more branches (take a bunch of branches not taken because of OR)
# not all cases have undergone ablation testing but most or all of them should increase coverage
./tree -p
./tree -s
./tree -u
./tree -g
./tree -D

./tree -pu
./tree -pg
./tree -ps
./tree -pD

./tree -ug
./tree -us
./tree -uD
./tree -sD

./tree -fH
./tree -lf


# run gcov and log the output
gcov -bc tree.c > gcov_auto.log
gcov -fbc tree.c > gcov_auto_func.log


# ---------IGNORE BELOW--------
#./tree -adlfiqpugsDFtxAn -L 10 -H . -R -P tree -I *.c -o log ..
