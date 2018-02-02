Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227Q911o+MVVCfnjkbdT/ec1+kc5K/h6oNhALy02lkyIuJQD2nsDGftQWINMWnExyfo45e2k
ARC-Seal: i=1; a=rsa-sha256; t=1517592004; cv=none;
        d=google.com; s=arc-20160816;
        b=oKkKv2HPPp2K5HtxwF5BmqXvtqmJhYCv47k7/cIHvBdATjFmgq2tWvT2fWtmmxWV84
         oNpp1CBtfcfekebMW6jV/NCbH6Tyu0NOFgjWAYnC8TLg8Pa/aNBRkKCLtiGL31BJnY26
         T1ypdKwMNzj0ENM8R/iCAEZVZHtkMxBAIrYMvnj/x2Ta4e5ayPUM3ATNjonMqJkWiO+f
         UL/qWbdl1oqsurD4NLW7HwN8AIULKWktjqxMejxppzfmnjBZm179j45SvHccA/96I1Tw
         Ww+Bq54YKl3wO9LUXY4de99mbZWq29+MOaFI9Y/pPQ0lkxErP/CYQng7ndT0g+jJbMu0
         Xo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:arc-authentication-results;
        bh=07ttCcWpzQidLX9O+Ik630i6yd2quDOn5ieyvGv0tt0=;
        b=T+e4ZDwIn2TTHYh6hgijFfLOkmhUC177mXeb7QMKuqZJIVtn/an1tk++RStOBT+aKy
         mhbsVJn+KvSkjY+cp+1RdczmHpkOuPkRlRrrrrBlftFjutkHYxomIV2OBmf4hNg8/Dvm
         mHx4fHwBmqWSykFIn9YCjdS4WijvlXLCLSuBk+LXYxcsxDavBHvjaGhl6Snhc2tpv/wZ
         pmlNbM2L06eL7NAu6ZyJ10/gspHLHP4/fajvufAhG9BxSXhLMYuu9n9eMGUiroz3ACKj
         SW5S6OTmquyVaDrlh3wEgGa6WdPlGZk1PfCBibEFtZ8hVIOvDLOogq1OANS6F/uudoXz
         f4vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbeBBRTy (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 2 Feb 2018 12:19:54 -0500
Received: from osg.samsung.com ([64.30.133.232]:52876 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753847AbeBBRTn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Feb 2018 12:19:43 -0500
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [GIT PULL] kselftest update for 4.16-rc1
Message-ID: <1702f942-5edc-89b4-0ff7-16483236c674@osg.samsung.com>
Date: Fri, 2 Feb 2018 10:19:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------93E2E32BBC2679454D483D02"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591310553510579447?=
X-GMAIL-MSGID: =?utf-8?q?1591310553510579447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------93E2E32BBC2679454D483D02
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for 4.16-rc1

This update to Kselftest consists of fixes, cleanups, and SPDX license
additions.

Diff for the update is attached.

thanks,
-- Shuah

-----------------------------------------------------------------------------------

The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.16-rc1

for you to fetch changes up to 0e9e327d1622c332e5b1db272d5c97af82164f68:

  selftests: vm: update .gitignore with missing generated file (2018-01-23 07:47:06 -0700)

----------------------------------------------------------------
linux-kselftest-4.16-rc1

This update to Kselftest consists of fixes, cleanups, and SPDX license
additions.

----------------------------------------------------------------
Anders Roxell (1):
      selftests: seccomp: fix compile error seccomp_bpf

Arnd Bergmann (1):
      kselftest: fix OOM in memory compaction test

Dmitry Safonov (1):
      selftests/x86: Add <test_name>{,_32,_64} targets

Luis de Bethencourt (1):
      tools/testing: Fix trailing semicolon

Masami Hiramatsu (2):
      selftest: ftrace: Fix to pick text symbols for kprobes
      selftest: ftrace: Fix to add 256 kprobe events correctly

Michael Ellerman (1):
      selftests: Fix loss of test output in run_kselftests.sh

Shuah Khan (6):
      selftests: media_tests: Fix Makefile 'clean' target warning
      selftests: gen_kselftest_tar.h: Add SPDX license identifier
      selftests: kselftest_install.sh: Add SPDX license identifier
      selftests: kselftest.h: Add SPDX license identifier
      selftests: media_tests: Add SPDX license identifier
      selftests: vm: update .gitignore with missing generated file

 tools/testing/selftests/Makefile                    |  9 ++++++++-
 .../ftrace/test.d/kprobe/multiple_kprobes.tc        | 21 ++++++++++++++++++---
 tools/testing/selftests/gen_kselftest_tar.sh        |  4 +---
 tools/testing/selftests/kselftest.h                 |  2 +-
 tools/testing/selftests/kselftest_install.sh        |  4 +---
 tools/testing/selftests/lib.mk                      |  2 +-
tools/testing/selftests/media_tests/Makefile        |  7 ++-----
 .../selftests/media_tests/media_device_open.c       |  3 ++-
 .../selftests/media_tests/media_device_test.c       |  3 ++-
 .../selftests/media_tests/video_device_test.c       |  3 ++-
 tools/testing/selftests/nsfs/pidns.c                |  2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c       |  4 ++--
 tools/testing/selftests/vm/.gitignore               |  1 +
 tools/testing/selftests/vm/compaction_test.c        |  2 ++
 tools/testing/selftests/x86/Makefile                | 12 ++++++++++++
 15 files changed, 56 insertions(+), 23 deletions(-)
-----------------------------------------------------------------------------------

--------------93E2E32BBC2679454D483D02
Content-Type: text/x-patch;
 name="linux-kselftest-4.16-rc1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="linux-kselftest-4.16-rc1.diff"

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
index eaf599dc2137..7442dfb73b7f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -116,8 +116,15 @@ ifdef INSTALL_PATH
=20
 	@# Ask all targets to emit their test scripts
 	echo "#!/bin/sh" > $(ALL_SCRIPT)
-	echo "cd \$$(dirname \$$0)" >> $(ALL_SCRIPT)
+	echo "BASE_DIR=3D\$$(realpath \$$(dirname \$$0))" >> $(ALL_SCRIPT)
+	echo "cd \$$BASE_DIR" >> $(ALL_SCRIPT)
 	echo "ROOT=3D\$$PWD" >> $(ALL_SCRIPT)
+	echo "if [ \"\$$1\" =3D \"--summary\" ]; then" >> $(ALL_SCRIPT)
+	echo "  OUTPUT=3D\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
+	echo "  cat /dev/null > \$$OUTPUT" >> $(ALL_SCRIPT)
+	echo "else" >> $(ALL_SCRIPT)
+	echo "  OUTPUT=3D/dev/stdout" >> $(ALL_SCRIPT)
+	echo "fi" >> $(ALL_SCRIPT)
=20
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=3D$$BUILD/$$TARGET;	\
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobe=
s.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index bb16cf91f1b5..ce361b9d62cf 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -12,9 +12,24 @@ case `uname -m` in
   *) OFFS=3D0;;
 esac
=20
-echo "Setup up to 256 kprobes"
-grep t /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
-head -n 256 | while read i; do echo p ${i}+${OFFS} ; done > kprobe_event=
s ||:
+if [ -d events/kprobes ]; then
+  echo 0 > events/kprobes/enable
+  echo > kprobe_events
+fi
+
+N=3D0
+echo "Setup up kprobes on first available 256 text symbols"
+grep -i " t " /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
+while read i; do
+  echo p ${i}+${OFFS} >> kprobe_events && N=3D$((N+1)) ||:
+  test $N -eq 256 && break
+done
+
+L=3D`wc -l kprobe_events`
+if [ $L -ne $N ]; then
+  echo "The number of kprobes events ($L) is not $N"
+  exit_fail
+fi
=20
 echo 1 > events/kprobes/enable
 echo 0 > events/kprobes/enable
diff --git a/tools/testing/selftests/gen_kselftest_tar.sh b/tools/testing=
/selftests/gen_kselftest_tar.sh
index 17d5bd0c0936..a27e2eec3586 100755
--- a/tools/testing/selftests/gen_kselftest_tar.sh
+++ b/tools/testing/selftests/gen_kselftest_tar.sh
@@ -1,13 +1,11 @@
 #!/bin/bash
 #
+# SPDX-License-Identifier: GPL-2.0
 # gen_kselftest_tar
 # Generate kselftest tarball
 # Author: Shuah Khan <shuahkh@osg.samsung.com>
 # Copyright (C) 2015 Samsung Electronics Co., Ltd.
=20
-# This software may be freely redistributed under the terms of the GNU
-# General Public License (GPLv2).
-
 # main
 main()
 {
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftest=
s/kselftest.h
index 1ae565ed9bf0..1a52b03962a3 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * kselftest.h:	kselftest framework return codes to include from
  *		selftests.
@@ -5,7 +6,6 @@
  * Copyright (c) 2014 Shuah Khan <shuahkh@osg.samsung.com>
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *
- * This file is released under the GPLv2.
  */
 #ifndef __KSELFTEST_H
 #define __KSELFTEST_H
diff --git a/tools/testing/selftests/kselftest_install.sh b/tools/testing=
/selftests/kselftest_install.sh
index 1555fbdb08da..ec304463883c 100755
--- a/tools/testing/selftests/kselftest_install.sh
+++ b/tools/testing/selftests/kselftest_install.sh
@@ -1,13 +1,11 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
 #
 # Kselftest Install
 # Install kselftest tests
 # Author: Shuah Khan <shuahkh@osg.samsung.com>
 # Copyright (C) 2015 Samsung Electronics Co., Ltd.
=20
-# This software may be freely redistributed under the terms of the GNU
-# General Public License (GPLv2).
-
 install_loc=3D`pwd`
=20
 main()
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib=
=2Emk
index 5bef05d6ba39..7de482a0519d 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -77,7 +77,7 @@ endif
 define EMIT_TESTS
 	@for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \=

 		BASENAME_TEST=3D`basename $$TEST`;	\
-		echo "(./$$BASENAME_TEST > /tmp/$$BASENAME_TEST 2>&1 && echo \"selftes=
ts: $$BASENAME_TEST [PASS]\") || echo \"selftests: $$BASENAME_TEST [FAIL]=
\""; \
+		echo "(./$$BASENAME_TEST >> \$$OUTPUT 2>&1 && echo \"selftests: $$BASE=
NAME_TEST [PASS]\") || echo \"selftests: $$BASENAME_TEST [FAIL]\""; \
 	done;
 endef
=20
diff --git a/tools/testing/selftests/media_tests/Makefile b/tools/testing=
/selftests/media_tests/Makefile
index be5bd4ffb895..c82cec2497de 100644
--- a/tools/testing/selftests/media_tests/Makefile
+++ b/tools/testing/selftests/media_tests/Makefile
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS :=3D media_device_test media_device_open video_device_test
-all: $(TEST_PROGS)
+TEST_GEN_PROGS :=3D media_device_test media_device_open video_device_tes=
t
+all: $(TEST_GEN_PROGS)
=20
 include ../lib.mk
-
-clean:
-	rm -fr media_device_test media_device_open video_device_test
diff --git a/tools/testing/selftests/media_tests/media_device_open.c b/to=
ols/testing/selftests/media_tests/media_device_open.c
index 44343c091a20..a5ce5434bafd 100644
--- a/tools/testing/selftests/media_tests/media_device_open.c
+++ b/tools/testing/selftests/media_tests/media_device_open.c
@@ -1,10 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * media_device_open.c - Media Controller Device Open Test
  *
  * Copyright (c) 2016 Shuah Khan <shuahkh@osg.samsung.com>
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  *
- * This file is released under the GPLv2.
  */
=20
 /*
diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/to=
ols/testing/selftests/media_tests/media_device_test.c
index 5d49943e77d0..421a367e4bb3 100644
--- a/tools/testing/selftests/media_tests/media_device_test.c
+++ b/tools/testing/selftests/media_tests/media_device_test.c
@@ -1,10 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * media_device_test.c - Media Controller Device ioctl loop Test
  *
  * Copyright (c) 2016 Shuah Khan <shuahkh@osg.samsung.com>
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  *
- * This file is released under the GPLv2.
  */
=20
 /*
diff --git a/tools/testing/selftests/media_tests/video_device_test.c b/to=
ols/testing/selftests/media_tests/video_device_test.c
index 66d419c28653..0f6aef2e2593 100644
--- a/tools/testing/selftests/media_tests/video_device_test.c
+++ b/tools/testing/selftests/media_tests/video_device_test.c
@@ -1,10 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * video_device_test - Video Device Test
  *
  * Copyright (c) 2016 Shuah Khan <shuahkh@osg.samsung.com>
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  *
- * This file is released under the GPLv2.
  */
=20
 /*
diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftes=
ts/nsfs/pidns.c
index 1182d4e437a2..e0d86e1668c0 100644
--- a/tools/testing/selftests/nsfs/pidns.c
+++ b/tools/testing/selftests/nsfs/pidns.c
@@ -70,7 +70,7 @@ int main(int argc, char *argv[])
 			return pr_err("NS_GET_PARENT returned a wrong namespace");
=20
 		if (ioctl(pns, NS_GET_PARENT) >=3D 0 || errno !=3D EPERM)
-			return pr_err("Don't get EPERM");;
+			return pr_err("Don't get EPERM");
 	}
=20
 	kill(pid, SIGKILL);
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testin=
g/selftests/seccomp/seccomp_bpf.c
index 24dbf634e2dd..0b457e8e0f0c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1717,7 +1717,7 @@ void tracer_ptrace(struct __test_metadata *_metadat=
a, pid_t tracee,
=20
 	if (nr =3D=3D __NR_getpid)
 		change_syscall(_metadata, tracee, __NR_getppid);
-	if (nr =3D=3D __NR_open)
+	if (nr =3D=3D __NR_openat)
 		change_syscall(_metadata, tracee, -1);
 }
=20
@@ -1792,7 +1792,7 @@ TEST_F(TRACE_syscall, ptrace_syscall_dropped)
 					   true);
=20
 	/* Tracer should skip the open syscall, resulting in EPERM. */
-	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_open));
+	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_openat));
 }
