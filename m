Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+qZzABH5o6tASnAkix5kz9mbbU8mya8LER3NAZw6ej6INuTXO/BiMDFGsWVF7RNF5YNWbf
ARC-Seal: i=1; a=rsa-sha256; t=1523048794; cv=none;
        d=google.com; s=arc-20160816;
        b=KBuQ3M699reRmqeBsBhAYSbJA2/8xGLWOVkmatvmb3DFQno+9+1oO11EM6yyKrB+5I
         cYACXY4IQWBWZFaZayZK/mKeqFqDZO2VLLfNLh58JTYiR3V25SuMD26ivTRp/jSGngKx
         jMnpWL3dUbqq5DVhck+7ziiUId7eGOhfNHQu5AdFkRhTdRsEU7h/bUllu0+VzFV8fCRE
         oemgcWjaYaTBb/e7oAZiyu2E7TGDrzmn3ZErIzpfAaCQ2tFK70Vg8FWJExwcwYVg13GN
         jr9EVr8aO0pL9w0Rrl3r+jUJlBYc8ITdWZEDmo9PsUAz77lLcV2RdQdjExJFxStjoZyW
         q19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language:mime-version:user-agent
         :date:message-id:autocrypt:openpgp:subject:from:cc:to
         :arc-authentication-results;
        bh=o9TqbpdepjqKhJ9ZGgPYyEkGzP1wvHfChZHtwIediDg=;
        b=SQDREpEFxHVrOu+06TqoMM0sRO00fihWQZAl10Hwvbw9bbKAmdzz43P4IXg+h4dwaf
         50MbvNGwa3CFfQC2/ak/Wl2i52p8viSaUKAAy/i/SEwJTIIsq1S97QO84ZsKD+pAi1nj
         kCbkN9APqBRjqoYgqm5UfkhKrTDNcygfcH+O0AgAfHUFyQzpbCEFOmCDFmYZ/LkccwAG
         zqqU+K9QIdIJndUIYQCLK5HHFI/pNbzs5eUdzBcvS7eTddx6vKtD07AS+dGdb4VmWyx4
         fZdhNvpmaPcccBV3P592WuSJdUk1hezlmrcYyoKUNjYVAMoPVFyfHFw4BSjT/Tq/6gDy
         RRJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeDFVGd (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 6 Apr 2018 17:06:33 -0400
Received: from osg.samsung.com ([64.30.133.232]:34829 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbeDFVGb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Apr 2018 17:06:31 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [GIT PULL] kselftest update for 4.17-rc1
Openpgp: preference=signencrypt
Autocrypt: addr=shuahkh@osg.samsung.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b5ad417c-e608-a6e3-6978-5691369c41c3@osg.samsung.com>
Date: Fri, 6 Apr 2018 15:06:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------29A3F05FDA5C1A83CDDF63F1"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597032412487781997?=
X-GMAIL-MSGID: =?utf-8?q?1597032412487781997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------29A3F05FDA5C1A83CDDF63F1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for 4.17-rc1

This Kselftest update for 4.17-rc1 consists of:

- Test build error fixes.
- Fixes to prevent intel_pstate from building on non-x86 systems.
- New test for ion with vgem driver.
- Change to print the test name to /dev/kmsg to add context to kernel
  failures if any uncovered from running the test.
- Kselftest framework enhancements to add KSFT_TAP_LEVEL environment
  variable to prevent nested TAP headers being printed in the Kselftest
  output. Nested TAP13 headers could cause problems for some parsers.
  This change suppresses the nested headers from test programs and test
  shell scripts with changes to framework and Makefiles without changing
  the tests.

Diff for the update is attached.

thanks,
-- Shuah

-----------------------------------------------------------------------------------
The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.17-rc1

for you to fetch changes up to 6aa69043d9f3f4adc5b3817ccfcac1fddfe10ded:

  selftests/intel_pstate: Fix build rule for x86 (2018-04-02 11:55:47 -0600)

----------------------------------------------------------------
linux-kselftest-4.17-rc1

This Kselftest update for 4.17-rc1 consists of:

- Test build error fixes.
- Fixes to prevent intel_pstate from building on non-x86 systems.
- New test for ion with vgem driver.
- Change to print the test name to /dev/kmsg to add context to kernel
  failures if any uncovered from running the test.
- Kselftest framework enhancements to add KSFT_TAP_LEVEL environment
  variable to prevent nested TAP headers being printed in the Kselftest
  output. Nested TAP13 headers could cause problems for some parsers.
  This change suppresses the nested headers from test programs and test
  shell scripts with changes to framework and Makefiles without changing
  the tests.

----------------------------------------------------------------
Anders Roxell (1):
      selftests/android/ion: Makefile: fix build error

Daniel Díaz (1):
      selftests/intel_pstate: Fix build rule for x86

Kees Cook (1):
      selftests/seccomp: Allow get_metadata to XFAIL

Laura Abbott (2):
      selftests: ion: Remove some prints
      selftests: ion: Add simple test with the vgem driver

Michael Ellerman (1):
      selftests: Print the test we're running to /dev/kmsg

Shuah Khan (4):
      selftests: kselftest framework: add handling for TAP header level
      selftests: lib.mk set KSFT_TAP_LEVEL to prevent nested TAP headers
      selftests: Makefile set KSFT_TAP_LEVEL to prevent nested TAP headers
      selftests: futex Makefile add top level TAP header echo to RUN_TESTS

 tools/testing/selftests/Makefile                  |  11 +-
tools/testing/selftests/android/ion/.gitignore    |   1 +
 tools/testing/selftests/android/ion/Makefile      |   5 +-
 tools/testing/selftests/android/ion/config        |   1 +
 tools/testing/selftests/android/ion/ionmap_test.c | 136 ++++++++++++++++++++++
 tools/testing/selftests/android/ion/ionutils.c    |   6 -
 tools/testing/selftests/futex/Makefile            |   4 +
 tools/testing/selftests/intel_pstate/Makefile     |   5 +-
 tools/testing/selftests/kselftest.h               |   3 +-
 tools/testing/selftests/kselftest_harness.h       |  26 ++++-
 tools/testing/selftests/lib.mk                    |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c     |  15 ++-
 12 files changed, 200 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/android/ion/ionmap_test.c
-----------------------------------------------------------------------------------

--------------29A3F05FDA5C1A83CDDF63F1
Content-Type: text/x-patch;
 name="linux-kselftest-4.17-rc1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="linux-kselftest-4.17-rc1.diff"

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
index 7442dfb73b7f..f4dfee6ea8a4 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -66,6 +66,12 @@ ifndef BUILD
   BUILD :=3D $(shell pwd)
 endif
=20
+# KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP heade=
r
+# printing from tests. Applicable to run_tests case where run_tests adds=

+# TAP header prior running tests and when a test program invokes another=

+# with system() call. Export it here to cover override RUN_TESTS defines=
=2E
+export KSFT_TAP_LEVEL=3D`echo 1`
+
 export BUILD
 all:
 	@for TARGET in $(TARGETS); do		\
@@ -125,11 +131,14 @@ ifdef INSTALL_PATH
 	echo "else" >> $(ALL_SCRIPT)
 	echo "  OUTPUT=3D/dev/stdout" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
+	echo "export KSFT_TAP_LEVEL=3D`echo 1`" >> $(ALL_SCRIPT)
=20
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=3D$$BUILD/$$TARGET;	\
-		echo "echo ; echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
+		echo "echo ; echo TAP version 13" >> $(ALL_SCRIPT);	\
+		echo "echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
 		echo "echo =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D" >> $(ALL_SC=
RIPT); \
+		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\=
" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		make -s --no-print-directory OUTPUT=3D$$BUILD_TARGET -C $$TARGET emit_=
tests >> $(ALL_SCRIPT); \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
diff --git a/tools/testing/selftests/android/ion/.gitignore b/tools/testi=
ng/selftests/android/ion/.gitignore
index 67e6f391b2a9..95e8f4561474 100644
--- a/tools/testing/selftests/android/ion/.gitignore
+++ b/tools/testing/selftests/android/ion/.gitignore
@@ -1,2 +1,3 @@
 ionapp_export
 ionapp_import
+ionmap_test
diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing=
/selftests/android/ion/Makefile
index 96e0c448b39d..e03695287f76 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -1,8 +1,8 @@
=20
-INCLUDEDIR :=3D -I. -I../../../../../drivers/staging/android/uapi/
+INCLUDEDIR :=3D -I. -I../../../../../drivers/staging/android/uapi/ -I../=
=2E./../../../usr/include/
 CFLAGS :=3D $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
=20
-TEST_GEN_FILES :=3D ionapp_export ionapp_import
+TEST_GEN_FILES :=3D ionapp_export ionapp_import ionmap_test
=20
 all: $(TEST_GEN_FILES)
=20
@@ -14,3 +14,4 @@ include ../../lib.mk
=20
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
 $(OUTPUT)/ionapp_import: ionapp_import.c ipcsocket.c ionutils.c
+$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c
diff --git a/tools/testing/selftests/android/ion/config b/tools/testing/s=
elftests/android/ion/config
index 19db6ca9aa2b..b4ad748a9dd9 100644
--- a/tools/testing/selftests/android/ion/config
+++ b/tools/testing/selftests/android/ion/config
@@ -2,3 +2,4 @@ CONFIG_ANDROID=3Dy
 CONFIG_STAGING=3Dy
 CONFIG_ION=3Dy
 CONFIG_ION_SYSTEM_HEAP=3Dy
+CONFIG_DRM_VGEM=3Dy
diff --git a/tools/testing/selftests/android/ion/ionmap_test.c b/tools/te=
sting/selftests/android/ion/ionmap_test.c
new file mode 100644
index 000000000000..dab36b06b37d
--- /dev/null
+++ b/tools/testing/selftests/android/ion/ionmap_test.c
@@ -0,0 +1,136 @@
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <linux/dma-buf.h>
+
+#include <drm/drm.h>
+
+#include "ion.h"
+#include "ionutils.h"
+
+int check_vgem(int fd)
+{
+	drm_version_t version =3D { 0 };
+	char name[5];
+	int ret;
+
+	version.name_len =3D 4;
+	version.name =3D name;
+
+	ret =3D ioctl(fd, DRM_IOCTL_VERSION, &version);
+	if (ret)
+		return 1;
+
+	return strcmp(name, "vgem");
+}
+
+int open_vgem(void)
+{
+	int i, fd;
+	const char *drmstr =3D "/dev/dri/card";
+
+	fd =3D -1;
+	for (i =3D 0; i < 16; i++) {
+		char name[80];
+
+		sprintf(name, "%s%u", drmstr, i);
+
+		fd =3D open(name, O_RDWR);
+		if (fd < 0)
+			continue;
+
+		if (check_vgem(fd)) {
+			close(fd);
+			continue;
+		} else {
+			break;
+		}
+
+	}
+	return fd;
+}
+
+int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
+{
+	struct drm_prime_handle import_handle =3D { 0 };
+	int ret;
+
+	import_handle.fd =3D dma_buf_fd;
+	import_handle.flags =3D 0;
+	import_handle.handle =3D 0;
+
+	ret =3D ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
+	if (ret =3D=3D 0)
+		*handle =3D import_handle.handle;
+	return ret;
+}
+
+void close_handle(int vgem_fd, uint32_t handle)
+{
+	struct drm_gem_close close =3D { 0 };
+
+	close.handle =3D handle;
+	ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
+}
+
+int main()
+{
+	int ret, vgem_fd;
+	struct ion_buffer_info info;
+	uint32_t handle =3D 0;
+	struct dma_buf_sync sync =3D { 0 };
+
+	info.heap_type =3D ION_HEAP_TYPE_SYSTEM;
+	info.heap_size =3D 4096;
+	info.flag_type =3D ION_FLAG_CACHED;
+
+	ret =3D ion_export_buffer_fd(&info);
+	if (ret < 0) {
+		printf("ion buffer alloc failed\n");
+		return -1;
+	}
+
+	vgem_fd =3D open_vgem();
+	if (vgem_fd < 0) {
+		ret =3D vgem_fd;
+		printf("Failed to open vgem\n");
+		goto out_ion;
+	}
+
+	ret =3D import_vgem_fd(vgem_fd, info.buffd, &handle);
+
+	if (ret < 0) {
+		printf("Failed to import buffer\n");
+		goto out_vgem;
+	}
+
+	sync.flags =3D DMA_BUF_SYNC_START | DMA_BUF_SYNC_RW;
+	ret =3D ioctl(info.buffd, DMA_BUF_IOCTL_SYNC, &sync);
+	if (ret)
+		printf("sync start failed %d\n", errno);
+
+	memset(info.buffer, 0xff, 4096);
+
+	sync.flags =3D DMA_BUF_SYNC_END | DMA_BUF_SYNC_RW;
+	ret =3D ioctl(info.buffd, DMA_BUF_IOCTL_SYNC, &sync);
+	if (ret)
+		printf("sync end failed %d\n", errno);
+
+	close_handle(vgem_fd, handle);
+	ret =3D 0;
+
+out_vgem:
+	close(vgem_fd);
+out_ion:
+	ion_close_buffer_fd(&info);
+	printf("done.\n");
+	return ret;
+}
diff --git a/tools/testing/selftests/android/ion/ionutils.c b/tools/testi=
ng/selftests/android/ion/ionutils.c
index ce69c14f51fa..7d1d37c4ef6a 100644
--- a/tools/testing/selftests/android/ion/ionutils.c
+++ b/tools/testing/selftests/android/ion/ionutils.c
@@ -80,11 +80,6 @@ int ion_export_buffer_fd(struct ion_buffer_info *ion_i=
nfo)
 	heap_id =3D MAX_HEAP_COUNT + 1;
 	for (i =3D 0; i < query.cnt; i++) {
 		if (heap_data[i].type =3D=3D ion_info->heap_type) {
-			printf("--------------------------------------\n");
-			printf("heap type: %d\n", heap_data[i].type);
-			printf("  heap id: %d\n", heap_data[i].heap_id);
-			printf("heap name: %s\n", heap_data[i].name);
-			printf("--------------------------------------\n");
 			heap_id =3D heap_data[i].heap_id;
 			break;
 		}
@@ -204,7 +199,6 @@ void ion_close_buffer_fd(struct ion_buffer_info *ion_=
info)
 		/* Finally, close the client fd */
 		if (ion_info->ionfd > 0)
 			close(ion_info->ionfd);
-		printf("<%s>: buffer release successfully....\n", __func__);
 	}
 }
=20
diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selft=
ests/futex/Makefile
index a63e8453984d..8497a376ef9d 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -18,6 +18,10 @@ all:
 	done
=20
 override define RUN_TESTS
+	@export KSFT_TAP_LEVEL=3D`echo 1`;
+	@echo "TAP version 13";
+	@echo "selftests: futex";
+	@echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D";
 	@cd $(OUTPUT); ./run.sh
 endef
=20
diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testin=
g/selftests/intel_pstate/Makefile
index 5a3f7d37e912..7340fd6a9a9f 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -2,7 +2,10 @@
 CFLAGS :=3D $(CFLAGS) -Wall -D_GNU_SOURCE
 LDLIBS :=3D $(LDLIBS) -lm
=20
-ifeq (,$(filter $(ARCH),x86))
+uname_M :=3D $(shell uname -m 2>/dev/null || echo not)
+ARCH ?=3D $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)=

