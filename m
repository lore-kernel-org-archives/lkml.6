Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F3DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CB3218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548959766;
	bh=isgiWhB8MNjCfR14ohTl+Owth4IRPNmMPiUi++LYKPk=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=jAEA5tJgjb1ROOC5D1VWuzrMo148g67YMvTn6QQVM4Ad75umr+y9YUm11kf5awEz9
	 84TrxA4HSMygjEnfv6HNFsrWvf+N5QNo9Ys5JaTHF752ASvK2S8a+gadgnGwdXvQk4
	 mzbpnjv01qbZF0FgIyzLfpicoCESgfe0Wey7HlkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAaSgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:36:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfAaSgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:36:04 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C9ED218AC;
        Thu, 31 Jan 2019 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548959763;
        bh=isgiWhB8MNjCfR14ohTl+Owth4IRPNmMPiUi++LYKPk=;
        h=To:Cc:From:Subject:Date:From;
        b=Z0scIFfuQJW5DYFI5IEErmOoJ+Km8dJqkSob/W9NYjXqCStJ5gjqzqrrfF/YOgw85
         hDVGn7xdRYEOM37hlEStRdfCa6laUCb3exIEgKmEYXgno2idwTEq0twirmW4Gyh4aE
         kdzBkRbOp4K0hLFDkAEVGDFKcwbEyvs+7Ys0UEb8=
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   shuah <shuah@kernel.org>
Subject: [GIT PULL] Kselftest update for Linux 5.0-rc5
Message-ID: <861aa0ec-3f5e-27aa-8cfb-d7f2d3fdb24b@kernel.org>
Date:   Thu, 31 Jan 2019 11:35:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B9873EC54F9BF8AD6B10B3AC"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B9873EC54F9BF8AD6B10B3AC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest updated for Linux 5.0-rc5

This Kselftest update for Linux 5.0-rc5 consists of run-time fixes to
cpu-hotplug, and seccomp tests, compile fixes to ir, net, and timers
Makefiles.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3d244c192afeee7dd4f5fb1b916ea4e47420d401:

   selftests/seccomp: Abort without user notification support 
