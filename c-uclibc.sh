#! /bin/bash --
# by pts@fazekas.hu at Tue Oct  8 22:50:01 CEST 2013

# Fix ELF binaries to contain GNU/Linux as the operating system. This is
# needed when running the program on FreeBSD in Linux mode.
do_elfosfix() {
  perl -e'
use integer;
use strict;

#** ELF operating system codes from FreeBSDs /usr/share/misc/magic
my %ELF_os_codes=qw{SYSV 0 GNU/Linux 3};
my $from_oscode=$ELF_os_codes{"SYSV"};
my $to_oscode=$ELF_os_codes{"GNU/Linux"};

for my $fn (@ARGV) {
  my $f;
  if (!open $f, "+<", $fn) {
    print STDERR "$0: $fn: $!\n";
    exit 2  # next
  }
  my $head;
  # vvv Imp: continue on next file instead of die()ing
  die if 8!=sysread($f,$head,8);
  if (substr($head,0,4)ne"\177ELF") {
    print STDERR "$0: $fn: not an ELF file\n";
    close($f); next;
  }
  if (vec($head,7,8)==$to_oscode) {
    print STDERR "$0: info: $fn: already fixed\n";
  }
  if ($from_oscode!=$to_oscode && vec($head,7,8)==$from_oscode) {
    vec($head,7,8)=$to_oscode;
    die if 0!=sysseek($f,0,0);
    die if length($head)!=syswrite($f,$head);
  }
  die "file error\n" if !close($f);
}' -- "$@"
}

set -ex

PREFIX=/home/pts/prg/pts-mini-gpl/uevalrun/cross-compiler
rm -f *.o

${PREFIX}/bin/i686-gcc -static -s -W -Wall -Wno-unused-parameter -O3 -c -I. \
    -ffunction-sections -fdata-sections \
    cdjpeg.c jaricom.c jcapimin.c jcarith.c jchuff.c jcmarker.c \
    jcmaster.c jcomapi.c jcparam.c jcphuff.c jctrans.c jdapimin.c \
    jdarith.c jdatadst.c jdatasrc.c jdcoefct.c jdhuff.c jdinput.c \
    jdmarker.c jdphuff.c jdtrans.c jerror.c jmemmgr.c jmemnobs.c \
    jpegtran.c jutils.c rdswitch.c transupp.c

${PREFIX}/bin/i686-gcc -static -Wl,--gc-sections \
    -s -o jpegtran.static *.o
do_elfosfix jpegtran.static

ls -l jpegtran.static

: c-uclibc.sh OK.
