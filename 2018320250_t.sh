# compile tree.c
gcc --coverage -o tree -g tree.c

# trigger some options
./tree -adlfiqNpugsDFtxASnC -H . -L 50 -R -P tree -I *.c -o logs/log . ..

# triggers usage(2)
./tree --help

# trigger findino() by creating a loop using symbolic links
mkdir -p dirA
mkdir -p dirB
ln -sf ../dirA dirB/link_dirA
ln -sf ../dirB dirA/link_dirB
./tree -alf -o logs/log_findino .

gcov -fbc tree.c > gcov_auto_t.log
