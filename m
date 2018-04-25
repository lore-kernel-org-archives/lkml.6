Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672465-2-17792814737413174227
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672465; b=PiO+jg6OmgM97VXAASwyBzLPHyPCMiMIz7RR7vcpFtM+7+Naq0
    UJnYZNJyU+iWHP/vuPLeybijSjUDs2iIve97K+bUgCr1gTD453arbxWhigeF2uys
    hP9cDncg5S7gbualCYJYoz6EktI0c3sLf4DjgEE8UFWHDQFJzGof5y820zcf5VVH
    /nNRd+donhXDJmTaIBWlIeDeymX5U2F9lDmCUy6tunJG7rl/KpOfvhphd9CrreTt
    Eon/sOWnVtL2imWHgbrlGaO0hWEhsBMR+1gxpeHPt7FSyIXyJdi2dnaFPvrIB4Ll
    DvcYdeKxMThvz/ecEivUq+9hbf5lj650L79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672465; bh=
    DKX22p/xq1AJH/aHQNTMki9Bs4a4dpu6ATQ+3pOGd+Y=; b=uOJC6My+wUaMznip
    pv+oyzYUSs0bq/hY150mc3LpNBunKXUQDFKNgJ3bZovl7VwpZqXOGRXxHfvC+HUv
    1fG2ouo41AVmcHz/iasXBs1ZqH3mZS9B3AcbEiTHt9WXVJsys189jdThWQ++4+yo
    bbpeKI/n0o3Xjm9hI5n+FlUqT0kayuSyz6PzPYcuaGux6MsacXSIvKbvTjfSjAM0
    BVD6bVBgFtyCV4XedlzipeMQQH3BnSQ9AUOi8u7oXiF2jaPMeG7E4p0Z55coDa3w
    keQX6+JL3F3mh7lMZVgu0fOdBKpEiYP7LZMRh459+Qzp8ONuyVXyL3hFRZbQWZYs
    zaO/og==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfEXiFGfuWUicws60wMVfBQwE07AgSgQCuI6Mpsp29JZzpgIvmEITFmyYVVEnY3ptuo+cs3vOuTwhr2jYl39sPT5oH6OQKccO3XItPFPPIPasjeZ7WbmI
    9l2JZiiU5f4BEC9aBuZxTy00xn6a/TfhBVa1VQmo6/HnSufSVl+zKNFFK1WEjccY9UMQIValXzgr8JUspwRKk1slTJQkx/OYa8ymC7cF4dfkJ3TKe5wkNA6k
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=mZuVqEJOQ2No_fD5cDYA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeDYQFY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:05:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755481AbeDYQFS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:05:18 -0400
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
Subject: [PATCH 08/17] y2038: utimes: Rework #ifdef guards for compat syscalls
Date: Wed, 25 Apr 2018 18:03:02 +0200
Message-Id: <20180425160311.2718314-9-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:RkQBWFxmMSs6VhgZEHLwj+HPL4sVgGt9m/xkAZ1w0zrusKH3Uk3
 BOYhrGkdUUwM/L6sWsUnYp0fPvsIHiHQVt8iWJ/bPu8wzr0S6CvDDCbriINnRzGzWSKc9K2
 l6CHv2ENpMhvPRqXa9rowcMRt7Ra/iT0OTYmGcfWwaqXfoPr09dyDbGe51q7W0n+oYX/mCK
 Pew0v4bi0nAr7xLV7qyqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FKjEMXyuwUA=:4Yo7CWjwpsdP4U4/Wvjo1Y
 3Bt6qyClcOaNxI3NDauQzk1S8gy96AoZXz98qQI69YXT9Hv6PBRcf45d7PCmFwtTJjjHdNrWG
 2r6V+Jx9Dyxe3T8GqnWUaZPuEU5IlsVIBoOh+S/TPtaT2ckkpVsaHiLDD+6RClyPMBeb8uS1u
 yA4rXILz1cy0t8nxTUvr3L45adjFcytw4arT7HaqYi//8UmIn1bMxUUwSeCtHan6zzwlWjx17
 +4UH0nFi1r436x9Xxstpm62bh6NIQde5se8eM/YGUhc7hx0Bejwuoj9r75Wjb/ySvi7m9VPZN
 PUpSaem9sEUzKIHgfxfxR5ojZvdmQSrdYqXd8QvlRf+B20+f8NeRaalx1pqPpd+QuKfoxcqRD
 IW+eRs32gsQk/wLXiNryEtIbNZ/BG4jbQu89S/M3aEbc1GJAwVTXV7FKKW4PayXO6kilifuRc
 TNc1Kwzkm54wHHsM4CLPvvx+jsdOyYVRdprjfD0hNjOvDPfia6cDSWX1IaJRvlNopqqoNo/rb
 s46p/jAkf/O7kwjyzhVcbhooypdDM3kryK2Y00nVFAhaqA+SkEGjiqFAZeEDS9AGz8GCEswlY
 dGOOMu5XO9VADMG5aLCE036+Z2BHX9NkFjXdLwOfHhogGpLNFw9b9465b6wG+HpQj+csyb/71
 l/73JJjQyYne40nf8VMHjnO0fVmqfAU+Yc3MnZaDsPU1NZA8OsX3XglwuWSS0fLd02Sw=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After changing over to 64-bit time_t syscalls, many architectures will