=20
 TEST_F(TRACE_syscall, syscall_allowed)
diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selfte=
sts/vm/.gitignore
index 1ca2ee4d15b9..63c94d776e89 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -10,3 +10,4 @@ userfaultfd
 mlock-intersect-test
 mlock-random-test
 virtual_address_range
+gup_benchmark
diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing=
/selftests/vm/compaction_test.c
index a65b016d4c13..1097f04e4d80 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -137,6 +137,8 @@ int check_compaction(unsigned long mem_free, unsigned=
 int hugepage_size)
 	printf("No of huge pages allocated =3D %d\n",
 	       (atoi(nr_hugepages)));
=20
+	lseek(fd, 0, SEEK_SET);
+
 	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
 	    !=3D strlen(initial_nr_hugepages)) {
 		perror("Failed to write value to /proc/sys/vm/nr_hugepages\n");
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftes=
ts/x86/Makefile
index 939a337128db..e7324fbc76b1 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -27,14 +27,26 @@ UNAME_M :=3D $(shell uname -m)
 CAN_BUILD_I386 :=3D $(shell ./check_cc.sh $(CC) trivial_32bit_program.c =
-m32)
 CAN_BUILD_X86_64 :=3D $(shell ./check_cc.sh $(CC) trivial_64bit_program.=
c)
=20
+define gen-target-rule-32
+$(1) $(1)_32: $(OUTPUT)/$(1)_32
+.PHONY: $(1) $(1)_32
+endef
+
+define gen-target-rule-64
+$(1) $(1)_64: $(OUTPUT)/$(1)_64
+.PHONY: $(1) $(1)_64
+endef
+
 ifeq ($(CAN_BUILD_I386),1)
 all: all_32
 TEST_PROGS +=3D $(BINARIES_32)
+$(foreach t,$(TARGETS_C_32BIT_ALL),$(eval $(call gen-target-rule-32,$(t)=
)))
 endif
=20
 ifeq ($(CAN_BUILD_X86_64),1)
 all: all_64
 TEST_PROGS +=3D $(BINARIES_64)
+$(foreach t,$(TARGETS_C_64BIT_ALL),$(eval $(call gen-target-rule-64,$(t)=
)))
 endif
=20
 all_32: $(BINARIES_32)

--------------93E2E32BBC2679454D483D02--
