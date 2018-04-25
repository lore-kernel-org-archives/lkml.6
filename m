Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672621-2-3553449745424754183
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672620; b=F8y5JIitB7EeUQlWeVCNQT8HgjVfEjD/G1WnWHkaKw4NjPW/X3
    x1iIkVhynbXzVznHk+bXSHw2s8soEB/cSIyMpLxU0nCycbOI5dGZ+qEP5YJPCUoq
    wsy/PopyJYc0J3pPfHBdN5YpusG8SZg15olsO+ciJkBF6qLcLBOhlMb+gzj0kizR
    8uysdQQSgTH1sYUKVq9TVoeVczXSRH+FBllD2mv6nXrrbFYfYbhzpQgf42Uxb/tI
    cmh6Y3LbZumGrS6XdwggrY4NNRgDJQ1Vg+koLaRY1bL23wgUJoHypfOASO2F+4gU
    0pyyaVAJ85MarO+vv5BUF3NWqUrBcKiYxRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672620; bh=
    oKsufyZ2UO6NL1Vs0WtKb3gE1hEmwOj2FMCnxmDbh9Q=; b=VMfLWNB2561CSooH
    2CzC3d8zXoQaOiVr+9mJFo/2AF0gnF/6nLgBMNAeJgQ8DnOazar5tWrUvMc8uJ8u
    tAAvUe4LanFe8ZvCk010CTF7z+5QxWl4nx3A0JfXEzBO1WSnLvlZLtZO1rOSJhHM
    Na12IfUXk7y/BGK5ppr5FEBnOIuNmM6QKmNWkzpKLTPNdFCo4ccyK1ura5HraLVR
    qWPvPXhA29eT5C3y1ofh/h+Wu6RGUVz3PHWyMJuJISmZevoh40S3wWJt+odI9KWE
    Y929nxAH3MqsImavMNIBcKdamvJnuW5AWWsfJGWXK+rD2jsdeLIxsr+qs7Y2RWbL
    qcmteg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM7c7cE12MHcRMZBCEgWi0Frf7/WdBj9jsHZww73AlX6PimiaqlBgDqZ/6FRWt/5bsRXa3uiJYlMN6x008ffRWJMRyw7h9HL0sNJD8R8mkGYi4P+bGXX
    Nk15N6FjV5FowJKC9ULXwS73UoPuq35GmUXI6stFBzSbItQH9E8WVfGGasimz44Ex63G02b4La9ANutz4DkaxvwsKFW8HZr+TaLtFeX1WUnbl/lS2A630BHQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=0e_vniFX_kAm98O9vHwA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755689AbeDYQEf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:04:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755419AbeDYQE3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 01/17] y2038: compat: Move common compat types to asm-generic/compat.h
Date: Wed, 25 Apr 2018 18:02:55 +0200
Message-Id: <20180425160311.2718314-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:yP2l/nqXRaBsQgkatbQ9Jz63oLT3+DQJ7AZ4y6lGKXuAizZC5iW
 qvbKFBaW2Cf2nQC146mTpV8kFDiyR10xElY1zYMG08f7PvKkX66+Ocvyw2mHoyT+ru/z4l2
 IHwzY4E7aZEvgPbO+bu+FvMSSrSZ0H+j7/ddmE2Lfl5RfSzRficrdIqZ1SHTQ0x3uJqazOr
 zYSIqj3ferr0T/z+RxSpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UACJtUR9V4Q=:EnIhzzFfQjD6eQqmLrGNdX
 x5Vh3oUtQhtlj15Z0dKDca4cSANH3VgiRSBm08MRFfPnIhTXFNRvIkQjxkvzFvanT5cva2Axf
 EQozMQULxIwkA9xscgU3kFyavnoL5Xc4GfLBL5caPoyCZiHYNxPmXwcCRc8J7v6gYMZxmJsPB
 jlRtYa/m+sxKV4AF2ijBCiQoq11KcmQVbfSs9PMm8AJStVIjwWx8DG1QjtYuOoqEToQxRI84O
 6NCdGiXMOqCRZqpTFJWdCRKYlWdNA+rZwbjBzb7xgJXvbK75GaK4L7bc9Ib2menu635FPko5p
 W7Wmu7raisO2tkOUohgv0P6yiJmPlnWJVE+yHvWmv1t/Mz4qVZU2fvLXrRlOGbuqOe+ZJqcwR
 31JoUpXMWWvh9ieqkwDPjTcWLU0XutJhPRxlSTlpGCpPQdnBLNwNtAJ0xx1r1EW7BsvmT1XGT
 WNmehILa+g3urvlG23g+wGNJIC/3X6F95py28Qkyc5NEKvbnPbix5LC3aW1zXAE8O9qNPmOuC
 7HQ0J475iBe+6yx+YNKw/iy1eK9ogQqjAiN+hECc/j9f+MX10RX0bvsyFafjZimJPN9L+RBRB
 XyGy9QiV8Sl1UC+ZrISLGjIjYYaIkPfh9CfKudm4Wcls85ZsLpdzonF1YrC1E725NORt6QV5h
 fes8nUeS2S408ySEqcrhqCh+BJKkm0z636uhUbr47SKzv9UkJBozNpxyorcCvm8HsOKA=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The architectures that support 32-bit compat mode define a number