+
+ifeq (x86,$(ARCH))
 TEST_GEN_FILES :=3D msr aperf
 endif
=20
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftest=
s/kselftest.h
index 1a52b03962a3..1b9d8ecdebce 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -57,7 +57,8 @@ static inline int ksft_get_error_cnt(void) { return ksf=
t_cnt.ksft_error; }
=20
 static inline void ksft_print_header(void)
 {
-	printf("TAP version 13\n");
+	if (!(getenv("KSFT_TAP_LEVEL")))
+		printf("TAP version 13\n");
 }
=20
 static inline void ksft_print_cnts(void)
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/=
selftests/kselftest_harness.h
index e81bd28bdd89..6ae3730c4ee3 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -106,6 +106,27 @@
 		fprintf(TH_LOG_STREAM, "%s:%d:%s:" fmt "\n", \
 			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
=20
+/**
+ * XFAIL(statement, fmt, ...)
+ *
+ * @statement: statement to run after reporting XFAIL
+ * @fmt: format string
+ * @...: optional arguments
+ *
+ * This forces a "pass" after reporting a failure with an XFAIL prefix,
+ * and runs "statement", which is usually "return" or "goto skip".
+ */
+#define XFAIL(statement, fmt, ...) do { \
+	if (TH_LOG_ENABLED) { \
+		fprintf(TH_LOG_STREAM, "[  XFAIL!  ] " fmt "\n", \
+			##__VA_ARGS__); \
+	} \
+	/* TODO: find a way to pass xfail to test runner process. */ \
+	_metadata->passed =3D 1; \
+	_metadata->trigger =3D 0; \
+	statement; \
+} while (0)
+
 /**
  * TEST(test_name) - Defines the test function and creates the registrat=
ion
  * stub
@@ -198,7 +219,7 @@
=20
 /**
  * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fix=
ture.
- * *_metadata* is included so that ASSERT_* work as a convenience
+ * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.=

  *
  * @fixture_name: fixture name
  *
@@ -221,6 +242,7 @@
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
 /**
  * FIXTURE_TEARDOWN(fixture_name)
+ * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.=

  *
  * @fixture_name: fixture name
  *
@@ -253,6 +275,8 @@
  * Defines a test that depends on a fixture (e.g., is part of a test cas=
e).
  * Very similar to TEST() except that *self* is the setup instance of fi=
xture's
  * datatype exposed for use by the implementation.
+ *
+ * Warning: use of ASSERT_* here will skip TEARDOWN.
  */
 /* TODO(wad) register fixtures on dedicated test lists. */
 #define TEST_F(fixture_name, test_name) \
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib=
=2Emk
index 7de482a0519d..195e9d4739a9 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,6 +20,7 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TES=
T_GEN_FILES)
=20
 .ONESHELL:
 define RUN_TESTS
