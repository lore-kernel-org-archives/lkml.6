Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672519-2-878700472878336375
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672518; b=krSj9nDSQi9aWu/95a5UlzMoHYggQ0DHqYk0Qu501wtw4C9b6t
    3jDXz4G8Dl1903/OgYdu0rKrbSztuBgrbfDfcLDQvwghj50d4oe7iubKU2g+lmKn
    xfTat0n0EmbcwjJx8jsxxNxZCLOQY0KUZU2nm5NHx9dP6PD/p76fciIuh/QrW6Yy
    +EHs8ZXqaCsVY6SmG07fwDDLefdU/unhZ9owpyzJ8DAXoaKOuvOV/zhNpGyB196o
    9F+NetR2a/xN79gjIzStGnTXPq96k3OSPg4QlJRFwZ8G+/Wo1udXJ8ECywQdm3K2
    9gAztBZf6EXWgIMeGGJcCe2QKcupscFaGOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672518; bh=
    Yffd2AWWeCkHJTC+CY8ISDMePUtRqtIpsFiDThRk8lA=; b=IWDcCBHxefB5D9A/
    nrqeWWWNM0SCR/ASomqEeGwMw4fUYYq2J779TMksUct/PXgzUbWfePIMMwN7JSAh
    BMvETGjZTnwspbfZPADbrdHLRDrf+jad9H8V4PotyC6RuOgKYKXV9lYO7wBVhem/
    HWbWM7J24quoq+aVJ7NNbF44WGU1L+VK+fE5DtbKakmjofcQlK8jbrLcGCjlgoFM
    bS0KNtOcQSi0M5/WeT5WwC9/wJMn1Qp1dHc473MYk6ElX1krTW+T4McKprMoPfkt
    tOaXyEdGIRmU5d4iGObftN6vtRzgPqEVlzlKYJiNZbZgaNJZdnnb9UOW7d7iGzZB
    1vKxaw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfCze991oA2vuApd3cG9DABG31Iz6tUStqAA1ldSh6NsNK/6bJTiu3ttQt2X89TVEX2F8bSzsSYtj2E8A4+6chXUa4I5o0FWKalTATc11PZtsOYVTUqVs
    Q9r3DW5EZL8uf3SSwZ0nQvDsalHgPRp6aOA7IKDVFZO7rMkQmg+/7I4gfoGW4tOol54T/dI9q2OuMTEBOewINED6dfBpVuWMLZ63NFNIn7jxmRo0bSpdWLdd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=xwIlUUQzSFprVyE_1oEA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755157AbeDYQIP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:08:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50725 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755744AbeDYQFB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:05:01 -0400
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
Subject: [PATCH 07/17] y2038: Compile utimes()/futimesat() conditionally
Date: Wed, 25 Apr 2018 18:03:01 +0200
Message-Id: <20180425160311.2718314-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:V39P8f+WwvNAD98Mz5Mg9sSGJjP734efJE3URNQLGhlVEWVfXsW
 hLZOIMlUAhBjrtwy7sWO961yK+ZvgRXBTkOQzAVyx6hXw0oB9D3ZXggmoq/4jOj/pbmcWG1
 3uWNu7Eo/GHOhHncc55IYu1IjG7WCyI0ackYOfNWPXC26tgQLlGiKfL47TMwpAb3FM6Nb4w
 IocWSRB9VVHxRRSC0ev/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EqAKw0UipvY=:bh0EjLUZlrGjZePSwrEraC
 pXuI3LV4tJc7TDgS1LCwPm9w035dG07j/RWR+JJK4g/o1Dp0R5QwpqTJqsJeOIX0kM270AXXB
 r9lgJkrpSs+GRXDIYMmsVNeiyQOf5c5x4W18WL8hN8Uoc+K6U2b+xy9+MO+BpJDvBgca3gtTU
 gdLlRdhRBdn6ndbJBUbWlNrm99l80M5gLC4Yan22jRX04aRUJDH94qb314G6SypV9vg7qXOs3
 MgLdqU5qPmZvxKthTyEQRA3jxFHYsDI7aClKdoL4nK0FeIO4Zj/4fJ2tcPJyAsI/CPGNv+tln
 r4zNprUfNoJmjnlV0evn+PNr/xN+8AyDg0ZCE3v0oSkSvKSj3bZZx0sl78wJT7/+X4lGpUtfs
 cExJEgezuiJPsn6IH/GFgmFlMNB9qJNpz9WgyYiuV6Df2SifCDPwU6qYZNotU2svFxnfEJL+k
 w8MZxjeQvUlLDGjW41uRBYi+cXy7/rX5kuNQ8UmyKQ7k1mK5TBaUK2jTvSfG70Rpo+TB/GRKQ
 5P15OGVy6I6nPBGCPU06WAmwANTTOuf1VVQTNwSMW8fUqOr/YiiFYxeU3aq37J+3fjAneQ0DB
 MWBDhgDrLT1cRJY4Wsh94qVDXYjmheIy8mE2LMjMOYqa8Dfy55KtTJZ+iJwpBnRLsGIHBEKph
 RBNJFOdRTXAHpc5SX0I1SZBWvGcMTYTUc0N56dCGilp0MX5WSOehJm+vvunrXXQalWt0=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are four generations of utimes() syscalls: utime(), utimes(),
futimesat() and utimensat(), each one being a superset of the previous
one. For y2038 support, we have to add another one, which is the same
as the existing utimensat() but always passes 64-bit times_t based
timespec values.