of simple types for use in compat handlers. About half of those
are identical between architectures, and some of those are also
required now by handlers shared with CONFIG_COMPAT_32BIT_TIME
functions on 32-bit architectures.

Let's move all the identical ones into asm-generic/compat.h to avoid
having to add even more identical definitions of those types.

For unknown reasons, mips defines __compat_gid32_t, __compat_uid32_t
and compat_caddr_t as signed, while all others have them unsigned.
This seems to be a mistake, but I'm leaving it alone here. The other
types all differ by size or alignment on at least on architecture.

compat_aio_context_t is currently defined in linux/compat.h but
also needed for compat_sys_io_getevents(), so let's move it into
the same place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h   | 20 ++------------------
 arch/mips/include/asm/compat.h    | 22 ++--------------------
 arch/parisc/include/asm/compat.h  | 18 ++----------------
 arch/powerpc/include/asm/compat.h | 18 ++----------------
 arch/s390/include/asm/compat.h    | 18 ++----------------
 arch/sparc/include/asm/compat.h   | 19 ++-----------------
 arch/x86/include/asm/compat.h     | 19 ++-----------------
 include/asm-generic/compat.h      | 24 +++++++++++++++++++++++-
 include/linux/compat.h            |  2 --
 9 files changed, 37 insertions(+), 123 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 1a037b94eba1..a4c79f9e856d 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -25,6 +25,8 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #ifdef __AARCH64EB__
 #define COMPAT_UTS_MACHINE	"armv8b\0\0"
@@ -32,10 +34,6 @@
 #define COMPAT_UTS_MACHINE	"armv8l\0\0"
 #endif
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u16		__compat_uid16_t;
@@ -43,27 +41,13 @@ typedef u16		__compat_gid16_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef s32		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s16		compat_short_t;
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u16		compat_ushort_t;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 #ifdef __AARCH64EB__
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 78675f19440f..7033a7c93b48 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -9,43 +9,25 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"mips\0\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_suseconds_t;
-
-typedef s32		compat_pid_t;
 typedef s32		__compat_uid_t;
 typedef s32		__compat_gid_t;
 typedef __compat_uid_t	__compat_uid32_t;
 typedef __compat_gid_t	__compat_gid32_t;
 typedef u32		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef u32		compat_nlink_t;
 typedef s32		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef s32		compat_caddr_t;
 typedef struct {
 	s32	val[2];
 } compat_fsid_t;
-typedef s32		compat_timer_t;
-typedef s32		compat_key_t;
-
-typedef s16		compat_short_t;
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u16		compat_ushort_t;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index ab8a54771507..f707e025f89b 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -8,36 +8,22 @@
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ 		100
 #define COMPAT_UTS_MACHINE	"parisc\0\0"
 
