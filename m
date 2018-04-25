Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524672386-2-14913937390932783155
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
    1524672385; b=SO1aDsDEOSqZoTaAaMTqt7fP+qjo1jAw4lYdRsDs+i3g7WJuqY
    x8NhtNbvI6pUWmIiKmsjON2txTWBDC7HFOtJHxZGBV1koS/2xxgCTan+aOP16+UZ
    30QfNOlUGS4Wejr7S4oWZdum4Tajb/22LWjkJ6BWUdMzTBB8awpqHjB3imZxuM4U
    4dPjKHGIYDAvjpzz9OIM5DhuBcwgGVzcaQ8SLRmSEGjz3QVuXBfS4CJHvMAa/Xmt
    aVPtvVVH7f9THEYLKgmJTGudoaaoKL52u8NUtY+x7yBPkINa1G9DmytXj4iIf2Z7
    m898WnlMG2HrqUrRN6EE6BSyv6OE7P+e1syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672385; bh=
    2Q57ldkjNOc0Q1rfqHuoAoyC6JXkAS+QETNOSwtkwqY=; b=Ha+H//Y6gcaS7Tgx
    6SUhJ3qZvHTAKOc3a1drK9CMlE+cFPW+JNFx/5J7oW5t22X9YsXlREmQ23bVpT4U
    V2aEn3U79woNEUKoQfxui0GuBmbovYS7tacMz1vSqSqdVSBU9nQ+KZ+QL3f/Ym0Y
    M6ZFoRMlQ6s2M661FI9hc5KtSvlUy9bR1VvtPaoFmsIVkISllinU7jpB0edlWJhV
    lwvacFnJB/uVJkzr0zfOzo/S6odWzCRKXEjk/s6IBK4O1qKu/9fhsoKwhRcasJ8x
    OGuXxZC6JDULd6hokgxA7rnxkP4ICqz9mDWlQ4Gu1+Exvr4VyBbWiaIFtHLaHHZm
    DFa60Q==
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
X-CM-Envelope: MS4wfODsKtgHJhLEfUDRNjFA4BLMG6Fmjft5qcbO2SJLoeDeng0PV2qjcYfRLQbqRab1wnd9LEts84vx4vWtAuykDuODjL574GPYeMFOu/z7uq+GNHNHnd/F
    Z8Gpie76UuSkVt42AKXG3Hsam6phyl70j2rPBbe3UAJnIOErCKEL1tv9D/yjtRjRuiv990PFu68aAzzG/iDCQ2wN6kh2269IED9LCao9HOcs/tzDD/TG+BN+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=szLHZxkmSTWnj0w81BcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755254AbeDYQGE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:06:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33823 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755896AbeDYQFc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:05:32 -0400
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
Subject: [PATCH 02/17] y2038: Remove newstat family from default syscall set
Date: Wed, 25 Apr 2018 18:02:56 +0200
Message-Id: <20180425160311.2718314-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:pE1auycWNgZO/hfgRwIFxalukRSvFB3Cd6mBErg/NYXaNNYHjNb
 E1iw4heT9O4W9kShExjHVfzyTfJIj7lQ+RaPZuLfhnCr+xHsxYatExnkF35bJaUnlq62Lgq
 V7IP6qdHEVqbyKlfkQeUpY/K41xk/Gtia6f5K/VJjV0gR27tzRs1n8W6M3cwobXPk2JZrj+
 3xLUAVo6SHjyhG1PpH+Tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6BNbiC0a7NM=:fvuDX7pMuViaUVDw+V4FMl
 Eq+VYQMrnQ+OM7CS67AJ1vd58YvBWR0S9QfwiJzSJ/zuCjChuOyT2HPESB3ilXiLoEopGxUaN
 6IHC26d8L+YTZgHqXEvq2GAySgFzSUPFY+fh0NqJVin2YkmIsLzXOkwBUOGLFATpMHZNmSUBG
 2RWw425GpzcWmuIBgFSDHPtmT6hhgrFfJumEqCOtmlS076B68EJilqsMMT+u0JuD58xGscrHx
 LBrtK23ZvGfvhvb2agg5hLRZ1qvUp2VW7OIjY3PVWcel6T4OOs/KTEeBikl0BmIGYzumvF9kQ
 ltI/KxHeG9/ZJKUnyWOIl5HBSGYAfWhO6eJT4AA8Gy2fE95NXdByAH8FemOZhQC8qsCjnANl3
 7SjociEzHhct5dyj0mDjekeXwt/lpZeXDFd8xMPtEpszYzeYTKQo8OECtYcyZ95CMk71cdwio
 Q/EV5U0J/xCjyn3dqjB3tiZJTYyAF0u8oMLCv9TCp3DNGKksfSHQWyTqtPHpYxt92IG5qJAIR
 HruLWmRC5x2DVf7Qq7NJ7JfZSCDkpi1qIN4JE+APHVClVY02+LG01jiM1D6r93afqfnQAug8z
 SKHj1ltkhHjMI8v3eHBXrZgsLPQ/p5EnocYY79Beid7vYKJBuX/qt6hKVJ6P87WbQrVCv9oRW
 NI9OguCqQpPnY/2z3YR9WoND+4cfuMvQsXSMZ1l3bZdZbNj5sCQ8sXwTFVOryJk4shks=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We have four generations of stat() syscalls:
