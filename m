Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLACK,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A90C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7447820896
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfACGGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 01:06:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:54355 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbfACGGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 01:06:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 22:06:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,433,1539673200"; 
   d="xz'?scan'208";a="113797342"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jan 2019 22:05:59 -0800
Date:   Thu, 3 Jan 2019 14:06:09 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Alexis Bauvin <abauvin@scaleway.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Amine Kherbouche <akherbouche@scaleway.com>,
        David Ahern <dsahern@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: [LKP] [test/net] 03f1c26b1c:
 kernel_selftests.net.test_vxlan_under_vrf.sh.fail
Message-ID: <20190103060609.GJ17624@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FYI, we noticed the following commit (built with gcc-7):

commit: 03f1c26b1c56936fa29675b5556c3bb08185585a ("test/net: Add script for=
 VXLAN underlay in a VRF")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel_selftests
with following parameters:

	group: kselftests-02

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m =
4G

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-03f1c26b1c56936fa29675b5556c3bb08185585a
2018-12-29 12:28:29 ln -sf /usr/bin/clang-7 /usr/bin/clang
2018-12-29 12:28:29 ln -sf /usr/bin/llc-7 /usr/bin/llc
media_tests test: not in Makefile
2018-12-29 12:28:30 make TARGETS=3Dmedia_tests
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/media_tests'
gcc -I../ -I../../../../usr/include/    media_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools=
/testing/selftests/media_tests/media_device_test
gcc -I../ -I../../../../usr/include/    media_device_open.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools=
/testing/selftests/media_tests/media_device_open
gcc -I../ -I../../../../usr/include/    video_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools=
/testing/selftests/media_tests/video_device_test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/media_tests'
ignored_by_lkp media_tests test

2018-12-29 12:28:35 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/membarrier'
gcc -g -I../../../../usr/include/    membarrier_test.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/test=
ing/selftests/membarrier/membarrier_test
TAP version 13
selftests: membarrier: membarrier_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1 sys_membarrier available
ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, errn=
o =3D 22. Failed as expected
ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1, e=
rrno =3D 22. Failed as expected
ok 4 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure=
 test: flags =3D 0, errno =3D 1
ok 6 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags =
=3D 0
ok 7 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not register=
ed failure test: flags =3D 0, errno =3D 1
ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE tes=
t: flags =3D 0
ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: flags=
 =3D 0
ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags =
=3D 0
ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
Pass 13 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..13
ok 1..1 selftests: membarrier: membarrier_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/membarrier'

2018-12-29 12:28:37 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/   -c -o common.o common.c
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c common.o  -o /usr/src/perf_=
selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/te=
sting/selftests/memfd/memfd_test
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:60:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/byteswap.h:33:17: error: expected =E2=80=
=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint16_t=E2=80=99
 static __inline __uint16_t
                 ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:60:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/byteswap.h:48:17: error: expected =E2=80=
=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint32_t=E2=80=99
 static __inline __uint32_t
                 ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:60:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/byteswap.h:69:31: error: expected =E2=80=
=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint64_t=E2=80=99
 __extension__ static __inline __uint64_t
                               ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:61:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/uintn-identity.h:32:17: error: expected =
=E2=80=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint16_t=E2=80=
=99
 static __inline __uint16_t
                 ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:61:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/uintn-identity.h:38:17: error: expected =
=E2=80=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint32_t=E2=80=
=99
 static __inline __uint32_t
                 ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:61:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/uintn-identity.h:44:17: error: expected =
=E2=80=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint64_t=E2=80=
=99
 static __inline __uint64_t
                 ^~~~~~~~~~
memfd_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
memfd_test.c:74:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
memfd_test.c: In function =E2=80=98mfd_assert_open=E2=80=99:
memfd_test.c:197:6: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D open(buf, flags, mode);
      ^~~~
memfd_test.c: In function =E2=80=98mfd_assert_write=E2=80=99:
memfd_test.c:328:6: warning: implicit declaration of function =E2=80=98fall=
ocate=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fallocate(fd,
      ^~~~~~~~~
=2E./lib.mk:152: recipe for target '/usr/src/perf_selftests-x86_64-rhel-7.2=
-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/memfd/mem=
fd_test' failed
make: *** [/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5=
556c3bb08185585a/tools/testing/selftests/memfd/memfd_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/memfd'

2018-12-29 12:28:38 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/memory-hotplug'
TAP version 13
selftests: memory-hotplug: mem-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test scope: 2% hotplug memory
	 online all hot-pluggable memory in offline state:
		 SKIPPED - no hot-pluggable memory in offline state
	 offline 2% hot-pluggable memory in online state
	 trying to offline 1 out of 14 memory block(s):
online->offline memory1
	 online all hot-pluggable memory in offline state:
offline->online memory1
	 Test with memory notifier error injection
ok 1..1 selftests: memory-hotplug: mem-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/memory-hotplug'

2018-12-29 12:28:46 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/mount'
gcc -Wall -O2    unprivileged-remount-test.c  -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selfte=
sts/mount/unprivileged-remount-test
TAP version 13
selftests: mount: run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: mount: run_tests.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/mount'

2018-12-29 12:28:49 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/mqueue'
gcc -O2    mq_open_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/sel=
ftests/mqueue/mq_open_tests
gcc -O2    mq_perf_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/sel=
ftests/mqueue/mq_perf_tests
TAP version 13
selftests: mqueue: mq_open_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using Default queue path - /test1

Initial system state:
	Using queue path:		/test1
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10


Test series 1, behavior when no attr struct passed to mq_open:
Kernel supports setting defaults separately from maximums:		PASS
Given sane values, mq_open without an attr struct succeeds:		PASS
Kernel properly honors default setting knobs:				PASS
Kernel properly limits default values to lesser of default/max:		PASS
Kernel properly fails to create queue when defaults would
exceed rlimit:								PASS


Test series 2, behavior when attr struct is passed to mq_open:
Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
Queue open with total size > 2GB when euid =3D 0 failed:			PASS
Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1..1 selftests: mqueue: mq_open_tests [PASS]
selftests: mqueue: mq_perf_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Initial system state:
	Using queue path:			/mq_perf_tests
	RLIMIT_MSGQUEUE(soft):			819200
	RLIMIT_MSGQUEUE(hard):			819200
	Maximum Message Size:			8192
	Maximum Queue Size:			10
	Nice value:				0

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):			(unlimited)
	RLIMIT_MSGQUEUE(hard):			(unlimited)
	Maximum Message Size:			16777216
	Maximum Queue Size:			65530
	Nice value:				-20
	Continuous mode:			(disabled)
	CPUs to pin:				1

	Queue /mq_perf_tests created:
		mq_flags:			O_NONBLOCK
		mq_maxmsg:			65530
		mq_msgsize:			16
		mq_curmsgs:			0

	Started mqueue performance test thread on CPU 1
		Max priorities:			32768
		Clock resolution:		1 nsec

	Test #1: Time send/recv message, queue empty
		(10000000 iterations)
		Send msg:			185.543584412s total time
						18554 nsec/msg
		Recv msg:			190.280785990s total time
						19028 nsec/msg

	Test #2a: Time send/recv message, queue full, constant prio
:
		(100000 iterations)
		Filling queue...done.		0.743713369s
		Testing...done.
		Send msg:			1.999576338s total time
						19995 nsec/msg
		Recv msg:			2.41299536s total time
						20412 nsec/msg
		Draining queue...done.		0.709024481s

	Test #2b: Time send/recv message, queue full, increasing prio
:
		(100000 iterations)
		Filling queue...done.		0.777433880s
		Testing...done.
		Send msg:			1.949251504s total time
						19492 nsec/msg
		Recv msg:			1.895848828s total time
						18958 nsec/msg
		Draining queue...done.		0.726594250s

	Test #2c: Time send/recv message, queue full, decreasing prio
:
		(100000 iterations)
		Filling queue...done.		0.796432810s
		Testing...done.
		Send msg:			2.378070476s total time
						23780 nsec/msg
		Recv msg:			2.236318299s total time
						22363 nsec/msg
		Draining queue...done.		0.771355795s

	Test #2d: Time send/recv message, queue full, random prio
:
		(100000 iterations)
		Filling queue...done.		0.940833673s
		Testing...done.
		Send msg:			2.313036486s total time
						23130 nsec/msg
		Recv msg:			2.140241006s total time
						21402 nsec/msg
		Draining queue...done.		0.833819518s
ok 1..2 selftests: mqueue: mq_perf_tests [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/mqueue'

2018-12-29 12:37:34 make run_tests -C net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/net'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a'
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (501 files)
  INSTALL usr/include/linux/android/ (1 file)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (15 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (13 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (2 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (25 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5=
556c3bb08185585a/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa296=
75b5556c3bb08185585a/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lnuma  reu=
seport_bpf_numa.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c569=
36fa29675b5556c3bb08185585a/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa2=
9675b5556c3bb08185585a/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr=
_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29=
675b5556c3bb08185585a/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb081=
85585a/tools/testing/selftests/net/tls
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    socket.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb=
08185585a/tools/testing/selftests/net/socket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_fan=
out.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b55=
56c3bb08185585a/tools/testing/selftests/net/psock_fanout
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_tpa=
cket.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5=
556c3bb08185585a/tools/testing/selftests/net/psock_tpacket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    msg_zeroc=
opy.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b55=
56c3bb08185585a/tools/testing/selftests/net/msg_zerocopy
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_mmap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa296=
75b5556c3bb08185585a/tools/testing/selftests/net/tcp_mmap
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_inq.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa2967=
5b5556c3bb08185585a/tools/testing/selftests/net/tcp_inq
tcp_inq.c: In function =E2=80=98main=E2=80=99:
tcp_inq.c:178:4: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules [-Wstrict-aliasing]
    inq =3D *((int *) CMSG_DATA(cm));
    ^~~
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_snd=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b555=
6c3bb08185585a/tools/testing/selftests/net/psock_snd
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    txring_ov=
erwrite.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa2967=
5b5556c3bb08185585a/tools/testing/selftests/net/txring_overwrite
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb=
08185585a/tools/testing/selftests/net/udpgso
udpgso.c: In function =E2=80=98send_one=E2=80=99:
udpgso.c:484:3: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules [-Wstrict-aliasing]
   *((uint16_t *) CMSG_DATA(cm)) =3D gso_len;
   ^
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_tx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675=
b5556c3bb08185585a/tools/testing/selftests/net/udpgso_bench_tx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_rx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675=
b5556c3bb08185585a/tools/testing/selftests/net/udpgso_bench_rx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ip_defrag=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b555=
6c3bb08185585a/tools/testing/selftests/net/ip_defrag
TAP version 13
selftests: net: reuseport_bpf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP w/ mapped IPv4 ----
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
---- IPv4 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP w/ mapped IPv4 ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing filter add without bind...
SUCCESS
ok 1..1 selftests: net: reuseport_bpf [PASS]
selftests: net: reuseport_bpf_cpu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv4 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
SUCCESS
ok 1..2 selftests: net: reuseport_bpf_cpu [PASS]
selftests: net: reuseport_bpf_numa
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv4 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
SUCCESS
ok 1..3 selftests: net: reuseport_bpf_numa [PASS]
selftests: net: reuseport_dualstack
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- UDP IPv4 created before IPv6 ----
---- UDP IPv6 created before IPv4 ----
---- UDP IPv4 created before IPv6 (large) ----
---- UDP IPv6 created before IPv4 (large) ----
---- TCP IPv4 created before IPv6 ----
---- TCP IPv6 created before IPv4 ----
SUCCESS
ok 1..4 selftests: net: reuseport_dualstack [PASS]
selftests: net: reuseaddr_conflict
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening 127.0.0.1:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening in6addr_any:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening INADDR_ANY:9999 after closing ipv6 socket
bind: Address already in use
Successok 1..5 selftests: net: reuseaddr_conflict [PASS]
selftests: net: tls
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 29 tests from 2 test cases.
[ RUN      ] tls.sendfile
[       OK ] tls.sendfile
[ RUN      ] tls.send_then_sendfile
[       OK ] tls.send_then_sendfile
[ RUN      ] tls.recv_max
[       OK ] tls.recv_max
[ RUN      ] tls.recv_small
[       OK ] tls.recv_small
[ RUN      ] tls.msg_more
[       OK ] tls.msg_more
[ RUN      ] tls.sendmsg_single
[       OK ] tls.sendmsg_single
[ RUN      ] tls.sendmsg_large
[       OK ] tls.sendmsg_large
[ RUN      ] tls.sendmsg_multiple
[       OK ] tls.sendmsg_multiple
[ RUN      ] tls.sendmsg_multiple_stress
[       OK ] tls.sendmsg_multiple_stress
[ RUN      ] tls.splice_from_pipe
[       OK ] tls.splice_from_pipe
[ RUN      ] tls.splice_from_pipe2
[       OK ] tls.splice_from_pipe2
[ RUN      ] tls.send_and_splice
[       OK ] tls.send_and_splice
[ RUN      ] tls.splice_to_pipe
[       OK ] tls.splice_to_pipe
[ RUN      ] tls.recvmsg_single
[       OK ] tls.recvmsg_single
[ RUN      ] tls.recvmsg_single_max
[       OK ] tls.recvmsg_single_max
[ RUN      ] tls.recvmsg_multiple
[       OK ] tls.recvmsg_multiple
[ RUN      ] tls.single_send_multiple_recv
[       OK ] tls.single_send_multiple_recv
[ RUN      ] tls.multiple_send_single_recv
[       OK ] tls.multiple_send_single_recv
[ RUN      ] tls.recv_partial
[       OK ] tls.recv_partial
[ RUN      ] tls.recv_nonblock
[       OK ] tls.recv_nonblock
[ RUN      ] tls.recv_peek
[       OK ] tls.recv_peek
[ RUN      ] tls.recv_peek_multiple
[       OK ] tls.recv_peek_multiple
[ RUN      ] tls.recv_peek_multiple_records
[       OK ] tls.recv_peek_multiple_records
[ RUN      ] tls.recv_peek_large_buf_mult_recs
[       OK ] tls.recv_peek_large_buf_mult_recs
[ RUN      ] tls.pollin
[       OK ] tls.pollin
[ RUN      ] tls.poll_wait
[       OK ] tls.poll_wait
[ RUN      ] tls.blocking
[       OK ] tls.blocking
[ RUN      ] tls.nonblocking
[       OK ] tls.nonblocking
[ RUN      ] tls.control_msg
[       OK ] tls.control_msg
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 29 / 29 tests passed.
[  PASSED  ]
ok 1..6 selftests: net: tls [PASS]
selftests: net: run_netsocktests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running socket test
--------------------
[PASS]
ok 1..7 selftests: net: run_netsocktests [PASS]
selftests: net: run_afpackettests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running psock_fanout test
--------------------
test: control single socket
test: control multiple sockets
test: unique ids

test: datapath 0x0 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D5,20, expect=3D20,5

test: datapath 0x1000 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D15,20, expect=3D20,15

test: datapath 0x1 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D10,10, expect=3D10,10
info: count=3D17,18, expect=3D18,17

test: datapath 0x3 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D15,5, expect=3D15,5
info: count=3D20,15, expect=3D20,15

test: datapath 0x6 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x7 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x2 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D20,0, expect=3D20,0
info: count=3D20,0, expect=3D20,0

test: datapath 0x2 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D0,20
info: count=3D0,20, expect=3D0,20

test: datapath 0x2000 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D20,20, expect=3D20,20
info: count=3D20,20, expect=3D20,20
OK. All tests passed
[PASS]
--------------------
running psock_tpacket test
--------------------
test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
OK. All tests passed
[PASS]
--------------------
running txring_overwrite test
--------------------
read: a (0x61)
read: b (0x62)
[PASS]
ok 1..8 selftests: net: run_afpackettests [PASS]
selftests: net: test_bpf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
test_bpf: ok
ok 1..9 selftests: net: test_bpf.sh [PASS]
selftests: net: netdevice.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: eth0: interface already up
Cannot get device udp-fragmentation-offload settings: Operation not support=
ed
PASS: eth0: ethtool list features
PASS: eth0: ethtool dump
PASS: eth0: ethtool stats
SKIP: eth0: interface kept up
ok 1..10 selftests: net: netdevice.sh [PASS]
selftests: net: rtnetlink.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: policy routing
PASS: route get
PASS: tc htb hierarchy
PASS: gre tunnel endpoint
PASS: gretap
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
FAIL: ip6gretap
PASS: erspan
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
FAIL: ip6erspan
PASS: bridge setup
PASS: ipv6 addrlabel
PASS: set ifalias 3fd8730a-897f-49dd-929e-5eff5c648f9c for test-dummy0
PASS: vrf
PASS: vxlan
PASS: fou
PASS: macsec
PASS: ipsec
FAIL: ipsec_offload netdevsim doesn't support IPsec offload
ok 1..11 selftests: net: rtnetlink.sh [PASS]
selftests: net: fib_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Single path route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Nexthop device deleted
    TEST: IPv4 fibmatch - no route                                      [ O=
K ]
    TEST: IPv6 fibmatch - no route                                      [ O=
K ]

Multipath route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One nexthop device deleted
    TEST: IPv4 - multipath route removed on delete                      [ O=
K ]
    TEST: IPv6 - multipath down to single path                          [ O=
K ]
    Second nexthop device deleted
    TEST: IPv6 - no route                                               [ O=
K ]

Single path, admin down
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Route deleted on down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Admin down multipath
    Verify start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One device down, one up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Other device down and up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Both devices down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Local carrier tests - single path
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - no linkdown flag                                       [ O=
K ]
    TEST: IPv6 - no linkdown flag                                       [ O=
K ]
    Carrier off on nexthop
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - linkdown flag set                                      [ O=
K ]
    TEST: IPv6 - linkdown flag set                                      [ O=
K ]
    Route to local address with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

Single path route carrier test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 no linkdown flag                                         [ O=
K ]
    TEST: IPv6 no linkdown flag                                         [ O=
K ]
    Carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]
    Second address added with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

IPv4 nexthop tests
<<< write me >>>

IPv6 nexthop tests
    TEST: Directly connected nexthop, unicast address                   [ O=
K ]
    TEST: Directly connected nexthop, unicast address with device       [ O=
K ]
    TEST: Gateway is linklocal address                                  [ O=
K ]
    TEST: Gateway is linklocal address, no device                       [ O=
K ]
    TEST: Gateway can not be local unicast address                      [ O=
K ]
    TEST: Gateway can not be local unicast address, with device         [ O=
K ]
    TEST: Gateway can not be a local linklocal address                  [ O=
K ]
    TEST: Gateway can be local address in a VRF                         [ O=
K ]
    TEST: Gateway can be local address in a VRF, with device            [ O=
K ]
    TEST: Gateway can be local linklocal address in a VRF               [ O=
K ]
    TEST: Redirect to VRF lookup                                        [ O=
K ]
    TEST: VRF route, gateway can be local address in default VRF        [ O=
K ]
    TEST: VRF route, gateway can not be a local address                 [ O=
K ]
    TEST: VRF route, gateway can not be a local addr with device        [ O=
K ]

IPv6 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv6 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv4 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Add new nexthop for existing prefix                           [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Append nexthop to existing route - dev only                   [ O=
K ]
    TEST: Append nexthop to existing route - reject route               [ O=
K ]
    TEST: Append nexthop to existing reject route - gw                  [ O=
K ]
    TEST: Append nexthop to existing reject route - dev only            [ O=
K ]
    TEST: add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv4 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with reject route                                 [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath with reject route                                   [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv6 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv4 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv6 routes with metrics
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on first  [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on 2nd    [ O=
K ]
    TEST:     MTU of second leg                                         [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

IPv4 route add / append tests
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

Tests passed: 141
Tests failed:   0
ok 1..12 selftests: net: fib_tests.sh [PASS]
selftests: net: fib-onlink-tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

########################################
Configuring interfaces
RTNETLINK answers: File exists
not ok 1..13 selftests: net: fib-onlink-tests.sh [FAIL]
selftests: net: pmtu.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
TEST: ipv4: PMTU exceptions                                         [ OK ]
connect: Cannot assign requested address
connect: Cannot assign requested address
TEST: ipv6: PMTU exceptions                                         [FAIL]
  PMTU exception wasn't created after exceeding MTU
TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
TEST: IPv6 over vxlan6: PMTU exceptions                             [ OK ]
RTNETLINK answers: Operation not supported
  geneve4 not supported
TEST: IPv4 over geneve4: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve4 not supported
TEST: IPv6 over geneve4: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve6 not supported
TEST: IPv4 over geneve6: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve6 not supported
TEST: IPv6 over geneve6: PMTU exceptions                            [SKIP]
TEST: IPv4 over fou4: PMTU exceptions                               [ OK ]
TEST: IPv6 over fou4: PMTU exceptions                               [ OK ]
TEST: IPv4 over fou6: PMTU exceptions                               [ OK ]
TEST: IPv6 over fou6: PMTU exceptions                               [ OK ]
TEST: IPv4 over gue4: PMTU exceptions                               [ OK ]
TEST: IPv6 over gue4: PMTU exceptions                               [ OK ]
TEST: IPv4 over gue6: PMTU exceptions                               [ OK ]
TEST: IPv6 over gue6: PMTU exceptions                               [ OK ]
TEST: vti6: PMTU exceptions                                         [ OK ]
TEST: vti4: PMTU exceptions                                         [ OK ]
TEST: vti4: default MTU assignment                                  [ OK ]
TEST: vti6: default MTU assignment                                  [ OK ]
TEST: vti4: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU changes on link changes                             [ OK ]
not ok 1..14 selftests: net: pmtu.sh [FAIL]
selftests: net: udpgso.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv6 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv4 connected
device mtu (orig): 65536
device mtu (test): 1600
route mtu (test): 1500
path mtu (read):  1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ok 1..15 selftests: net: udpgso.sh [PASS]
selftests: net: ip_defrag.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 defrag
PASS
seed =3D 1546087427
ipv4 defrag with overlaps
PASS
seed =3D 1546087440
ipv6 defrag
PASS
seed =3D 1546087465
ipv6 defrag with overlaps
PASS
seed =3D 1546087465
ok 1..16 selftests: net: ip_defrag.sh [PASS]
selftests: net: udpgso_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4
tcp
tcp tx:    325 MB/s     5524 calls/s   5524 msg/s
tcp rx:    329 MB/s     4919 calls/s
tcp tx:    299 MB/s     5078 calls/s   5078 msg/s
tcp rx:    300 MB/s     4461 calls/s
tcp tx:    341 MB/s     5798 calls/s   5798 msg/s
tcp rx:    341 MB/s     5396 calls/s
tcp zerocopy
tcp tx:    285 MB/s     4835 calls/s   4835 msg/s
tcp rx:    285 MB/s     3858 calls/s
tcp rx:    257 MB/s     3587 calls/s
tcp tx:    259 MB/s     4408 calls/s   4408 msg/s
tcp rx:    289 MB/s     3606 calls/s
tcp tx:    287 MB/s     4878 calls/s   4878 msg/s
udp
udp rx:     26 MB/s    18822 calls/s
udp tx:     27 MB/s    19614 calls/s    467 msg/s
udp rx:     24 MB/s    17097 calls/s
udp tx:     25 MB/s    18144 calls/s    432 msg/s
udp rx:     12 MB/s     9117 calls/s
udp tx:     13 MB/s     9660 calls/s    230 msg/s
udp rx:     30 MB/s    21628 calls/s
udp gso
udp rx:    108 MB/s    77187 calls/s
udp tx:    113 MB/s     1932 calls/s   1932 msg/s
udp rx:    103 MB/s    74060 calls/s
udp tx:    112 MB/s     1904 calls/s   1904 msg/s
udp rx:    100 MB/s    71827 calls/s
udp tx:    110 MB/s     1869 calls/s   1869 msg/s
udp rx:     89 MB/s    63905 calls/s
ipv6
tcp
tcp rx:    328 MB/s     5431 calls/s
tcp tx:    328 MB/s     5579 calls/s   5579 msg/s
tcp tx:    326 MB/s     5536 calls/s   5536 msg/s
tcp rx:    326 MB/s     5133 calls/s
tcp tx:    343 MB/s     5818 calls/s   5818 msg/s
tcp rx:    342 MB/s     5421 calls/s
tcp zerocopy
tcp tx:    265 MB/s     4504 calls/s   4504 msg/s
tcp rx:    265 MB/s     3939 calls/s
tcp rx:    259 MB/s     2263 calls/s
tcp tx:    261 MB/s     4431 calls/s   4431 msg/s
tcp tx:    257 MB/s     4364 calls/s   4364 msg/s
tcp rx:    258 MB/s     3563 calls/s
udp
udp rx:     27 MB/s    19906 calls/s
udp tx:     28 MB/s    20554 calls/s    478 msg/s
udp rx:     28 MB/s    20615 calls/s
udp tx:     29 MB/s    21414 calls/s    498 msg/s
udp rx:     22 MB/s    16752 calls/s
udp tx:     24 MB/s    17974 calls/s    418 msg/s
udp rx:     25 MB/s    18310 calls/s
udp gso
udp rx:     91 MB/s    67040 calls/s
udp tx:     97 MB/s     1648 calls/s   1648 msg/s
udp rx:     89 MB/s    65347 calls/s
udp tx:     95 MB/s     1619 calls/s   1619 msg/s
udp rx:     88 MB/s    64769 calls/s
udp tx:     96 MB/s     1635 calls/s   1635 msg/s
udp rx:     92 MB/s    67623 calls/s
ok 1..17 selftests: net: udpgso_bench.sh [PASS]
selftests: net: fib_rule_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

######################################################################
TEST SECTION: IPv4 fib rule
######################################################################

    TEST: rule4 check: oif dummy0                             [ OK ]

    TEST: rule4 del by pref: oif dummy0                       [ OK ]
RTNETLINK answers: No route to host

    TEST: rule4 check: from 192.51.100.3 iif dummy0           [FAIL]

    TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]

    TEST: rule4 check: tos 0x10                               [ OK ]

    TEST: rule4 del by pref: tos 0x10                         [ OK ]

    TEST: rule4 check: fwmark 0x64                            [ OK ]

    TEST: rule4 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule4 check: uidrange 100-100                       [ OK ]

    TEST: rule4 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule4 check: sport 666 dport 777                    [ OK ]

    TEST: rule4 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule4 check: ipproto tcp                            [ OK ]

    TEST: rule4 del by pref: ipproto tcp                      [ OK ]

    TEST: rule4 check: ipproto icmp                           [ OK ]

    TEST: rule4 del by pref: ipproto icmp                     [ OK ]

######################################################################
TEST SECTION: IPv6 fib rule
######################################################################

    TEST: rule6 check: oif dummy0                             [ OK ]

    TEST: rule6 del by pref: oif dummy0                       [ OK ]

    TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]

    TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]

    TEST: rule6 check: tos 0x10                               [ OK ]

    TEST: rule6 del by pref: tos 0x10                         [ OK ]

    TEST: rule6 check: fwmark 0x64                            [ OK ]

    TEST: rule6 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule6 check: uidrange 100-100                       [ OK ]

    TEST: rule6 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule6 check: sport 666 dport 777                    [ OK ]

    TEST: rule6 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule6 check: ipproto tcp                            [ OK ]

    TEST: rule6 del by pref: ipproto tcp                      [ OK ]

    TEST: rule6 check: ipproto icmp                           [ OK ]

    TEST: rule6 del by pref: ipproto icmp                     [ OK ]
ok 1..18 selftests: net: fib_rule_tests.sh [PASS]
selftests: net: msg_zerocopy.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 tcp -t 1
=2E/msg_zerocopy: setaffinity 2
=2E/msg_zerocopy: setaffinity 3
not ok 1..19 selftests: net: msg_zerocopy.sh [FAIL]
selftests: net: psock_snd.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
dgram
tx: 128
rx: 142
rx: 100
OK

dgram bind
tx: 128
rx: 142
rx: 100
OK

raw
tx: 142
rx: 142
rx: 100
OK

raw bind
tx: 142
rx: 142
rx: 100
OK

raw qdisc bypass
tx: 142
rx: 142
rx: 100
OK

raw vlan
tx: 146
rx: 100
OK

raw vnet hdr
tx: 152
rx: 142
rx: 100
OK

raw csum_off
tx: 152
rx: 142
rx: 100
OK

raw csum_off with bad offset (fails)
=2E/psock_snd: write: Invalid argument
raw min size
tx: 42
rx: 0
OK

raw mtu size
tx: 1514
rx: 1472
OK

raw mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw vlan mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
dgram mtu size
tx: 1500
rx: 1472
OK

dgram mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw truncate hlen (fails: does not arrive)
tx: 14
=2E/psock_snd: recv: Resource temporarily unavailable
raw truncate hlen - 1 (fails: EINVAL)
=2E/psock_snd: write: Invalid argument
raw gso min size
tx: 1525
rx: 1473
OK

raw gso min size - 1 (fails)
tx: 1524
=2E/psock_snd: recv: Resource temporarily unavailable
raw gso max size
tx: 65559
rx: 65507
OK

raw gso max size + 1 (fails)
tx: 65560
=2E/psock_snd: recv: Resource temporarily unavailable
OK. All tests passed
ok 1..20 selftests: net: psock_snd.sh [PASS]
selftests: net: udpgro_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Missing xdp_dummy helper. Build bpf selftest first
not ok 1..21 selftests: net: udpgro_bench.sh [FAIL]
selftests: net: udpgro.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Missing xdp_dummy helper. Build bpf selftest first
not ok 1..22 selftests: net: udpgro.sh [FAIL]
selftests: net: test_vxlan_under_vrf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking HV connectivity                                           [ OK ]
Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 1..23 selftests: net: test_vxlan_under_vrf.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/net'

2018-12-29 12:45:20 make run_tests -C netfilter
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/netfilter'
TAP version 13
selftests: netfilter: nft_trans_stress.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: Could not run test without nft tool
not ok 1..1 selftests: netfilter: nft_trans_stress.sh [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/netfilter'

2018-12-29 12:45:21 make run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/nsfs'
gcc -Wall -Werror    owner.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03=
f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/nsfs/owner
gcc -Wall -Werror    pidns.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03=
f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/nsfs/pidns
TAP version 13
selftests: nsfs: owner
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: nsfs: owner [PASS]
selftests: nsfs: pidns
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: nsfs: pidns [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/nsfs'
ignored_by_lkp powerpc test
prctl test: not in Makefile
2018-12-29 12:45:23 make TARGETS=3Dprctl
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/prctl'

2018-12-29 12:45:26 make run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: prctl: disable-tsc-ctxt-sw-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..1 selftests: prctl: disable-tsc-ctxt-sw-stress-test [PASS]
selftests: prctl: disable-tsc-on-off-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..2 selftests: prctl: disable-tsc-on-off-stress-test [PASS]
selftests: prctl: disable-tsc-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rdtsc() =3D=3D 3062340407061
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
rdtsc() =3D=3D 3062343205782
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 3062344365153
prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
rdtsc() =3D=3D [ SIG_SEGV ]
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 3062349891972
ok 1..3 selftests: prctl: disable-tsc-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/prctl'

2018-12-29 12:45:50 make run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/proc'
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-001-lookup.c  -o /us=
r/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb0818558=
5a/tools/testing/selftests/proc/fd-001-lookup
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-002-posix-eq.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185=
585a/tools/testing/selftests/proc/fd-002-posix-eq
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-003-kthread.c  -o /u=
sr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb081855=
85a/tools/testing/selftests/proc/fd-003-kthread
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-loadavg-001.c  -o =
/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb0818=
5585a/tools/testing/selftests/proc/proc-loadavg-001
proc-loadavg-001.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-001=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b555=
6c3bb08185585a/tools/testing/selftests/proc/proc-self-map-files-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-002=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b555=
6c3bb08185585a/tools/testing/selftests/proc/proc-self-map-files-002
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-syscall.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb081=
85585a/tools/testing/selftests/proc/proc-self-syscall
proc-self-syscall.c:16:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-wchan.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185=
585a/tools/testing/selftests/proc/proc-self-wchan
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-001.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185=
585a/tools/testing/selftests/proc/proc-uptime-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-002.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185=
585a/tools/testing/selftests/proc/proc-uptime-002
proc-uptime-002.c:18:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    read.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/=
testing/selftests/proc/read
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    self.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/=
testing/selftests/proc/self
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    thread-self.c  -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a=
/tools/testing/selftests/proc/thread-self
TAP version 13
selftests: proc: fd-001-lookup
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: proc: fd-001-lookup [PASS]
selftests: proc: fd-002-posix-eq
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: proc: fd-002-posix-eq [PASS]
selftests: proc: fd-003-kthread
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: proc: fd-003-kthread [PASS]
selftests: proc: proc-loadavg-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: proc: proc-loadavg-001 [PASS]
selftests: proc: proc-self-map-files-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: proc: proc-self-map-files-001 [PASS]
selftests: proc: proc-self-map-files-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..6 selftests: proc: proc-self-map-files-002 [PASS]
selftests: proc: proc-self-syscall
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..7 selftests: proc: proc-self-syscall [PASS]
selftests: proc: proc-self-wchan
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..8 selftests: proc: proc-self-wchan [PASS]
selftests: proc: proc-uptime-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..9 selftests: proc: proc-uptime-001 [PASS]
selftests: proc: proc-uptime-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..10 selftests: proc: proc-uptime-002 [PASS]
selftests: proc: read
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..11 selftests: proc: read [PASS]
selftests: proc: self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..12 selftests: proc: self [PASS]
selftests: proc: thread-self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..13 selftests: proc: thread-self [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/proc'

2018-12-29 12:46:15 make run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/pstore'
TAP version 13
selftests: pstore: pstore_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
UUID=3Dea7aae83-e9c2-4522-9bb7-d96656f6fae2
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-snb-4G-202::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/=
lkp/jobs/scheduled/vm-snb-4G-202/kernel_selftests-kselftests-02-debian-x86_=
64-2018-04-03.cgz-03f1c26b1c56936fa29675b5556c3bb08185585a-20181229-76446-1=
5mua6t-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/=
devel-hourly-2018122717 commit=3D03f1c26b1c56936fa29675b5556c3bb08185585a B=
OOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3b=
b08185585a/vmlinuz-4.20.0-rc4-00985-g03f1c26 erst_disable max_uptime=3D3600=
 RESULT_ROOT=3D/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_=
64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb0818=
5585a/3 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rcupdate.r=
cu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 s=
oftlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prom=
pt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel=
 console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnor=
mal rw rcuperf.shutdown=3D0
Checking pstore console is registered ... ok
Checking /dev/pmsg0 exists ... ok
Writing unique string to /dev/pmsg0 ... ok
ok 1..1 selftests: pstore: pstore_tests [PASS]
selftests: pstore: pstore_post_reboot_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
UUID=3D74ce1231-c7cf-4343-9211-701ef53c389c
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-snb-4G-202::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/=
lkp/jobs/scheduled/vm-snb-4G-202/kernel_selftests-kselftests-02-debian-x86_=
64-2018-04-03.cgz-03f1c26b1c56936fa29675b5556c3bb08185585a-20181229-76446-1=
5mua6t-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/=
devel-hourly-2018122717 commit=3D03f1c26b1c56936fa29675b5556c3bb08185585a B=
OOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3b=
b08185585a/vmlinuz-4.20.0-rc4-00985-g03f1c26 erst_disable max_uptime=3D3600=
 RESULT_ROOT=3D/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_=
64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb0818=
5585a/3 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rcupdate.r=
cu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 s=
oftlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prom=
pt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel=
 console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnor=
mal rw rcuperf.shutdown=3D0
pstore_crash_test has not been executed yet. we skip further tests.
not ok 1..2 selftests: pstore: pstore_post_reboot_tests [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/pstore'
ptp test: not in Makefile
2018-12-29 12:46:17 make TARGETS=3Dptp
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptp'

2018-12-29 12:46:19 make run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ptp: testptp
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: ptp: testptp [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptp'

2018-12-29 12:46:19 make run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptrace'
gcc -iquote../../../../include/uapi -Wall    peeksiginfo.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/=
testing/selftests/ptrace/peeksiginfo
TAP version 13
selftests: ptrace: peeksiginfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS
ok 1..1 selftests: ptrace: peeksiginfo [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptrace'

2018-12-29 12:46:21 make run_tests -C rseq
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq'
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -shar=
ed -fPIC rseq.c -lpthread -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/librseq.so
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ basic=
_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/basic_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ basic=
_percpu_ops_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-=
7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/b=
asic_percpu_ops_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ param=
_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/param_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -DBEN=
CHMARK param_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel=
-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/=
param_test_benchmark
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -DRSE=
Q_COMPARE_TWICE param_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selfte=
sts/rseq/param_test_compare_twice
TAP version 13
selftests: rseq: basic_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
testing current cpu
ok 1..1 selftests: rseq: basic_test [PASS]
selftests: rseq: basic_percpu_ops_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
spinlock
percpu_list
ok 1..2 selftests: rseq: basic_percpu_ops_test [PASS]
selftests: rseq: param_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: rseq: param_test [PASS]
selftests: rseq: param_test_benchmark
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: rseq: param_test_benchmark [PASS]
selftests: rseq: param_test_compare_twice
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: rseq: param_test_compare_twice [PASS]
selftests: rseq: run_param_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Default parameters
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Loop injection: 10000 loops
Injecting at <1>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <2>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <3>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <4>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <5>
Running test spinlock
Running compare-twice test spinlock



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in th=
is email



Thanks,
Rong Chen

--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.20.0-rc4-00985-g03f1c26"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.20.0-rc4 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_PROTO_DCCP=y
CONFIG_NF_NAT_PROTO_UDPLITE=y
CONFIG_NF_NAT_PROTO_SCTP=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=y
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
# CONFIG_IP6_NF_NAT is not set
CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
CONFIG_SKY2_DEBUG=y
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_AT91_USART is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MASS_STORAGE=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set
# CONFIG_MTK_MMC is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_EROFS_FS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
# CONFIG_DELL_SMBIOS is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_PVPANIC=y
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel_selftests'
	export testcase='kernel_selftests'
	export category='functional'
	export need_memory='4G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='/lkp/lkp/.src-20181227-121122/allot/cyclic:vm:linux-devel:devel-hourly/vm-snb-4G/kernel_selftests.yaml'
	export queue='validate'
	export testbox='vm-snb-4G-202'
	export tbox_group='vm-snb-4G'
	export submit_id='5c26f6e00b9a932a9e7f2afa'
	export job_file='/lkp/jobs/scheduled/vm-snb-4G-202/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-03f1c26b1c56936fa29675b5556c3bb08185585a-20181229-76446-15mua6t-3.yaml'
	export id='d26de69b17bc05f491463d86f55fa0adece23a45'
	export queuer_version='/lkp/lkp/.src-20181227-121122'
	export need_kernel_headers=true
	export need_kernel_selftests=true
	export need_kconfig='CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_FIRMWARE
CONFIG_TEST_USER_COPY
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_NOTIFIER_ERROR_INJECTION
CONFIG_FTRACE=y
CONFIG_TEST_BITMAP
CONFIG_TEST_PRINTF
CONFIG_TEST_STATIC_KEYS
CONFIG_BPF_SYSCALL=y
CONFIG_NET_CLS_BPF=m
CONFIG_BPF_EVENTS=y
CONFIG_TEST_BPF=m
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HIST_TRIGGERS=y
CONFIG_EMBEDDED=y
CONFIG_GPIO_MOCKUP=y
CONFIG_USERFAULTFD=y
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_RAM=m
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_EXPERT=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_EFIVAR_FS
CONFIG_TEST_KMOD=m
CONFIG_TEST_LKM=m
CONFIG_XFS_FS=m
CONFIG_TUN=m
CONFIG_BTRFS_FS=m
CONFIG_TEST_SYSCTL=m
CONFIG_BPF_STREAM_PARSER=y
CONFIG_CGROUP_BPF=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_VRF=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_MACSEC=y
CONFIG_X86_INTEL_MPX=y
CONFIG_RC_LOOPBACK
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_LWTUNNEL=y
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_KVM_GUEST=y'
	export commit='03f1c26b1c56936fa29675b5556c3bb08185585a'
	export ssh_base_port=23032
	export kconfig='x86_64-rhel-7.2'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2018-12-29 12:24:01 +0800'
	export _id='5c26f6e10b9a932a9e7f2afb'
	export _rt='/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb08185585a'
	export user='lkp'
	export head_commit='f1924fdbd9eff37f92f783e41ce83200e8674bdf'
	export base_commit='8fe28cb58bcb235034b64cbbb7550a8a43fd88be'
	export branch='linux-devel/devel-hourly-2018122717'
	export result_root='/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb08185585a/3'
	export scheduler_version='/lkp/lkp/.src-20181229-091801'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-4G-202/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-03f1c26b1c56936fa29675b5556c3bb08185585a-20181229-76446-15mua6t-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.2
branch=linux-devel/devel-hourly-2018122717
commit=03f1c26b1c56936fa29675b5556c3bb08185585a
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb08185585a/vmlinuz-4.20.0-rc4-00985-g03f1c26
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb08185585a/3
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb08185585a/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2018-12-12.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-f5d582777bcb_2018-12-12.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb08185585a/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb08185585a/linux-selftests.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export kernel='/pkg/linux/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb08185585a/vmlinuz-4.20.0-rc4-00985-g03f1c26'
	export dequeue_time='2018-12-29 12:24:19 +0800'
	export nr_vm=80
	export job_initrd='/lkp/jobs/scheduled/vm-snb-4G-202/kernel_selftests-kselftests-02-debian-x86_64-2018-04-03.cgz-03f1c26b1c56936fa29675b5556c3bb08185585a-20181229-76446-15mua6t-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='kselftests-02' $LKP_SRC/tests/wrapper kernel_selftests
}

extract_stats()
{
	$LKP_SRC/stats/wrapper kernel_selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel_selftests.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--LQAwcd5tHl0Qlnzi
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAABFla

--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel_selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-03f1c26b1c56936fa29675b5556c3bb08185585a
2018-12-29 12:28:29 ln -sf /usr/bin/clang-7 /usr/bin/clang
2018-12-29 12:28:29 ln -sf /usr/bin/llc-7 /usr/bin/llc
media_tests test: not in Makefile
2018-12-29 12:28:30 make TARGETS=3Dmedia_tests
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/media_tests'
gcc -I../ -I../../../../usr/include/    media_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools=
/testing/selftests/media_tests/media_device_test
gcc -I../ -I../../../../usr/include/    media_device_open.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools=
/testing/selftests/media_tests/media_device_open
gcc -I../ -I../../../../usr/include/    video_device_test.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools=
/testing/selftests/media_tests/video_device_test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/media_tests'
ignored_by_lkp media_tests test

2018-12-29 12:28:35 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/membarrier'
gcc -g -I../../../../usr/include/    membarrier_test.c  -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/test=
ing/selftests/membarrier/membarrier_test
TAP version 13
selftests: membarrier: membarrier_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1 sys_membarrier available
ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, errn=
o =3D 22. Failed as expected
ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1, e=
rrno =3D 22. Failed as expected
ok 4 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure=
 test: flags =3D 0, errno =3D 1
ok 6 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags =
=3D 0
ok 7 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not register=
ed failure test: flags =3D 0, errno =3D 1
ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE tes=
t: flags =3D 0
ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: flags=
 =3D 0
ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags =
=3D 0
ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
Pass 13 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..13
ok 1..1 selftests: membarrier: membarrier_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/membarrier'

2018-12-29 12:28:37 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/   -c -o common.o common.c
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c common.o  -o /usr/src/perf_=
selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/te=
sting/selftests/memfd/memfd_test
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:60:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/byteswap.h:33:17: error: expected =E2=80=
=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint16_t=E2=80=99
 static __inline __uint16_t
                 ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:60:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/byteswap.h:48:17: error: expected =E2=80=
=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint32_t=E2=80=99
 static __inline __uint32_t
                 ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:60:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/byteswap.h:69:31: error: expected =E2=80=
=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint64_t=E2=80=99
 __extension__ static __inline __uint64_t
                               ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:61:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/uintn-identity.h:32:17: error: expected =
=E2=80=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint16_t=E2=80=
=99
 static __inline __uint16_t
                 ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:61:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/uintn-identity.h:38:17: error: expected =
=E2=80=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint32_t=E2=80=
=99
 static __inline __uint32_t
                 ^~~~~~~~~~
In file included from ../../../../include/uapi/linux/stddef.h:2:0,
                 from ../../../../include/uapi/linux/posix_types.h:5,
                 from ../../../../include/uapi/linux/types.h:14,
                 from ../../../../include/uapi/asm-generic/fcntl.h:5,
                 from ../../../../usr/include/asm/fcntl.h:1,
                 from ../../../../include/uapi/linux/fcntl.h:5,
                 from memfd_test.c:9:
=2E./../../../include/linux/compiler_types.h:202:58: error: unknown type na=
me =E2=80=98__gnu_inline=E2=80=99
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
                                                          ^
=2E./../../../include/linux/compiler_types.h:203:2: warning: variable =E2=
=80=98__maybe_unused=E2=80=99 declared =E2=80=98inline=E2=80=99
  __maybe_unused notrace
  ^
=2E./../../../include/linux/compiler_types.h:203:2: error: =E2=80=98__no_in=
strument_function__=E2=80=99 attribute applies only to functions
In file included from /usr/include/endian.h:61:0,
                 from /usr/include/x86_64-linux-gnu/sys/types.h:193,
                 from /usr/include/stdlib.h:394,
                 from memfd_test.c:13:
/usr/include/x86_64-linux-gnu/bits/uintn-identity.h:44:17: error: expected =
=E2=80=98,=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98__uint64_t=E2=80=
=99
 static __inline __uint64_t
                 ^~~~~~~~~~
memfd_test.c: In function =E2=80=98mfd_assert_get_seals=E2=80=99:
memfd_test.c:74:6: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fcntl(fd, F_GET_SEALS);
      ^~~~~
memfd_test.c: In function =E2=80=98mfd_assert_open=E2=80=99:
memfd_test.c:197:6: warning: implicit declaration of function =E2=80=98open=
=E2=80=99 [-Wimplicit-function-declaration]
  r =3D open(buf, flags, mode);
      ^~~~
memfd_test.c: In function =E2=80=98mfd_assert_write=E2=80=99:
memfd_test.c:328:6: warning: implicit declaration of function =E2=80=98fall=
ocate=E2=80=99 [-Wimplicit-function-declaration]
  r =3D fallocate(fd,
      ^~~~~~~~~
=2E./lib.mk:152: recipe for target '/usr/src/perf_selftests-x86_64-rhel-7.2=
-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/memfd/mem=
fd_test' failed
make: *** [/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5=
556c3bb08185585a/tools/testing/selftests/memfd/memfd_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/memfd'

2018-12-29 12:28:38 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/memory-hotplug'
TAP version 13
selftests: memory-hotplug: mem-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test scope: 2% hotplug memory
	 online all hot-pluggable memory in offline state:
		 SKIPPED - no hot-pluggable memory in offline state
	 offline 2% hot-pluggable memory in online state
	 trying to offline 1 out of 14 memory block(s):
online->offline memory1
	 online all hot-pluggable memory in offline state:
offline->online memory1
	 Test with memory notifier error injection
ok 1..1 selftests: memory-hotplug: mem-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/memory-hotplug'

2018-12-29 12:28:46 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/mount'
gcc -Wall -O2    unprivileged-remount-test.c  -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selfte=
sts/mount/unprivileged-remount-test
TAP version 13
selftests: mount: run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: mount: run_tests.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/mount'

2018-12-29 12:28:49 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/mqueue'
gcc -O2    mq_open_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/sel=
ftests/mqueue/mq_open_tests
gcc -O2    mq_perf_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/sel=
ftests/mqueue/mq_perf_tests
TAP version 13
selftests: mqueue: mq_open_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using Default queue path - /test1

Initial system state:
	Using queue path:		/test1
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):		819200
	RLIMIT_MSGQUEUE(hard):		819200
	Maximum Message Size:		8192
	Maximum Queue Size:		10
	Default Message Size:		8192
	Default Queue Size:		10


Test series 1, behavior when no attr struct passed to mq_open:
Kernel supports setting defaults separately from maximums:		PASS
Given sane values, mq_open without an attr struct succeeds:		PASS
Kernel properly honors default setting knobs:				PASS
Kernel properly limits default values to lesser of default/max:		PASS
Kernel properly fails to create queue when defaults would
exceed rlimit:								PASS


Test series 2, behavior when attr struct is passed to mq_open:
Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
Queue open with total size > 2GB when euid =3D 0 failed:			PASS
Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1..1 selftests: mqueue: mq_open_tests [PASS]
selftests: mqueue: mq_perf_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Initial system state:
	Using queue path:			/mq_perf_tests
	RLIMIT_MSGQUEUE(soft):			819200
	RLIMIT_MSGQUEUE(hard):			819200
	Maximum Message Size:			8192
	Maximum Queue Size:			10
	Nice value:				0

Adjusted system state for testing:
	RLIMIT_MSGQUEUE(soft):			(unlimited)
	RLIMIT_MSGQUEUE(hard):			(unlimited)
	Maximum Message Size:			16777216
	Maximum Queue Size:			65530
	Nice value:				-20
	Continuous mode:			(disabled)
	CPUs to pin:				1

	Queue /mq_perf_tests created:
		mq_flags:			O_NONBLOCK
		mq_maxmsg:			65530
		mq_msgsize:			16
		mq_curmsgs:			0

	Started mqueue performance test thread on CPU 1
		Max priorities:			32768
		Clock resolution:		1 nsec

	Test #1: Time send/recv message, queue empty
		(10000000 iterations)
		Send msg:			185.543584412s total time
						18554 nsec/msg
		Recv msg:			190.280785990s total time
						19028 nsec/msg

	Test #2a: Time send/recv message, queue full, constant prio
:
		(100000 iterations)
		Filling queue...done.		0.743713369s
		Testing...done.
		Send msg:			1.999576338s total time
						19995 nsec/msg
		Recv msg:			2.41299536s total time
						20412 nsec/msg
		Draining queue...done.		0.709024481s

	Test #2b: Time send/recv message, queue full, increasing prio
:
		(100000 iterations)
		Filling queue...done.		0.777433880s
		Testing...done.
		Send msg:			1.949251504s total time
						19492 nsec/msg
		Recv msg:			1.895848828s total time
						18958 nsec/msg
		Draining queue...done.		0.726594250s

	Test #2c: Time send/recv message, queue full, decreasing prio
:
		(100000 iterations)
		Filling queue...done.		0.796432810s
		Testing...done.
		Send msg:			2.378070476s total time
						23780 nsec/msg
		Recv msg:			2.236318299s total time
						22363 nsec/msg
		Draining queue...done.		0.771355795s

	Test #2d: Time send/recv message, queue full, random prio
:
		(100000 iterations)
		Filling queue...done.		0.940833673s
		Testing...done.
		Send msg:			2.313036486s total time
						23130 nsec/msg
		Recv msg:			2.140241006s total time
						21402 nsec/msg
		Draining queue...done.		0.833819518s
ok 1..2 selftests: mqueue: mq_perf_tests [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/mqueue'

2018-12-29 12:37:34 make run_tests -C net
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/net'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a'
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (501 files)
  INSTALL usr/include/linux/android/ (1 file)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (15 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (13 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (2 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (25 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a'
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5=
556c3bb08185585a/tools/testing/selftests/net/reuseport_bpf
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_bpf_cpu.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa296=
75b5556c3bb08185585a/tools/testing/selftests/net/reuseport_bpf_cpu
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lnuma  reu=
seport_bpf_numa.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c569=
36fa29675b5556c3bb08185585a/tools/testing/selftests/net/reuseport_bpf_numa
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseport=
_dualstack.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa2=
9675b5556c3bb08185585a/tools/testing/selftests/net/reuseport_dualstack
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    reuseaddr=
_conflict.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29=
675b5556c3bb08185585a/tools/testing/selftests/net/reuseaddr_conflict
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    tls.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb081=
85585a/tools/testing/selftests/net/tls
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    socket.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb=
08185585a/tools/testing/selftests/net/socket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_fan=
out.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b55=
56c3bb08185585a/tools/testing/selftests/net/psock_fanout
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_tpa=
cket.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5=
556c3bb08185585a/tools/testing/selftests/net/psock_tpacket
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    msg_zeroc=
opy.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b55=
56c3bb08185585a/tools/testing/selftests/net/msg_zerocopy
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_mmap.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa296=
75b5556c3bb08185585a/tools/testing/selftests/net/tcp_mmap
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -lpthread  =
tcp_inq.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa2967=
5b5556c3bb08185585a/tools/testing/selftests/net/tcp_inq
tcp_inq.c: In function =E2=80=98main=E2=80=99:
tcp_inq.c:178:4: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules [-Wstrict-aliasing]
    inq =3D *((int *) CMSG_DATA(cm));
    ^~~
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    psock_snd=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b555=
6c3bb08185585a/tools/testing/selftests/net/psock_snd
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    txring_ov=
erwrite.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa2967=
5b5556c3bb08185585a/tools/testing/selftests/net/txring_overwrite
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso.c =
 -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb=
08185585a/tools/testing/selftests/net/udpgso
udpgso.c: In function =E2=80=98send_one=E2=80=99:
udpgso.c:484:3: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules [-Wstrict-aliasing]
   *((uint16_t *) CMSG_DATA(cm)) =3D gso_len;
   ^
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_tx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675=
b5556c3bb08185585a/tools/testing/selftests/net/udpgso_bench_tx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    udpgso_be=
nch_rx.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675=
b5556c3bb08185585a/tools/testing/selftests/net/udpgso_bench_rx
gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/    ip_defrag=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b555=
6c3bb08185585a/tools/testing/selftests/net/ip_defrag
TAP version 13
selftests: net: reuseport_bpf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 UDP w/ mapped IPv4 ----
Testing EBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 20...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 10: 10
Socket 11: 11
Socket 12: 12
Socket 13: 13
Socket 14: 14
Socket 15: 15
Socket 16: 16
Socket 17: 17
Socket 18: 18
Socket 19: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 10: 30
Socket 11: 31
Socket 12: 32
Socket 13: 33
Socket 14: 34
Socket 15: 35
Socket 16: 36
Socket 17: 37
Socket 18: 38
Socket 19: 39
Reprograming, testing mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Socket 0: 20
Socket 1: 21
Socket 2: 22
Socket 3: 23
Socket 4: 24
Socket 5: 25
Socket 6: 26
Socket 7: 27
Socket 8: 28
Socket 9: 29
Socket 0: 30
Socket 1: 31
Socket 2: 32
Socket 3: 33
Socket 4: 34
Socket 5: 35
Socket 6: 36
Socket 7: 37
Socket 8: 38
Socket 9: 39
---- IPv4 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing too many filters...
Testing filters on non-SO_REUSEPORT socket...
---- IPv6 TCP w/ mapped IPv4 ----
Testing EBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing CBPF mod 10...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 5: 5
Socket 6: 6
Socket 7: 7
Socket 8: 8
Socket 9: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 5: 15
Socket 6: 16
Socket 7: 17
Socket 8: 18
Socket 9: 19
Reprograming, testing mod 5...
Socket 0: 0
Socket 1: 1
Socket 2: 2
Socket 3: 3
Socket 4: 4
Socket 0: 5
Socket 1: 6
Socket 2: 7
Socket 3: 8
Socket 4: 9
Socket 0: 10
Socket 1: 11
Socket 2: 12
Socket 3: 13
Socket 4: 14
Socket 0: 15
Socket 1: 16
Socket 2: 17
Socket 3: 18
Socket 4: 19
Testing filter add without bind...
SUCCESS
ok 1..1 selftests: net: reuseport_bpf [PASS]
selftests: net: reuseport_bpf_cpu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 UDP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv4 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
---- IPv6 TCP ----
send cpu 0, receive socket 0
send cpu 1, receive socket 1
send cpu 1, receive socket 1
send cpu 0, receive socket 0
send cpu 0, receive socket 0
send cpu 1, receive socket 1
SUCCESS
ok 1..2 selftests: net: reuseport_bpf_cpu [PASS]
selftests: net: reuseport_bpf_numa
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- IPv4 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 UDP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv4 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
---- IPv6 TCP ----
send node 0, receive socket 0
send node 0, receive socket 0
SUCCESS
ok 1..3 selftests: net: reuseport_bpf_numa [PASS]
selftests: net: reuseport_dualstack
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- UDP IPv4 created before IPv6 ----
---- UDP IPv6 created before IPv4 ----
---- UDP IPv4 created before IPv6 (large) ----
---- UDP IPv6 created before IPv4 (large) ----
---- TCP IPv4 created before IPv6 ----
---- TCP IPv6 created before IPv4 ----
SUCCESS
ok 1..4 selftests: net: reuseport_dualstack [PASS]
selftests: net: reuseaddr_conflict
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening 127.0.0.1:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening in6addr_any:9999
Opening INADDR_ANY:9999
bind: Address already in use
Opening INADDR_ANY:9999 after closing ipv6 socket
bind: Address already in use
Successok 1..5 selftests: net: reuseaddr_conflict [PASS]
selftests: net: tls
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 29 tests from 2 test cases.
[ RUN      ] tls.sendfile
[       OK ] tls.sendfile
[ RUN      ] tls.send_then_sendfile
[       OK ] tls.send_then_sendfile
[ RUN      ] tls.recv_max
[       OK ] tls.recv_max
[ RUN      ] tls.recv_small
[       OK ] tls.recv_small
[ RUN      ] tls.msg_more
[       OK ] tls.msg_more
[ RUN      ] tls.sendmsg_single
[       OK ] tls.sendmsg_single
[ RUN      ] tls.sendmsg_large
[       OK ] tls.sendmsg_large
[ RUN      ] tls.sendmsg_multiple
[       OK ] tls.sendmsg_multiple
[ RUN      ] tls.sendmsg_multiple_stress
[       OK ] tls.sendmsg_multiple_stress
[ RUN      ] tls.splice_from_pipe
[       OK ] tls.splice_from_pipe
[ RUN      ] tls.splice_from_pipe2
[       OK ] tls.splice_from_pipe2
[ RUN      ] tls.send_and_splice
[       OK ] tls.send_and_splice
[ RUN      ] tls.splice_to_pipe
[       OK ] tls.splice_to_pipe
[ RUN      ] tls.recvmsg_single
[       OK ] tls.recvmsg_single
[ RUN      ] tls.recvmsg_single_max
[       OK ] tls.recvmsg_single_max
[ RUN      ] tls.recvmsg_multiple
[       OK ] tls.recvmsg_multiple
[ RUN      ] tls.single_send_multiple_recv
[       OK ] tls.single_send_multiple_recv
[ RUN      ] tls.multiple_send_single_recv
[       OK ] tls.multiple_send_single_recv
[ RUN      ] tls.recv_partial
[       OK ] tls.recv_partial
[ RUN      ] tls.recv_nonblock
[       OK ] tls.recv_nonblock
[ RUN      ] tls.recv_peek
[       OK ] tls.recv_peek
[ RUN      ] tls.recv_peek_multiple
[       OK ] tls.recv_peek_multiple
[ RUN      ] tls.recv_peek_multiple_records
[       OK ] tls.recv_peek_multiple_records
[ RUN      ] tls.recv_peek_large_buf_mult_recs
[       OK ] tls.recv_peek_large_buf_mult_recs
[ RUN      ] tls.pollin
[       OK ] tls.pollin
[ RUN      ] tls.poll_wait
[       OK ] tls.poll_wait
[ RUN      ] tls.blocking
[       OK ] tls.blocking
[ RUN      ] tls.nonblocking
[       OK ] tls.nonblocking
[ RUN      ] tls.control_msg
[       OK ] tls.control_msg
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 29 / 29 tests passed.
[  PASSED  ]
ok 1..6 selftests: net: tls [PASS]
selftests: net: run_netsocktests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running socket test
--------------------
[PASS]
ok 1..7 selftests: net: run_netsocktests [PASS]
selftests: net: run_afpackettests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------------
running psock_fanout test
--------------------
test: control single socket
test: control multiple sockets
test: unique ids

test: datapath 0x0 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D5,20, expect=3D20,5

test: datapath 0x1000 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D15,20, expect=3D20,15

test: datapath 0x1 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D10,10, expect=3D10,10
info: count=3D17,18, expect=3D18,17

test: datapath 0x3 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D15,5, expect=3D15,5
info: count=3D20,15, expect=3D20,15

test: datapath 0x6 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x7 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D5,15, expect=3D15,5
info: count=3D20,15, expect=3D15,20

test: datapath 0x2 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D20,0, expect=3D20,0
info: count=3D20,0, expect=3D20,0

test: datapath 0x2 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D0,20, expect=3D0,20
info: count=3D0,20, expect=3D0,20

test: datapath 0x2000 ports 8000,8002
info: count=3D0,0, expect=3D0,0
info: count=3D20,20, expect=3D20,20
info: count=3D20,20, expect=3D20,20
OK. All tests passed
[PASS]
--------------------
running psock_tpacket test
--------------------
test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 b=
ytes)
test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 b=
ytes)
OK. All tests passed
[PASS]
--------------------
running txring_overwrite test
--------------------
read: a (0x61)
read: b (0x62)
[PASS]
ok 1..8 selftests: net: run_afpackettests [PASS]
selftests: net: test_bpf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
test_bpf: ok
ok 1..9 selftests: net: test_bpf.sh [PASS]
selftests: net: netdevice.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: eth0: interface already up
Cannot get device udp-fragmentation-offload settings: Operation not support=
ed
PASS: eth0: ethtool list features
PASS: eth0: ethtool dump
PASS: eth0: ethtool stats
SKIP: eth0: interface kept up
ok 1..10 selftests: net: netdevice.sh [PASS]
selftests: net: rtnetlink.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: policy routing
PASS: route get
PASS: tc htb hierarchy
PASS: gre tunnel endpoint
PASS: gretap
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
Cannot find device "ip6gretap00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6gretap00"
FAIL: ip6gretap
PASS: erspan
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
Cannot find device "ip6erspan00"
RTNETLINK answers: Operation not supported
Cannot find device "ip6erspan00"
FAIL: ip6erspan
PASS: bridge setup
PASS: ipv6 addrlabel
PASS: set ifalias 3fd8730a-897f-49dd-929e-5eff5c648f9c for test-dummy0
PASS: vrf
PASS: vxlan
PASS: fou
PASS: macsec
PASS: ipsec
FAIL: ipsec_offload netdevsim doesn't support IPsec offload
ok 1..11 selftests: net: rtnetlink.sh [PASS]
selftests: net: fib_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Single path route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Nexthop device deleted
    TEST: IPv4 fibmatch - no route                                      [ O=
K ]
    TEST: IPv6 fibmatch - no route                                      [ O=
K ]

Multipath route test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One nexthop device deleted
    TEST: IPv4 - multipath route removed on delete                      [ O=
K ]
    TEST: IPv6 - multipath down to single path                          [ O=
K ]
    Second nexthop device deleted
    TEST: IPv6 - no route                                               [ O=
K ]

Single path, admin down
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    Route deleted on down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Admin down multipath
    Verify start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    One device down, one up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Other device down and up
    TEST: IPv4 fibmatch on down device                                  [ O=
K ]
    TEST: IPv6 fibmatch on down device                                  [ O=
K ]
    TEST: IPv4 fibmatch on up device                                    [ O=
K ]
    TEST: IPv6 fibmatch on up device                                    [ O=
K ]
    TEST: IPv4 flags on down device                                     [ O=
K ]
    TEST: IPv6 flags on down device                                     [ O=
K ]
    TEST: IPv4 flags on up device                                       [ O=
K ]
    TEST: IPv6 flags on up device                                       [ O=
K ]
    Both devices down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]

Local carrier tests - single path
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - no linkdown flag                                       [ O=
K ]
    TEST: IPv6 - no linkdown flag                                       [ O=
K ]
    Carrier off on nexthop
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 - linkdown flag set                                      [ O=
K ]
    TEST: IPv6 - linkdown flag set                                      [ O=
K ]
    Route to local address with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

Single path route carrier test
    Start point
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 no linkdown flag                                         [ O=
K ]
    TEST: IPv6 no linkdown flag                                         [ O=
K ]
    Carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]
    Second address added with carrier down
    TEST: IPv4 fibmatch                                                 [ O=
K ]
    TEST: IPv6 fibmatch                                                 [ O=
K ]
    TEST: IPv4 linkdown flag set                                        [ O=
K ]
    TEST: IPv6 linkdown flag set                                        [ O=
K ]

IPv4 nexthop tests
<<< write me >>>

IPv6 nexthop tests
    TEST: Directly connected nexthop, unicast address                   [ O=
K ]
    TEST: Directly connected nexthop, unicast address with device       [ O=
K ]
    TEST: Gateway is linklocal address                                  [ O=
K ]
    TEST: Gateway is linklocal address, no device                       [ O=
K ]
    TEST: Gateway can not be local unicast address                      [ O=
K ]
    TEST: Gateway can not be local unicast address, with device         [ O=
K ]
    TEST: Gateway can not be a local linklocal address                  [ O=
K ]
    TEST: Gateway can be local address in a VRF                         [ O=
K ]
    TEST: Gateway can be local address in a VRF, with device            [ O=
K ]
    TEST: Gateway can be local linklocal address in a VRF               [ O=
K ]
    TEST: Redirect to VRF lookup                                        [ O=
K ]
    TEST: VRF route, gateway can be local address in default VRF        [ O=
K ]
    TEST: VRF route, gateway can not be a local address                 [ O=
K ]
    TEST: VRF route, gateway can not be a local addr with device        [ O=
K ]

IPv6 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv6 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv4 route add / append tests
    TEST: Attempt to add duplicate route - gw                           [ O=
K ]
    TEST: Attempt to add duplicate route - dev only                     [ O=
K ]
    TEST: Attempt to add duplicate route - reject route                 [ O=
K ]
    TEST: Add new nexthop for existing prefix                           [ O=
K ]
    TEST: Append nexthop to existing route - gw                         [ O=
K ]
    TEST: Append nexthop to existing route - dev only                   [ O=
K ]
    TEST: Append nexthop to existing route - reject route               [ O=
K ]
    TEST: Append nexthop to existing reject route - gw                  [ O=
K ]
    TEST: Append nexthop to existing reject route - dev only            [ O=
K ]
    TEST: add multipath route                                           [ O=
K ]
    TEST: Attempt to add duplicate multipath route                      [ O=
K ]
    TEST: Route add with different metrics                              [ O=
K ]
    TEST: Route delete with metric                                      [ O=
K ]

IPv4 route replace tests
    TEST: Single path with single path                                  [ O=
K ]
    TEST: Single path with multipath                                    [ O=
K ]
    TEST: Single path with reject route                                 [ O=
K ]
    TEST: Single path with single path via multipath attribute          [ O=
K ]
    TEST: Invalid nexthop                                               [ O=
K ]
    TEST: Single path - replace of non-existent route                   [ O=
K ]
    TEST: Multipath with multipath                                      [ O=
K ]
    TEST: Multipath with single path                                    [ O=
K ]
    TEST: Multipath with single path via multipath attribute            [ O=
K ]
    TEST: Multipath with reject route                                   [ O=
K ]
    TEST: Multipath - invalid first nexthop                             [ O=
K ]
    TEST: Multipath - invalid second nexthop                            [ O=
K ]
    TEST: Multipath - replace of non-existent route                     [ O=
K ]

IPv6 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv4 prefix route tests
    TEST: Default metric                                                [ O=
K ]
    TEST: User specified metric on first device                         [ O=
K ]
    TEST: User specified metric on second device                        [ O=
K ]
    TEST: Delete of address on first device                             [ O=
K ]
    TEST: Modify metric of address                                      [ O=
K ]
Command line is not complete. Try option "help"
    TEST: Prefix route removed on link down                             [ O=
K ]
    TEST: Prefix route with metric on link up                           [ O=
K ]

IPv6 routes with metrics
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on first  [ O=
K ]
    TEST: Multipath route via 2 single routes with mtu metric on 2nd    [ O=
K ]
    TEST:     MTU of second leg                                         [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

IPv4 route add / append tests
    TEST: Single path route with mtu metric                             [ O=
K ]
    TEST: Multipath route with mtu metric                               [ O=
K ]
    TEST: Using route with mtu metric                                   [ O=
K ]
    TEST: Invalid metric (fails metric_convert)                         [ O=
K ]

Tests passed: 141
Tests failed:   0
ok 1..12 selftests: net: fib_tests.sh [PASS]
selftests: net: fib-onlink-tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

########################################
Configuring interfaces
RTNETLINK answers: File exists
not ok 1..13 selftests: net: fib-onlink-tests.sh [FAIL]
selftests: net: pmtu.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
TEST: ipv4: PMTU exceptions                                         [ OK ]
connect: Cannot assign requested address
connect: Cannot assign requested address
TEST: ipv6: PMTU exceptions                                         [FAIL]
  PMTU exception wasn't created after exceeding MTU
TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
TEST: IPv6 over vxlan6: PMTU exceptions                             [ OK ]
RTNETLINK answers: Operation not supported
  geneve4 not supported
TEST: IPv4 over geneve4: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve4 not supported
TEST: IPv6 over geneve4: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve6 not supported
TEST: IPv4 over geneve6: PMTU exceptions                            [SKIP]
RTNETLINK answers: Operation not supported
  geneve6 not supported
TEST: IPv6 over geneve6: PMTU exceptions                            [SKIP]
TEST: IPv4 over fou4: PMTU exceptions                               [ OK ]
TEST: IPv6 over fou4: PMTU exceptions                               [ OK ]
TEST: IPv4 over fou6: PMTU exceptions                               [ OK ]
TEST: IPv6 over fou6: PMTU exceptions                               [ OK ]
TEST: IPv4 over gue4: PMTU exceptions                               [ OK ]
TEST: IPv6 over gue4: PMTU exceptions                               [ OK ]
TEST: IPv4 over gue6: PMTU exceptions                               [ OK ]
TEST: IPv6 over gue6: PMTU exceptions                               [ OK ]
TEST: vti6: PMTU exceptions                                         [ OK ]
TEST: vti4: PMTU exceptions                                         [ OK ]
TEST: vti4: default MTU assignment                                  [ OK ]
TEST: vti6: default MTU assignment                                  [ OK ]
TEST: vti4: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU setting on link creation                            [ OK ]
TEST: vti6: MTU changes on link changes                             [ OK ]
not ok 1..14 selftests: net: pmtu.sh [FAIL]
selftests: net: udpgso.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 cmsg
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv6 setsockopt
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ipv4 connected
device mtu (orig): 65536
device mtu (test): 1600
route mtu (test): 1500
path mtu (read):  1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv4 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv4 tx:1 gso:0=20
ipv4 tx:1472 gso:0=20
ipv4 tx:1473 gso:0 (fail)
ipv4 tx:1472 gso:1472 (fail)
ipv4 tx:1473 gso:1472=20
ipv4 tx:2944 gso:1472=20
ipv4 tx:2945 gso:1472=20
ipv4 tx:64768 gso:1472=20
ipv4 tx:65507 gso:1472=20
ipv4 tx:65508 gso:1472 (fail)
ipv4 tx:1 gso:1 (fail)
ipv4 tx:2 gso:1=20
ipv4 tx:5 gso:2=20
ipv4 tx:36 gso:1=20
ipv4 tx:37 gso:1 (fail)
OK
ipv6 msg_more
device mtu (orig): 65536
device mtu (test): 1500
ipv6 tx:1 gso:0=20
ipv6 tx:1452 gso:0=20
ipv6 tx:1453 gso:0 (fail)
ipv6 tx:1452 gso:1452 (fail)
ipv6 tx:1453 gso:1452=20
ipv6 tx:2904 gso:1452=20
ipv6 tx:2905 gso:1452=20
ipv6 tx:65340 gso:1452=20
ipv6 tx:65527 gso:1452=20
ipv6 tx:65528 gso:1452 (fail)
ipv6 tx:1 gso:1 (fail)
ipv6 tx:2 gso:1=20
ipv6 tx:5 gso:2=20
ipv6 tx:16 gso:1=20
ipv6 tx:17 gso:1 (fail)
OK
ok 1..15 selftests: net: udpgso.sh [PASS]
selftests: net: ip_defrag.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 defrag
PASS
seed =3D 1546087427
ipv4 defrag with overlaps
PASS
seed =3D 1546087440
ipv6 defrag
PASS
seed =3D 1546087465
ipv6 defrag with overlaps
PASS
seed =3D 1546087465
ok 1..16 selftests: net: ip_defrag.sh [PASS]
selftests: net: udpgso_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4
tcp
tcp tx:    325 MB/s     5524 calls/s   5524 msg/s
tcp rx:    329 MB/s     4919 calls/s
tcp tx:    299 MB/s     5078 calls/s   5078 msg/s
tcp rx:    300 MB/s     4461 calls/s
tcp tx:    341 MB/s     5798 calls/s   5798 msg/s
tcp rx:    341 MB/s     5396 calls/s
tcp zerocopy
tcp tx:    285 MB/s     4835 calls/s   4835 msg/s
tcp rx:    285 MB/s     3858 calls/s
tcp rx:    257 MB/s     3587 calls/s
tcp tx:    259 MB/s     4408 calls/s   4408 msg/s
tcp rx:    289 MB/s     3606 calls/s
tcp tx:    287 MB/s     4878 calls/s   4878 msg/s
udp
udp rx:     26 MB/s    18822 calls/s
udp tx:     27 MB/s    19614 calls/s    467 msg/s
udp rx:     24 MB/s    17097 calls/s
udp tx:     25 MB/s    18144 calls/s    432 msg/s
udp rx:     12 MB/s     9117 calls/s
udp tx:     13 MB/s     9660 calls/s    230 msg/s
udp rx:     30 MB/s    21628 calls/s
udp gso
udp rx:    108 MB/s    77187 calls/s
udp tx:    113 MB/s     1932 calls/s   1932 msg/s
udp rx:    103 MB/s    74060 calls/s
udp tx:    112 MB/s     1904 calls/s   1904 msg/s
udp rx:    100 MB/s    71827 calls/s
udp tx:    110 MB/s     1869 calls/s   1869 msg/s
udp rx:     89 MB/s    63905 calls/s
ipv6
tcp
tcp rx:    328 MB/s     5431 calls/s
tcp tx:    328 MB/s     5579 calls/s   5579 msg/s
tcp tx:    326 MB/s     5536 calls/s   5536 msg/s
tcp rx:    326 MB/s     5133 calls/s
tcp tx:    343 MB/s     5818 calls/s   5818 msg/s
tcp rx:    342 MB/s     5421 calls/s
tcp zerocopy
tcp tx:    265 MB/s     4504 calls/s   4504 msg/s
tcp rx:    265 MB/s     3939 calls/s
tcp rx:    259 MB/s     2263 calls/s
tcp tx:    261 MB/s     4431 calls/s   4431 msg/s
tcp tx:    257 MB/s     4364 calls/s   4364 msg/s
tcp rx:    258 MB/s     3563 calls/s
udp
udp rx:     27 MB/s    19906 calls/s
udp tx:     28 MB/s    20554 calls/s    478 msg/s
udp rx:     28 MB/s    20615 calls/s
udp tx:     29 MB/s    21414 calls/s    498 msg/s
udp rx:     22 MB/s    16752 calls/s
udp tx:     24 MB/s    17974 calls/s    418 msg/s
udp rx:     25 MB/s    18310 calls/s
udp gso
udp rx:     91 MB/s    67040 calls/s
udp tx:     97 MB/s     1648 calls/s   1648 msg/s
udp rx:     89 MB/s    65347 calls/s
udp tx:     95 MB/s     1619 calls/s   1619 msg/s
udp rx:     88 MB/s    64769 calls/s
udp tx:     96 MB/s     1635 calls/s   1635 msg/s
udp rx:     92 MB/s    67623 calls/s
ok 1..17 selftests: net: udpgso_bench.sh [PASS]
selftests: net: fib_rule_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

######################################################################
TEST SECTION: IPv4 fib rule
######################################################################

    TEST: rule4 check: oif dummy0                             [ OK ]

    TEST: rule4 del by pref: oif dummy0                       [ OK ]
RTNETLINK answers: No route to host

    TEST: rule4 check: from 192.51.100.3 iif dummy0           [FAIL]

    TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]

    TEST: rule4 check: tos 0x10                               [ OK ]

    TEST: rule4 del by pref: tos 0x10                         [ OK ]

    TEST: rule4 check: fwmark 0x64                            [ OK ]

    TEST: rule4 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule4 check: uidrange 100-100                       [ OK ]

    TEST: rule4 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule4 check: sport 666 dport 777                    [ OK ]

    TEST: rule4 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule4 check: ipproto tcp                            [ OK ]

    TEST: rule4 del by pref: ipproto tcp                      [ OK ]

    TEST: rule4 check: ipproto icmp                           [ OK ]

    TEST: rule4 del by pref: ipproto icmp                     [ OK ]

######################################################################
TEST SECTION: IPv6 fib rule
######################################################################

    TEST: rule6 check: oif dummy0                             [ OK ]

    TEST: rule6 del by pref: oif dummy0                       [ OK ]

    TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]

    TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]

    TEST: rule6 check: tos 0x10                               [ OK ]

    TEST: rule6 del by pref: tos 0x10                         [ OK ]

    TEST: rule6 check: fwmark 0x64                            [ OK ]

    TEST: rule6 del by pref: fwmark 0x64                      [ OK ]

    TEST: rule6 check: uidrange 100-100                       [ OK ]

    TEST: rule6 del by pref: uidrange 100-100                 [ OK ]

    TEST: rule6 check: sport 666 dport 777                    [ OK ]

    TEST: rule6 del by pref: sport 666 dport 777              [ OK ]

    TEST: rule6 check: ipproto tcp                            [ OK ]

    TEST: rule6 del by pref: ipproto tcp                      [ OK ]

    TEST: rule6 check: ipproto icmp                           [ OK ]

    TEST: rule6 del by pref: ipproto icmp                     [ OK ]
ok 1..18 selftests: net: fib_rule_tests.sh [PASS]
selftests: net: msg_zerocopy.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ipv4 tcp -t 1
=2E/msg_zerocopy: setaffinity 2
=2E/msg_zerocopy: setaffinity 3
not ok 1..19 selftests: net: msg_zerocopy.sh [FAIL]
selftests: net: psock_snd.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
dgram
tx: 128
rx: 142
rx: 100
OK

dgram bind
tx: 128
rx: 142
rx: 100
OK

raw
tx: 142
rx: 142
rx: 100
OK

raw bind
tx: 142
rx: 142
rx: 100
OK

raw qdisc bypass
tx: 142
rx: 142
rx: 100
OK

raw vlan
tx: 146
rx: 100
OK

raw vnet hdr
tx: 152
rx: 142
rx: 100
OK

raw csum_off
tx: 152
rx: 142
rx: 100
OK

raw csum_off with bad offset (fails)
=2E/psock_snd: write: Invalid argument
raw min size
tx: 42
rx: 0
OK

raw mtu size
tx: 1514
rx: 1472
OK

raw mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw vlan mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
dgram mtu size
tx: 1500
rx: 1472
OK

dgram mtu size + 1 (fails)
=2E/psock_snd: write: Message too long
raw truncate hlen (fails: does not arrive)
tx: 14
=2E/psock_snd: recv: Resource temporarily unavailable
raw truncate hlen - 1 (fails: EINVAL)
=2E/psock_snd: write: Invalid argument
raw gso min size
tx: 1525
rx: 1473
OK

raw gso min size - 1 (fails)
tx: 1524
=2E/psock_snd: recv: Resource temporarily unavailable
raw gso max size
tx: 65559
rx: 65507
OK

raw gso max size + 1 (fails)
tx: 65560
=2E/psock_snd: recv: Resource temporarily unavailable
OK. All tests passed
ok 1..20 selftests: net: psock_snd.sh [PASS]
selftests: net: udpgro_bench.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Missing xdp_dummy helper. Build bpf selftest first
not ok 1..21 selftests: net: udpgro_bench.sh [FAIL]
selftests: net: udpgro.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Missing xdp_dummy helper. Build bpf selftest first
not ok 1..22 selftests: net: udpgro.sh [FAIL]
selftests: net: test_vxlan_under_vrf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking HV connectivity                                           [ OK ]
Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 1..23 selftests: net: test_vxlan_under_vrf.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/net'

2018-12-29 12:45:20 make run_tests -C netfilter
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/netfilter'
TAP version 13
selftests: netfilter: nft_trans_stress.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIP: Could not run test without nft tool
not ok 1..1 selftests: netfilter: nft_trans_stress.sh [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/netfilter'

2018-12-29 12:45:21 make run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/nsfs'
gcc -Wall -Werror    owner.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03=
f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/nsfs/owner
gcc -Wall -Werror    pidns.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03=
f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/nsfs/pidns
TAP version 13
selftests: nsfs: owner
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: nsfs: owner [PASS]
selftests: nsfs: pidns
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: nsfs: pidns [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/nsfs'
ignored_by_lkp powerpc test
prctl test: not in Makefile
2018-12-29 12:45:23 make TARGETS=3Dprctl
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/prctl'

2018-12-29 12:45:26 make run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: prctl: disable-tsc-ctxt-sw-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..1 selftests: prctl: disable-tsc-ctxt-sw-stress-test [PASS]
selftests: prctl: disable-tsc-on-off-stress-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[No further output means we're allright]
ok 1..2 selftests: prctl: disable-tsc-on-off-stress-test [PASS]
selftests: prctl: disable-tsc-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rdtsc() =3D=3D 3062340407061
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
rdtsc() =3D=3D 3062343205782
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 3062344365153
prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
rdtsc() =3D=3D [ SIG_SEGV ]
prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
prctl(PR_SET_TSC, PR_TSC_ENABLE)
rdtsc() =3D=3D 3062349891972
ok 1..3 selftests: prctl: disable-tsc-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/prctl'

2018-12-29 12:45:50 make run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/proc'
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-001-lookup.c  -o /us=
r/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb0818558=
5a/tools/testing/selftests/proc/fd-001-lookup
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-002-posix-eq.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185=
585a/tools/testing/selftests/proc/fd-002-posix-eq
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-003-kthread.c  -o /u=
sr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb081855=
85a/tools/testing/selftests/proc/fd-003-kthread
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-loadavg-001.c  -o =
/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb0818=
5585a/tools/testing/selftests/proc/proc-loadavg-001
proc-loadavg-001.c:17:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-001=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b555=
6c3bb08185585a/tools/testing/selftests/proc/proc-self-map-files-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-002=
=2Ec  -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b555=
6c3bb08185585a/tools/testing/selftests/proc/proc-self-map-files-002
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-syscall.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb081=
85585a/tools/testing/selftests/proc/proc-self-syscall
proc-self-syscall.c:16:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-wchan.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185=
585a/tools/testing/selftests/proc/proc-self-wchan
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-001.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185=
585a/tools/testing/selftests/proc/proc-uptime-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-002.c  -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185=
585a/tools/testing/selftests/proc/proc-uptime-002
proc-uptime-002.c:18:0: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>:0:0: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    read.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/=
testing/selftests/proc/read
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    self.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/=
testing/selftests/proc/self
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    thread-self.c  -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a=
/tools/testing/selftests/proc/thread-self
TAP version 13
selftests: proc: fd-001-lookup
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: proc: fd-001-lookup [PASS]
selftests: proc: fd-002-posix-eq
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..2 selftests: proc: fd-002-posix-eq [PASS]
selftests: proc: fd-003-kthread
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: proc: fd-003-kthread [PASS]
selftests: proc: proc-loadavg-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: proc: proc-loadavg-001 [PASS]
selftests: proc: proc-self-map-files-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: proc: proc-self-map-files-001 [PASS]
selftests: proc: proc-self-map-files-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..6 selftests: proc: proc-self-map-files-002 [PASS]
selftests: proc: proc-self-syscall
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..7 selftests: proc: proc-self-syscall [PASS]
selftests: proc: proc-self-wchan
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..8 selftests: proc: proc-self-wchan [PASS]
selftests: proc: proc-uptime-001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..9 selftests: proc: proc-uptime-001 [PASS]
selftests: proc: proc-uptime-002
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..10 selftests: proc: proc-uptime-002 [PASS]
selftests: proc: read
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..11 selftests: proc: read [PASS]
selftests: proc: self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..12 selftests: proc: self [PASS]
selftests: proc: thread-self
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..13 selftests: proc: thread-self [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/proc'

2018-12-29 12:46:15 make run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/pstore'
TAP version 13
selftests: pstore: pstore_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
UUID=3Dea7aae83-e9c2-4522-9bb7-d96656f6fae2
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-snb-4G-202::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/=
lkp/jobs/scheduled/vm-snb-4G-202/kernel_selftests-kselftests-02-debian-x86_=
64-2018-04-03.cgz-03f1c26b1c56936fa29675b5556c3bb08185585a-20181229-76446-1=
5mua6t-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/=
devel-hourly-2018122717 commit=3D03f1c26b1c56936fa29675b5556c3bb08185585a B=
OOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3b=
b08185585a/vmlinuz-4.20.0-rc4-00985-g03f1c26 erst_disable max_uptime=3D3600=
 RESULT_ROOT=3D/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_=
64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb0818=
5585a/3 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rcupdate.r=
cu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 s=
oftlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prom=
pt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel=
 console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnor=
mal rw rcuperf.shutdown=3D0
Checking pstore console is registered ... ok
Checking /dev/pmsg0 exists ... ok
Writing unique string to /dev/pmsg0 ... ok
ok 1..1 selftests: pstore: pstore_tests [PASS]
selftests: pstore: pstore_post_reboot_tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
UUID=3D74ce1231-c7cf-4343-9211-701ef53c389c
Checking pstore backend is registered ... ok
	backend=3Dramoops
	cmdline=3Dip=3D::::vm-snb-4G-202::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/=
lkp/jobs/scheduled/vm-snb-4G-202/kernel_selftests-kselftests-02-debian-x86_=
64-2018-04-03.cgz-03f1c26b1c56936fa29675b5556c3bb08185585a-20181229-76446-1=
5mua6t-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/=
devel-hourly-2018122717 commit=3D03f1c26b1c56936fa29675b5556c3bb08185585a B=
OOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3b=
b08185585a/vmlinuz-4.20.0-rc4-00985-g03f1c26 erst_disable max_uptime=3D3600=
 RESULT_ROOT=3D/result/kernel_selftests/kselftests-02/vm-snb-4G/debian-x86_=
64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/03f1c26b1c56936fa29675b5556c3bb0818=
5585a/3 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rcupdate.r=
cu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 s=
oftlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prom=
pt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel=
 console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnor=
mal rw rcuperf.shutdown=3D0
pstore_crash_test has not been executed yet. we skip further tests.
not ok 1..2 selftests: pstore: pstore_post_reboot_tests [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/pstore'
ptp test: not in Makefile
2018-12-29 12:46:17 make TARGETS=3Dptp
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptp'

2018-12-29 12:46:19 make run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ptp: testptp
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..1 selftests: ptp: testptp [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptp'

2018-12-29 12:46:19 make run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptrace'
gcc -iquote../../../../include/uapi -Wall    peeksiginfo.c  -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/=
testing/selftests/ptrace/peeksiginfo
TAP version 13
selftests: ptrace: peeksiginfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS
ok 1..1 selftests: ptrace: peeksiginfo [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1c=
56936fa29675b5556c3bb08185585a/tools/testing/selftests/ptrace'

2018-12-29 12:46:21 make run_tests -C rseq
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26b1=
c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq'
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -shar=
ed -fPIC rseq.c -lpthread -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c2=
6b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/librseq.so
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ basic=
_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/basic_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ basic=
_percpu_ops_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-=
7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/b=
asic_percpu_ops_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ param=
_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel-7.2-03f1c26=
b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/param_test
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -DBEN=
CHMARK param_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x86_64-rhel=
-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selftests/rseq/=
param_test_benchmark
gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=3D./ -DRSE=
Q_COMPARE_TWICE param_test.c -lpthread -lrseq -o /usr/src/perf_selftests-x8=
6_64-rhel-7.2-03f1c26b1c56936fa29675b5556c3bb08185585a/tools/testing/selfte=
sts/rseq/param_test_compare_twice
TAP version 13
selftests: rseq: basic_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
testing current cpu
ok 1..1 selftests: rseq: basic_test [PASS]
selftests: rseq: basic_percpu_ops_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
spinlock
percpu_list
ok 1..2 selftests: rseq: basic_percpu_ops_test [PASS]
selftests: rseq: param_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..3 selftests: rseq: param_test [PASS]
selftests: rseq: param_test_benchmark
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..4 selftests: rseq: param_test_benchmark [PASS]
selftests: rseq: param_test_compare_twice
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ok 1..5 selftests: rseq: param_test_compare_twice [PASS]
selftests: rseq: run_param_test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Default parameters
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Loop injection: 10000 loops
Injecting at <1>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <2>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <3>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <4>
Running test spinlock
Running compare-twice test spinlock
Running test list
Running compare-twice test list
Running test buffer
Running compare-twice test buffer
Running test buffer with barrier
Running compare-twice test buffer with barrier
Running test memcpy
Running compare-twice test memcpy
Running test memcpy with barrier
Running compare-twice test memcpy with barrier
Running test increment
Running compare-twice test increment
Injecting at <5>
Running test spinlock
Running compare-twice test spinlock

--LQAwcd5tHl0Qlnzi--
