#! /bin/bash --
# by pts@fazekas.hu at Tue Oct  8 22:54:18 CEST 2013

set -ex

rm -f *.o

i586-mingw32msvc-gcc -s -W -Wall -Wno-unused-parameter -O3 -c -I. \
    -ffunction-sections -fdata-sections \
    cdjpeg.c jaricom.c jcapimin.c jcarith.c jchuff.c jcmarker.c \
    jcmaster.c jcomapi.c jcparam.c jcphuff.c jctrans.c jdapimin.c \
    jdarith.c jdatadst.c jdatasrc.c jdcoefct.c jdhuff.c jdinput.c \
    jdmarker.c jdphuff.c jdtrans.c jerror.c jmemmgr.c jmemnobs.c \
    jpegtran.c jutils.c rdswitch.c transupp.c

# Please note that -ffunction-sections, -fdata-sections and
# -Wl,--gc-sections doesn't seem to have any effect, even unused code gets
# compiled and linked.
i586-mingw32msvc-gcc -Wl,--gc-sections \
    -s -o jpegtran.exe *.o

ls -l jpegtran.exe

: c-mingw.sh OK.
