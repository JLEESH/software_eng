# set-up log dir (can be ignored)
mkdir -p logs

# test simple cases first
./tree
./tree > /dev/null

# test --help and --version
./tree --help
./tree --version

# test as many options as possible
./tree -adlfiqNpugsDFtxASnC -H . -L 50 -R -P tree -I *.c -o logs/log . ..

# don't test seemingly conflicting options/options that supersede each other
./tree -adlfiqpugsDFtxAn -L 10 -H . -R -P tree -I *.c -o logs/log ..
./tree -adlfiNpugsDFtxSC -L 10 -H . -R -o /dev/null ..

# tests that create(d) visually pleasing logs (and test the -I option properly)
./tree -alqFAn . -R -I *.c -o logs/logA ..
./tree -alqFSC . -I *.c -o logs/logB ..

# trigger findino() by creating a loop using symbolic links
mkdir -p dirA
mkdir -p dirB
ln -sf ../dirA dirB/link_dirA
ln -sf ../dirB dirA/link_dirB
./tree -adlfiqpugsDFtxAn -L 10 -H . -R -P tree -I *.c -o logs/log_findino .

# trigger -L argument missing or 0
./tree -L 0
./tree -L

# trigger invalid argument
./tree -B

# trigger [error opening dir]
./tree ./dummy

# trigger [error opening dir], but with -H enabled
./tree ./dummy -H .

# TODO: trigger invalid filename
# TODO: trigger error while opening file

## Note: virtual memory exhaustion not tested (resource-intensive?)
## some other features to do with COL_XXXX were also mostly left untouched
## Non-exhaustive list of untested branches at a glance may be included in report


#------ JUST TEST MORE BRANCHES -----
# test more colours by using a directory with more file types
# /dev is a common directory that satisfies the requirement
./tree /dev -o /dev/null
# Note: /dev/null vs -o /dev/null

# take more branches (take a bunch of branches not taken because of OR)
# not all cases have undergone ablation testing but most or all of them should increase coverage
./tree -p -o /dev/null
./tree -s -o /dev/null
./tree -u -o /dev/null
./tree -g -o /dev/null
./tree -D -o /dev/null

./tree -pu
./tree -pg
./tree -ps
./tree -pD

./tree -ug
./tree -us
./tree -uD
./tree- sD

./tree -fH
./tree -lf




#./tree -adlfiqpugsDFtxAn -L 10 -H . -R -P tree -I *.c -o log ..