want compat_sys_utimensat() but not respective handlers for utime(),
utimes() and futimesat(). This adds a new __ARCH_WANT_COMPAT_SYS_UTIME
to complement __ARCH_WANT_SYS_UTIME. For now, all 64-bit architectures
that support CONFIG_COMPAT set it, but future 64-bit architectures will
not (tile would not have needed it either, but got removed).

As older 32-bit architectures get converted to using CONFIG_64BIT_TIME,
they will have to use __ARCH_WANT_COMPAT_SYS_UTIME instead of
__ARCH_WANT_SYS_UTIME. Architectures using the generic syscall ABI
don't need either of them.

Since the compat_utimbuf structure is now required outside of
CONFIG_COMPAT, I'm moving it into compat_time.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/unistd.h   | 1 +
 arch/mips/include/asm/unistd.h    | 1 +
 arch/parisc/include/asm/unistd.h  | 1 +
 arch/powerpc/include/asm/unistd.h | 1 +
 arch/s390/include/asm/unistd.h    | 1 +
 arch/sparc/include/asm/unistd.h   | 1 +
 arch/x86/include/asm/unistd.h     | 1 +
 fs/utimes.c                       | 6 +++++-
 include/linux/compat.h            | 5 -----
 include/linux/compat_time.h       | 5 +++++
 10 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 5c3c1398c62e..c4df478039f3 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -22,6 +22,7 @@
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_COMPAT_SYS_UTIME
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c2174b80e50e..f47058485f7f 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -31,6 +31,7 @@
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_COMPAT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_GETPGRP
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index a0c38374fff0..62ffafda0d50 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -152,6 +152,7 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_SCHED_RR_GET_INTERVAL
 #define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_COMPAT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index fb8fb304ceaf..3190c86e03ba 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -47,6 +47,7 @@
 #endif
 #ifdef CONFIG_PPC64
 #define __ARCH_WANT_COMPAT_SYS_TIME
+#define __ARCH_WANT_COMPAT_SYS_UTIME
 #define __ARCH_WANT_SYS_NEWFSTATAT
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index a2d583ea526d..b4ba7781d396 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -34,6 +34,7 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 # ifdef CONFIG_COMPAT
 #   define __ARCH_WANT_COMPAT_SYS_TIME
+#   define __ARCH_WANT_COMPAT_SYS_UTIME
 # endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index f7514d3eae7b..610f6a8a14de 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -42,6 +42,7 @@
 #define __ARCH_WANT_SYS_IPC
 #else
 #define __ARCH_WANT_COMPAT_SYS_TIME
+#define __ARCH_WANT_COMPAT_SYS_UTIME
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 153d2a5e6b02..7d784b8bceb4 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -24,6 +24,7 @@
 #  include <asm/unistd_64.h>
 #  include <asm/unistd_64_x32.h>
 #  define __ARCH_WANT_COMPAT_SYS_TIME
+#  define __ARCH_WANT_COMPAT_SYS_UTIME
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
diff --git a/fs/utimes.c b/fs/utimes.c
index ebc7fb713d91..6318443de15d 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -218,11 +218,12 @@ SYSCALL_DEFINE2(utime, char __user *, filename, struct utimbuf __user *, times)
 }
 #endif
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 /*
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
  */
+#ifdef __ARCH_WANT_COMPAT_SYS_UTIME
 COMPAT_SYSCALL_DEFINE2(utime, const char __user *, filename,
 		       struct compat_utimbuf __user *, t)
 {
@@ -237,6 +238,7 @@ COMPAT_SYSCALL_DEFINE2(utime, const char __user *, filename,
 	}
 	return do_utimes(AT_FDCWD, filename, t ? tv : NULL, 0);
 }
+#endif
 
 COMPAT_SYSCALL_DEFINE4(utimensat, unsigned int, dfd, const char __user *, filename, struct compat_timespec __user *, t, int, flags)
 {
@@ -253,6 +255,7 @@ COMPAT_SYSCALL_DEFINE4(utimensat, unsigned int, dfd, const char __user *, filena
 	return do_utimes(dfd, filename, t ? tv : NULL, flags);
 }
 
+#ifdef __ARCH_WANT_COMPAT_SYS_UTIME
 static long do_compat_futimesat(unsigned int dfd, const char __user *filename,
 				struct compat_timeval __user *t)
 {
@@ -285,3 +288,4 @@ COMPAT_SYSCALL_DEFINE2(utimes, const char __user *, filename, struct compat_time
 	return do_compat_futimesat(AT_FDCWD, filename, t);
 }
 #endif
+#endif
diff --git a/include/linux/compat.h b/include/linux/compat.h
index af5ac9de4bdf..7887b0a54c1e 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -112,11 +112,6 @@ struct compat_itimerspec {
 	struct compat_timespec it_value;
 };
 
-struct compat_utimbuf {
-	compat_time_t		actime;
-	compat_time_t		modtime;
-};
-
 struct compat_itimerval {
 	struct compat_timeval	it_interval;
 	struct compat_timeval	it_value;
diff --git a/include/linux/compat_time.h b/include/linux/compat_time.h
index 31f2774f1994..d1a787821168 100644
--- a/include/linux/compat_time.h
+++ b/include/linux/compat_time.h
@@ -17,6 +17,11 @@ struct compat_timeval {
 	s32		tv_usec;
 };
 
+struct compat_utimbuf {
+	compat_time_t		actime;
+	compat_time_t		modtime;
+};
+
 extern int compat_get_timespec64(struct timespec64 *, const void __user *);
 extern int compat_put_timespec64(const struct timespec64 *, void __user *);
 
-- 
2.9.0

