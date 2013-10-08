#! /bin/bash --
# by pts@fazekas.hu at Tue Oct  8 22:43:46 CEST 2013
set -ex

rm -f *.o

gcc -s -W -Wall -Wno-unused-parameter -O3 -c -I. \
    -ffunction-sections -fdata-sections \
    cdjpeg.c jaricom.c jcapimin.c jcarith.c jchuff.c jcmarker.c \
    jcmaster.c jcomapi.c jcparam.c jcphuff.c jctrans.c jdapimin.c \
    jdarith.c jdatadst.c jdatasrc.c jdcoefct.c jdhuff.c jdinput.c \
    jdmarker.c jdphuff.c jdtrans.c jerror.c jmemmgr.c jmemnobs.c \
    jpegtran.c jutils.c rdswitch.c transupp.c

g++ -Wl,--gc-sections \
    -s -o jpegtran *.o

# Not too much unused functionality:
# -rwxr-xr-x 1 pts pts 157052 Oct  8 22:45 jpegtran
# -rwxr-xr-x 1 pts pts 161272 Oct  8 22:46 jpegtran.nogc
ls -l jpegtran

: c.sh OK.