+	@export KSFT_TAP_LEVEL=3D`echo 1`;
 	@test_num=3D`echo 0`;
 	@echo "TAP version 13";
 	@for TEST in $(1); do				\
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testin=
g/selftests/seccomp/seccomp_bpf.c
index 5df609950a66..168c66d74fc5 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2860,6 +2860,7 @@ TEST(get_metadata)
 	int pipefd[2];
 	char buf;
 	struct seccomp_metadata md;
+	long ret;
=20
 	ASSERT_EQ(0, pipe(pipefd));
=20
@@ -2893,16 +2894,26 @@ TEST(get_metadata)
 	ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid));
 	ASSERT_EQ(pid, waitpid(pid, NULL, 0));
=20
+	/* Past here must not use ASSERT or child process is never killed. */
+
 	md.filter_off =3D 0;
-	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(m=
d), &md));
+	errno =3D 0;
+	ret =3D ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md);
+	EXPECT_EQ(sizeof(md), ret) {
+		if (errno =3D=3D EINVAL)
+			XFAIL(goto skip, "Kernel does not support PTRACE_SECCOMP_GET_METADATA=
 (missing CONFIG_CHECKPOINT_RESTORE?)");
+	}
+
 	EXPECT_EQ(md.flags, SECCOMP_FILTER_FLAG_LOG);
 	EXPECT_EQ(md.filter_off, 0);
=20
 	md.filter_off =3D 1;
-	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(m=
d), &md));
+	ret =3D ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md);
+	EXPECT_EQ(sizeof(md), ret);
 	EXPECT_EQ(md.flags, 0);
 	EXPECT_EQ(md.filter_off, 1);
=20
+skip:
 	ASSERT_EQ(0, kill(pid, SIGKILL));
 }
=20

--------------29A3F05FDA5C1A83CDDF63F1--