(2019-01-17 11:00:23 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.0-rc5

for you to fetch changes up to 7d4e591bc051d3382c45caaa2530969fb42ed23d:

   selftests: timers: use LDLIBS instead of LDFLAGS (2019-01-28 08:02:12 
-0700)

----------------------------------------------------------------
linux-kselftest-5.0-rc5

This Kselftest update for Linux 5.0-rc5 consists of run-time fixes to
cpu-hotplug, and seccomp tests, compile fixes to ir, net, and timers
Makefiles.

----------------------------------------------------------------
Colin Ian King (1):
       selftests: cpu-hotplug: fix case where CPUs offline > CPUs present

Fathi Boudra (2):
       selftests: net: use LDLIBS instead of LDFLAGS
       selftests: timers: use LDLIBS instead of LDFLAGS

Kees Cook (1):
       selftests/seccomp: Enhance per-arch ptrace syscall skip tests

Sean Young (1):
       selftests: Use lirc.h from kernel tree, not from system

  .../selftests/cpu-hotplug/cpu-on-off-test.sh       | 13 +++-
  tools/testing/selftests/ir/Makefile                |  2 +
  tools/testing/selftests/net/Makefile               |  2 +-
  tools/testing/selftests/seccomp/seccomp_bpf.c      | 72 
+++++++++++++++++-----
  tools/testing/selftests/timers/Makefile            |  2 +-
  5 files changed, 71 insertions(+), 20 deletions(-)

----------------------------------------------------------------

--------------B9873EC54F9BF8AD6B10B3AC
Content-Type: text/x-patch;
 name="linux-kselftest-5.0-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.0-rc5.diff"

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index bab13dd025a6..0d26b5e3f966 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -37,6 +37,10 @@ prerequisite()
 		exit $ksft_skip
 	fi
 
+	present_cpus=`cat $SYSFS/devices/system/cpu/present`
+	present_max=${present_cpus##*-}
+	echo "present_cpus = $present_cpus present_max = $present_max"
+
 	echo -e "\t Cpus in online state: $online_cpus"
 
 	offline_cpus=`cat $SYSFS/devices/system/cpu/offline`
@@ -151,6 +155,8 @@ online_cpus=0
 online_max=0
 offline_cpus=0
 offline_max=0
+present_cpus=0
+present_max=0
 
 while getopts e:ahp: opt; do
 	case $opt in
@@ -190,9 +196,10 @@ if [ $allcpus -eq 0 ]; then
 	online_cpu_expect_success $online_max
 
 	if [[ $offline_cpus -gt 0 ]]; then
-		echo -e "\t offline to online to offline: cpu $offline_max"
-		online_cpu_expect_success $offline_max
-		offline_cpu_expect_success $offline_max
+		echo -e "\t offline to online to offline: cpu $present_max"
+		online_cpu_expect_success $present_max
+		offline_cpu_expect_success $present_max
+		online_cpu $present_max
 	fi
 	exit 0
 else
diff --git a/tools/testing/selftests/ir/Makefile b/tools/testing/selftests/ir/Makefile
index f4ba8eb84b95..ad06489c22a5 100644
--- a/tools/testing/selftests/ir/Makefile
+++ b/tools/testing/selftests/ir/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_PROGS := ir_loopback.sh
 TEST_GEN_PROGS_EXTENDED := ir_loopback
+APIDIR := ../../../include/uapi
+CFLAGS += -Wall -O2 -I$(APIDIR)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index f8f3e90700c0..1e6d14d2825c 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -21,6 +21,6 @@ TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
-$(OUTPUT)/reuseport_bpf_numa: LDFLAGS += -lnuma
+$(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDFLAGS += -lpthread
 $(OUTPUT)/tcp_inq: LDFLAGS += -lpthread
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 496a9a8c773a..7e632b465ab4 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1608,7 +1608,16 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 #ifdef SYSCALL_NUM_RET_SHARE_REG
 # define EXPECT_SYSCALL_RETURN(val, action)	EXPECT_EQ(-1, action)
 #else
-# define EXPECT_SYSCALL_RETURN(val, action)	EXPECT_EQ(val, action)
+# define EXPECT_SYSCALL_RETURN(val, action)		\
+	do {						\
+		errno = 0;				\
+		if (val < 0) {				\
+			EXPECT_EQ(-1, action);		\
+			EXPECT_EQ(-(val), errno);	\
+		} else {				\
+			EXPECT_EQ(val, action);		\
+		}					\
+	} while (0)
 #endif
 
 /* Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
@@ -1647,7 +1656,7 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 
 /* Architecture-specific syscall changing routine. */
 void change_syscall(struct __test_metadata *_metadata,
-		    pid_t tracee, int syscall)
+		    pid_t tracee, int syscall, int result)
 {
 	int ret;
 	ARCH_REGS regs;
@@ -1706,7 +1715,7 @@ void change_syscall(struct __test_metadata *_metadata,
 #ifdef SYSCALL_NUM_RET_SHARE_REG
 		TH_LOG("Can't modify syscall return on this architecture");
 #else
-		regs.SYSCALL_RET = EPERM;
+		regs.SYSCALL_RET = result;
 #endif
 
 #ifdef HAVE_GETREGS
@@ -1734,14 +1743,19 @@ void tracer_syscall(struct __test_metadata *_metadata, pid_t tracee,
 	case 0x1002:
 		/* change getpid to getppid. */
 		EXPECT_EQ(__NR_getpid, get_syscall(_metadata, tracee));
-		change_syscall(_metadata, tracee, __NR_getppid);
+		change_syscall(_metadata, tracee, __NR_getppid, 0);
 		break;
 	case 0x1003:
-		/* skip gettid. */
+		/* skip gettid with valid return code. */
 		EXPECT_EQ(__NR_gettid, get_syscall(_metadata, tracee));
-		change_syscall(_metadata, tracee, -1);
+		change_syscall(_metadata, tracee, -1, 45000);
 		break;
 	case 0x1004:
+		/* skip openat with error. */
+		EXPECT_EQ(__NR_openat, get_syscall(_metadata, tracee));
+		change_syscall(_metadata, tracee, -1, -ESRCH);
+		break;
+	case 0x1005:
 		/* do nothing (allow getppid) */
 		EXPECT_EQ(__NR_getppid, get_syscall(_metadata, tracee));
 		break;
@@ -1774,9 +1788,11 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	nr = get_syscall(_metadata, tracee);
 
 	if (nr == __NR_getpid)
-		change_syscall(_metadata, tracee, __NR_getppid);
+		change_syscall(_metadata, tracee, __NR_getppid, 0);
+	if (nr == __NR_gettid)
+		change_syscall(_metadata, tracee, -1, 45000);
 	if (nr == __NR_openat)
-		change_syscall(_metadata, tracee, -1);
+		change_syscall(_metadata, tracee, -1, -ESRCH);
 }
 
 FIXTURE_DATA(TRACE_syscall) {
@@ -1793,8 +1809,10 @@ FIXTURE_SETUP(TRACE_syscall)
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1002),
 		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_gettid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1003),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_openat, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1004),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1005),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
 
@@ -1842,15 +1860,26 @@ TEST_F(TRACE_syscall, ptrace_syscall_redirected)
 	EXPECT_NE(self->mypid, syscall(__NR_getpid));
 }
 
-TEST_F(TRACE_syscall, ptrace_syscall_dropped)
+TEST_F(TRACE_syscall, ptrace_syscall_errno)
+{
+	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
+	teardown_trace_fixture(_metadata, self->tracer);
+	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
+					   true);
+
+	/* Tracer should skip the open syscall, resulting in ESRCH. */
+	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
+}
+
+TEST_F(TRACE_syscall, ptrace_syscall_faked)
 {
 	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
 	teardown_trace_fixture(_metadata, self->tracer);
 	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
 					   true);
 
-	/* Tracer should skip the open syscall, resulting in EPERM. */
-	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_openat));
+	/* Tracer should skip the gettid syscall, resulting fake pid. */
+	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
 }
 
 TEST_F(TRACE_syscall, syscall_allowed)
@@ -1883,7 +1912,21 @@ TEST_F(TRACE_syscall, syscall_redirected)
 	EXPECT_NE(self->mypid, syscall(__NR_getpid));
 }
 
-TEST_F(TRACE_syscall, syscall_dropped)
+TEST_F(TRACE_syscall, syscall_errno)
+{
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* openat has been skipped and an errno return. */
+	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
+}
+
+TEST_F(TRACE_syscall, syscall_faked)
 {
 	long ret;
 
@@ -1894,8 +1937,7 @@ TEST_F(TRACE_syscall, syscall_dropped)
 	ASSERT_EQ(0, ret);
 
 	/* gettid has been skipped and an altered return value stored. */
-	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_gettid));
-	EXPECT_NE(self->mytid, syscall(__NR_gettid));
+	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
 }
 
 TEST_F(TRACE_syscall, skip_after_RET_TRACE)
diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index c02683cfb6c9..7656c7ce79d9 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -O3 -Wl,-no-as-needed -Wall
-LDFLAGS += -lrt -lpthread -lm
+LDLIBS += -lrt -lpthread -lm
 
 # these are all "safe" tests that don't modify
 # system time or require escalated privileges

--------------B9873EC54F9BF8AD6B10B3AC--