-typedef u32	compat_size_t;
-typedef s32	compat_ssize_t;
-typedef s32	compat_clock_t;
-typedef s32	compat_pid_t;
 typedef u32	__compat_uid_t;
 typedef u32	__compat_gid_t;
 typedef u32	__compat_uid32_t;
 typedef u32	__compat_gid32_t;
 typedef u16	compat_mode_t;
-typedef u32	compat_ino_t;
 typedef u32	compat_dev_t;
-typedef s32	compat_off_t;
-typedef s64	compat_loff_t;
 typedef u16	compat_nlink_t;
 typedef u16	compat_ipc_pid_t;
-typedef s32	compat_daddr_t;
 typedef u32	compat_caddr_t;
-typedef s32	compat_key_t;
-typedef s32	compat_timer_t;
-
-typedef s32	compat_int_t;
-typedef s32	compat_long_t;
 typedef s64	compat_s64;
-typedef u32	compat_uint_t;
-typedef u32	compat_ulong_t;
 typedef u64	compat_u64;
-typedef u32	compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t		st_dev;	/* dev_t is 32 bits on parisc */
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 85c8af2bb272..036b210b1582 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -8,6 +8,8 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #ifdef __BIG_ENDIAN__
 #define COMPAT_UTS_MACHINE	"ppc\0\0"
@@ -15,34 +17,18 @@
 #define COMPAT_UTS_MACHINE	"ppcle\0\0"
 #endif
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u32		__compat_uid_t;
 typedef u32		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u32		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef s16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 97db2fba546a..63b46e30b2c3 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -9,6 +9,8 @@
 #include <linux/sched/task_stack.h>
 #include <linux/thread_info.h>
 
+#include <asm-generic/compat.h>
+
 #define __TYPE_IS_PTR(t) (!__builtin_types_compatible_p( \
 				typeof(0?(__force t)0:0ULL), u64))
 
@@ -51,34 +53,18 @@
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"s390\0\0\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef u16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 typedef struct {
 	u32 mask;
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 4eb51d2dae98..985286b79891 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -6,38 +6,23 @@
  */
 #include <linux/types.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"sparc\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef s16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	compat_ino_t	st_ino;
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index fb97cf7c4137..0ce6f452d334 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -12,38 +12,23 @@
 #include <asm/user32.h>
 #include <asm/unistd.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"i686\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef u16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_timer_t;
-typedef s32		compat_key_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64 __attribute__((aligned(4))) compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
-typedef u32		compat_u32;
 typedef u64 __attribute__((aligned(4))) compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/include/asm-generic/compat.h b/include/asm-generic/compat.h
index 28819451b6d1..a86f65bffab8 100644
--- a/include/asm-generic/compat.h
+++ b/include/asm-generic/compat.h
@@ -1,3 +1,25 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_COMPAT_H
+#define __ASM_GENERIC_COMPAT_H
 
-/* This is an empty stub for 32-bit-only architectures */
+/* These types are common across all compat ABIs */
+typedef u32 compat_size_t;
+typedef s32 compat_ssize_t;
+typedef s32 compat_clock_t;
+typedef s32 compat_pid_t;
+typedef u32 compat_ino_t;
+typedef s32 compat_off_t;
+typedef s64 compat_loff_t;
+typedef s32 compat_daddr_t;
+typedef s32 compat_timer_t;
+typedef s32 compat_key_t;
+typedef s16 compat_short_t;
+typedef s32 compat_int_t;
+typedef s32 compat_long_t;
+typedef u16 compat_ushort_t;
+typedef u32 compat_uint_t;
+typedef u32 compat_ulong_t;
+typedef u32 compat_uptr_t;
+typedef u32 compat_aio_context_t;
+
+#endif
diff --git a/include/linux/compat.h b/include/linux/compat.h
index cfc1b6383ae0..af5ac9de4bdf 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -104,8 +104,6 @@ typedef struct compat_sigaltstack {
 typedef __compat_uid32_t	compat_uid_t;
 typedef __compat_gid32_t	compat_gid_t;
 
-typedef	compat_ulong_t		compat_aio_context_t;
-
 struct compat_sel_arg_struct;
 struct rusage;
 
-- 
2.9.0

