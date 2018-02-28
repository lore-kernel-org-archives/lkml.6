Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2277+NTmwfyy+N7H6SRRh46JHHs51OfJresQvj6JHpnts0f/aVN1CHgtfiSqSK1aAabpeOBQ
ARC-Seal: i=1; a=rsa-sha256; t=1519852238; cv=none;
        d=google.com; s=arc-20160816;
        b=HgKNxmBrhZsI+fAMr9N1R4JmO0yBdjwxgQmVbSbL5XbbGesniKYvdTr7swnc2fBEyn
         i/d9Buhb4hDItDIMQ7V3F0Db8qvqZGx7orhlWkaOzZe6xlwQQGC0H6oWz9i7S/gaFX6M
         kPT3Not+8f8nmupyTXAlFQhdIlUIX293qs5q9fgObRA6WUYXFRDRCG8gU5RxxL1i/epP
         MmBtoG1C6s3j9mu2yKHDM3qpzyraaNkQv0Ecwwsz/JOA5FsEp1C0ztnxM8SklPGR/8BK
         2GvIjn1cdw7jM0HSECaPpAZ2XQ8Z8Yhpl8UI5KIYYpk/BudcsAnHxtmhGAPrZTYC61C6
         fDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:arc-authentication-results;
        bh=lvRPuDiQQtRIRXuaVqTvXGTiczJct8wAwJmVW20HYKo=;
        b=w9fvATjl/w0cS/JJRv8hdZM7/3/hO484QqUfda/RfZUiSTebuSKhN0Irh0Jc5n/CAb
         PdCmiYG1m1OK/GEu4zCWjLQRubMWWv/cW0GBiWNW2T09bAbY3fMvFGRdOHCwaL4K+Xmx
         Z5UAxQXC9449mK8d/DGgqFlYfrPaGBPdqKqAhK+m04u2J2vjBft9I63ydZak0P8iwRLD
         Wt1bXiXSG+GO0PRIyD8y68Yt7J4jL+QeK81WFke36j1Te5NA/IVR0mpVelgPflzxTcnU
         YwoMApxD+NYJLXUSTAy1kk47iEjGgcIZoLHqOqFf8GEXmvgHg4PYbthzJfWWLGgwnSnW
         LV3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932904AbeB1VKi (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 28 Feb 2018 16:10:38 -0500
Received: from osg.samsung.com ([64.30.133.232]:40431 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932400AbeB1VKh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Feb 2018 16:10:37 -0500
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [GIT PULL] kselftest fixes update for 4.16-rc4
Message-ID: <9f1d717e-f968-feb6-5fe7-9bfb7c304743@osg.samsung.com>
Date: Wed, 28 Feb 2018 14:10:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4471A8F75628C17655391D4D"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593680580705761943?=
X-GMAIL-MSGID: =?utf-8?q?1593680580705761943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------4471A8F75628C17655391D4D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for 4.16-rc4.

This kselftest fixes update for 4.16-rc4 consists of of fixes for
various problems in test output, compile errors, and missing configs.

Diff for the update is attached.

thanks,
-- Shuah

-----------------------------------------------------------------------------------
The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.16-rc4

for you to fetch changes up to f6869826de700bce59e2cef14974f99836e34e4f:

  selftests: vm: update .gitignore with new test (2018-02-26 16:09:50 -0700)

----------------------------------------------------------------
linux-kselftest-4.16-rc4

This kselftest fixes update for 4.16-rc4 consists of of fixes for
various problems in test output, compile errors, and missing configs.

----------------------------------------------------------------
Anders Roxell (2):
      selftests: sync: missing CFLAGS while compiling
      selftests: memfd: add config fragment for fuse

Daniel Díaz (2):
      selftests/android: Fix line continuation in Makefile
      selftests/futex: Fix line continuation in Makefile

Dominik Brodowski (1):
      selftest/vDSO: fix O=

Naresh Kamboju (1):
      selftests: pstore: Adding config fragment CONFIG_PSTORE_RAM=m

Shuah Khan (2):
      selftests: memory-hotplug: silence test command echo
      selftests: vm: update .gitignore with new test

 tools/testing/selftests/android/Makefile        |  8 ++++----
 tools/testing/selftests/futex/Makefile          |  6 +++---
 tools/testing/selftests/memfd/config            |  1 +
 tools/testing/selftests/memory-hotplug/Makefile |  2 +-
 tools/testing/selftests/pstore/config           |  1 +
 tools/testing/selftests/sync/Makefile           |  2 +-
 tools/testing/selftests/vDSO/Makefile           | 14 +++++++-------
 tools/testing/selftests/vm/.gitignore           |  1 +
 8 files changed, 19 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/memfd/config
-----------------------------------------------------------------------------------


--------------4471A8F75628C17655391D4D
Content-Type: text/x-patch;
 name="linux-kselftest-4.16-rc4.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="linux-kselftest-4.16-rc4.diff"

diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/sel=
ftests/android/Makefile
index 1a7492268993..f6304d2be90c 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -11,11 +11,11 @@ all:
 		BUILD_TARGET=3D$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
 		make OUTPUT=3D$$BUILD_TARGET -C $$DIR $@;\
-		#SUBDIR test prog name should be in the form: SUBDIR_test.sh
+		#SUBDIR test prog name should be in the form: SUBDIR_test.sh \
 		TEST=3D$$DIR"_test.sh"; \
-		if [ -e $$DIR/$$TEST ]; then
-			rsync -a $$DIR/$$TEST $$BUILD_TARGET/;
-		fi
+		if [ -e $$DIR/$$TEST ]; then \
+			rsync -a $$DIR/$$TEST $$BUILD_TARGET/; \
+		fi \
 	done
=20
 override define RUN_TESTS
diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selft=
ests/futex/Makefile
index cea4adcd42b8..a63e8453984d 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -12,9 +12,9 @@ all:
 		BUILD_TARGET=3D$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
 		make OUTPUT=3D$$BUILD_TARGET -C $$DIR $@;\
-		if [ -e $$DIR/$(TEST_PROGS) ]; then
-			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/;
-		fi
+		if [ -e $$DIR/$(TEST_PROGS) ]; then \
+			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/; \
+		fi \
 	done
=20
 override define RUN_TESTS
diff --git a/tools/testing/selftests/memfd/config b/tools/testing/selftes=
ts/memfd/config
new file mode 100644
index 000000000000..835c7f4dadcd
--- /dev/null
+++ b/tools/testing/selftests/memfd/config
@@ -0,0 +1 @@
+CONFIG_FUSE_FS=3Dm
diff --git a/tools/testing/selftests/memory-hotplug/Makefile b/tools/test=
ing/selftests/memory-hotplug/Makefile
index 86636d207adf..183b46883875 100644
--- a/tools/testing/selftests/memory-hotplug/Makefile
+++ b/tools/testing/selftests/memory-hotplug/Makefile
@@ -4,7 +4,7 @@ all:
 include ../lib.mk
=20
 TEST_PROGS :=3D mem-on-off-test.sh
-override RUN_TESTS :=3D ./mem-on-off-test.sh -r 2 && echo "selftests: me=
mory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
+override RUN_TESTS :=3D @./mem-on-off-test.sh -r 2 && echo "selftests: m=
emory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
 override EMIT_TESTS :=3D echo "$(RUN_TESTS)"
=20
 run_full_test:
diff --git a/tools/testing/selftests/pstore/config b/tools/testing/selfte=
sts/pstore/config
index 6a8e5a9bfc10..d148f9f89fb6 100644
--- a/tools/testing/selftests/pstore/config
+++ b/tools/testing/selftests/pstore/config
@@ -2,3 +2,4 @@ CONFIG_MISC_FILESYSTEMS=3Dy
 CONFIG_PSTORE=3Dy
 CONFIG_PSTORE_PMSG=3Dy
 CONFIG_PSTORE_CONSOLE=3Dy
+CONFIG_PSTORE_RAM=3Dm
diff --git a/tools/testing/selftests/sync/Makefile b/tools/testing/selfte=
sts/sync/Makefile
index b3c8ba3cb668..d0121a8a3523 100644
--- a/tools/testing/selftests/sync/Makefile
+++ b/tools/testing/selftests/sync/Makefile
@@ -30,7 +30,7 @@ $(TEST_CUSTOM_PROGS): $(TESTS) $(OBJS)
 	$(CC) -o $(TEST_CUSTOM_PROGS) $(OBJS) $(TESTS) $(CFLAGS) $(LDFLAGS)
=20
 $(OBJS): $(OUTPUT)/%.o: %.c
-	$(CC) -c $^ -o $@
+	$(CC) -c $^ -o $@ $(CFLAGS)
=20
 $(TESTS): $(OUTPUT)/%.o: %.c
 	$(CC) -c $^ -o $@
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selfte=
sts/vDSO/Makefile
index 3d5a62ff7d31..f5d7a7851e21 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+include ../lib.mk
+
 ifndef CROSS_COMPILE
 CFLAGS :=3D -std=3Dgnu99
 CFLAGS_vdso_standalone_test_x86 :=3D -nostdlib -fno-asynchronous-unwind-=
tables -fno-stack-protector
@@ -6,16 +8,14 @@ ifeq ($(CONFIG_X86_32),y)
 LDLIBS +=3D -lgcc_s
 endif
=20
-TEST_PROGS :=3D vdso_test vdso_standalone_test_x86
+TEST_PROGS :=3D $(OUTPUT)/vdso_test $(OUTPUT)/vdso_standalone_test_x86
=20
 all: $(TEST_PROGS)
-vdso_test: parse_vdso.c vdso_test.c
-vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
+$(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
+$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vds=
o.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
-		-o vdso_standalone_test_x86
+		-o $@
=20
-include ../lib.mk
-clean:
-	rm -fr $(TEST_PROGS)
+EXTRA_CLEAN :=3D $(TEST_PROGS)
 endif
diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selfte=
sts/vm/.gitignore
index 63c94d776e89..342c7bc9dc8c 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -11,3 +11,4 @@ mlock-intersect-test
 mlock-random-test
 virtual_address_range
 gup_benchmark
+va_128TBswitch

--------------4471A8F75628C17655391D4D--