There are currently 10 architectures that only use utimensat(), two
that use utimes(), futimesat() and utimensat() but not utime(), and 11
architectures that have all four, and those define __ARCH_WANT_SYS_UTIME
in order to get a sys_utime implementation. Since all the new
architectures only want utimensat(), moving all the legacy entry points
into a common __ARCH_WANT_SYS_UTIME guard simplifies the logic. Only alpha
and ia64 grow a tiny bit as they now also get an unused sys_utime(),
but it didn't seem worth the extra complexity of adding yet another
ifdef for those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h |  1 +
 arch/arm/include/asm/unistd.h   |  2 +-
 arch/ia64/include/asm/unistd.h  |  1 +
 fs/utimes.c                     | 51 ++++++++++++++++++-----------------------
 include/linux/syscalls.h        | 10 ++++----
 5 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index edc090470023..9ff37aa1165f 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -14,6 +14,7 @@
 #define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 8f1159c26f20..88ef2ce1f69a 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -26,13 +26,13 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_OLD_MMAP
 #define __ARCH_WANT_SYS_OLD_SELECT
+#define __ARCH_WANT_SYS_UTIME
 
 #if !defined(CONFIG_AEABI) || defined(CONFIG_OABI_COMPAT)
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_ALARM
-#define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_SOCKETCALL
diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index c5b2620c4a4c..49e34db2529c 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -29,6 +29,7 @@
 #define __IGNORE_umount2	/* umount() */
 
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SYS_UTIME
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
diff --git a/fs/utimes.c b/fs/utimes.c
index ca2c02a7985c..ebc7fb713d91 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -8,35 +8,6 @@
 #include <linux/compat.h>
 #include <asm/unistd.h>
 
-#ifdef __ARCH_WANT_SYS_UTIME
-
-/*
- * sys_utime() can be implemented in user-level using sys_utimes().
- * Is this for backwards compatibility?  If so, why not move it
- * into the appropriate arch directory (for those architectures that
- * need it).
- */
-
-/* If times==NULL, set access and modification to current time,
- * must be owner or have write permission.
- * Else, update from *times, must be owner or super user.
- */
-SYSCALL_DEFINE2(utime, char __user *, filename, struct utimbuf __user *, times)
-{
-	struct timespec64 tv[2];
-
-	if (times) {
-		if (get_user(tv[0].tv_sec, &times->actime) ||
-		    get_user(tv[1].tv_sec, &times->modtime))
-			return -EFAULT;
-		tv[0].tv_nsec = 0;
-		tv[1].tv_nsec = 0;
-	}
-	return do_utimes(AT_FDCWD, filename, times ? tv : NULL, 0);
-}
-
-#endif
-
 static bool nsec_valid(long nsec)
 {
 	if (nsec == UTIME_OMIT || nsec == UTIME_NOW)
@@ -184,6 +155,13 @@ SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
 	return do_utimes(dfd, filename, utimes ? tstimes : NULL, flags);
 }
 
+#ifdef __ARCH_WANT_SYS_UTIME
+/*
+ * futimesat(), utimes() and utime() are older versions of utimensat()
+ * that are provided for compatibility with traditional C libraries.
+ * On modern architectures, we always use libc wrappers around
+ * utimensat() instead.
+ */
 static long do_futimesat(int dfd, const char __user *filename,
 			 struct timeval __user *utimes)
 {
@@ -225,6 +203,21 @@ SYSCALL_DEFINE2(utimes, char __user *, filename,
 	return do_futimesat(AT_FDCWD, filename, utimes);
 }
 
+SYSCALL_DEFINE2(utime, char __user *, filename, struct utimbuf __user *, times)
+{
+	struct timespec64 tv[2];
+
+	if (times) {
+		if (get_user(tv[0].tv_sec, &times->actime) ||
+		    get_user(tv[1].tv_sec, &times->modtime))
+			return -EFAULT;
+		tv[0].tv_nsec = 0;
+		tv[1].tv_nsec = 0;
+	}
+	return do_utimes(AT_FDCWD, filename, times ? tv : NULL, 0);
+}
+#endif
+
 #ifdef CONFIG_COMPAT
 /*
  * Not all architectures have sys_utime, so implement this in terms
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 3d7dd665cdeb..d2b19e814218 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -941,8 +941,6 @@ asmlinkage long sys_access(const char __user *filename, int mode);
 asmlinkage long sys_rename(const char __user *oldname,
 				const char __user *newname);
 asmlinkage long sys_symlink(const char __user *old, const char __user *new);
-asmlinkage long sys_utimes(char __user *filename,
-				struct timeval __user *utimes);
 #if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
 asmlinkage long sys_stat64(const char __user *filename,
 				struct stat64 __user *statbuf);
@@ -972,14 +970,18 @@ asmlinkage long sys_alarm(unsigned int seconds);
 asmlinkage long sys_getpgrp(void);
 asmlinkage long sys_pause(void);
 asmlinkage long sys_time(time_t __user *tloc);
+#ifdef __ARCH_WANT_SYS_UTIME
 asmlinkage long sys_utime(char __user *filename,
 				struct utimbuf __user *times);
+asmlinkage long sys_utimes(char __user *filename,
+				struct timeval __user *utimes);
+asmlinkage long sys_futimesat(int dfd, const char __user *filename,
+			      struct timeval __user *utimes);
+#endif
 asmlinkage long sys_creat(const char __user *pathname, umode_t mode);
 asmlinkage long sys_getdents(unsigned int fd,
 				struct linux_dirent __user *dirent,
 				unsigned int count);
-asmlinkage long sys_futimesat(int dfd, const char __user *filename,
-			      struct timeval __user *utimes);
 asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 			fd_set __user *exp, struct timeval __user *tvp);
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
-- 
2.9.0