- the oldstat syscalls that are only used on the older architectures
- the newstat family that is used on all 64-bit architectures but
  lacked support for large files on 32-bit architectures.
- the stat64 family that is used mostly on 32-bit architectures to
  replace newstat
- statx() to replace all of the above, adding 64-bit timestamps among
  other things.

We already compile stat64 only on those architectures that need it,
but newstat is always built, including on those that don't reference
it. This adds a new __ARCH_WANT_NEW_STAT symbol along the lines of
__ARCH_WANT_OLD_STAT and __ARCH_WANT_STAT64 to control compilation of
newstat. All architectures that need it use an explict define, the
others now get a little bit smaller, and future architecture (including
64-bit targets) won't ever see it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h      | 1 +
 arch/arm/include/asm/unistd.h        | 1 +
 arch/arm64/include/uapi/asm/unistd.h | 1 +
 arch/ia64/include/asm/unistd.h       | 2 ++
 arch/m68k/include/asm/unistd.h       | 1 +
 arch/microblaze/include/asm/unistd.h | 1 +
 arch/mips/include/asm/unistd.h       | 1 +
 arch/parisc/include/asm/unistd.h     | 1 +
 arch/powerpc/include/asm/unistd.h    | 1 +
 arch/s390/include/asm/unistd.h       | 1 +
 arch/sh/include/asm/unistd.h         | 1 +
 arch/sparc/include/asm/unistd.h      | 1 +
 arch/x86/include/asm/unistd.h        | 1 +
 arch/xtensa/include/asm/unistd.h     | 1 +
 fs/stat.c                            | 3 +++
 15 files changed, 18 insertions(+)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index d6e29a1de4cc..edc090470023 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -6,6 +6,7 @@
 
 #define NR_SYSCALLS			523
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 076090d2dbf5..07e58010d597 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -16,6 +16,7 @@
 #include <uapi/asm/unistd.h>
 #include <asm/unistd-nr.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 5072cbd15c82..dae1584cf017 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -16,5 +16,6 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
 
 #include <asm-generic/unistd.h>
diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index ffb705dc9c13..c5b2620c4a4c 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -28,6 +28,8 @@
 #define __IGNORE_vfork		/* clone() */
 #define __IGNORE_umount2	/* umount() */
 
+#define __ARCH_WANT_NEW_STAT
+
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
 #include <linux/types.h>
diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 30d0d3fbd4ef..db22cdadc38a 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -7,6 +7,7 @@
 
 #define NR_syscalls		380
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
 #define __ARCH_WANT_STAT64
diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index 9774e1d9507b..62ee12c247c1 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -15,6 +15,7 @@
 
 /* #define __ARCH_WANT_OLD_READDIR */
 /* #define __ARCH_WANT_OLD_STAT */
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 3c09450908aa..d7878b3e16d8 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -24,6 +24,7 @@
 
 #ifndef __ASSEMBLY__
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 3d507d04eb4c..b36273bacca7 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -141,6 +141,7 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
     return K_INLINE_SYSCALL(name, 5, arg1, arg2, arg3, arg4, arg5);	\
 }
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index daf1ba97a00c..d78c1f49272d 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -22,6 +22,7 @@
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index fd79c0d35dc4..1d181373288a 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -15,6 +15,7 @@
 #define __IGNORE_pkey_alloc
 #define __IGNORE_pkey_free
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/sh/include/asm/unistd.h b/arch/sh/include/asm/unistd.h
index b36200af9ce7..a845b57eac69 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -5,6 +5,7 @@
 #  include <asm/unistd_64.h>
 # endif
 
+# define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
 # define __ARCH_WANT_OLD_STAT
 # define __ARCH_WANT_STAT64
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index b2a6a955113e..3544244685e1 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -21,6 +21,7 @@
 #else
 #define __NR_time		231 /* Linux sparc32                               */
 #endif
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 51c4eee00732..35b66bbf8028 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -31,6 +31,7 @@
 
 # endif
 
+# define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
 # define __ARCH_WANT_OLD_STAT
 # define __ARCH_WANT_SYS_ALARM
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index ed66db3bc9bb..0d532ab60b37 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -5,6 +5,7 @@
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_LLSEEK
diff --git a/fs/stat.c b/fs/stat.c
index f8e6fb2c3657..adbfcd86c81b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -280,6 +280,8 @@ SYSCALL_DEFINE2(fstat, unsigned int, fd, struct __old_kernel_stat __user *, stat
 
 #endif /* __ARCH_WANT_OLD_STAT */
 
+#ifdef __ARCH_WANT_NEW_STAT
+
 #if BITS_PER_LONG == 32
 #  define choose_32_64(a,b) a
 #else
@@ -378,6 +380,7 @@ SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user *, statbuf)
 
 	return error;
 }
+#endif
 
 static int do_readlinkat(int dfd, const char __user *pathname,
 			 char __user *buf, int bufsiz)
-- 
2.9.0

