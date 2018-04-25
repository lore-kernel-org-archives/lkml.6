Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672325-2-17183936938908679109
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672324; b=EOSdPgggKLO6pKL9pATXOVflcmrdFvYyJpwrIHP5gAnPHi+83g
    9aDGwsiF1zlGoTvxpEJi3hxPLJNFqxXockmqw4k2KHtkVPsXGvSpMZjNW++7Gz0p
    RFbJPAx+S5RofQwa0R1d+c7vfZl5OQ06k6+LMwSCEfR0R6d4MiihN3AvG5sTGqnq
    CZ9pRtjAgmnzHwMKNLtLMaiRM341KfdCvIivesw8SYG1f38x5UyFeJw8JKTDQ/PG
    Wcemoy8m055+ERZ8B3xZpntlgVe7VobQWbqDxIp+R/z/HPNjnDZFhRn3nHd2GHLB
    VZS19fjrL8WqWr1R/Zki0q8vQHtwqIdenR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672324; bh=
    vJUy28EHroZFG5my6VgHyOLj/xx1YzF3WiReHpPqp+I=; b=TSDrs+u9KCI4scqx
    LOpS0JzJDHWI/d/dlnePL3vdEvBZz5dagF23S3cBBbNyTgovGqf/7V7scYePFojn
    xG4y1c4INzXRHqqiilQU8LzksqJcbtbrwtArNmkpXcHZsHUICK8TxaTZIc+RblWs
    vqpr3ErOSM2Xe4QzhfgXwbEyT0MaRHNL46t2IbR/9mnRip95Xkh+Upny9ziQ+8X2
    02GdiWtD1ZAGFmH/g2ZaFBpG9562ZLZ+0xUbXdIcko8nSmcochwOtM+EIQGV12GO
    RI296ldDEc49NVR4K3NU5KswQV6Gf94tm0clsnVWXeOLMF7TxXvGhIqwhYkSOtsP
    nn8cOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfAAizuIjuyhGxW3kEx+9iAnc99ml8MrqSQbgTbKt6ogavAM0ExMAF9bK1I+H8e+gZiG8Q0Bh4AVxeZFhUtY0JqKrd0w8ks8MaoHay97e1GNX78/dql5n
    chkVykU+DcviL8J053uVkU+j2teOwY4umWljETtGz4qHlgIsgQf8LWphzTccM0d0K//BpaB0K4bN29nGoW3aKzGUK37AcOY2c6mdk67fVkiSGZ7HiiI+ASSA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=TVpFpNJtFTDK2K4FqhsA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755880AbeDYQFV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:05:21 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755453AbeDYQFO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:05:14 -0400
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
Subject: [PATCH 15/17] y2038: signal: Change rt_sigtimedwait to use __kernel_timespec
Date: Wed, 25 Apr 2018 18:03:09 +0200
Message-Id: <20180425160311.2718314-16-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:igsf2P3DT0IyMA/Ng6FqZQct7nSsdNtSCltmMXXdHoWd+BI90Y0
 Hzwr1NPoV3JWOW0ImwJW9Bsb0VGPqW+srf4lhuWudCzoOCqkx+9VkCK/2DoP7XO+ZsWfEKj
 97i+9xD2U68JEL1LkrUY2OWAr+K6r/EnBazhh8iuKmE6wrbKA00s2ilqOj5Z0qkur/igkz9
 LMGb+QEIst4j8y0BBnVBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:65jbx0DJbIk=:KWKqWzqjhcBy1utrBqYdqt
 mgvLBj5/KSyO/c38AMRkPzgZsb5LFL5gdXbUNrna6LXJ+ROGyGzo4/FcesmTY58V8u2IRDcv8
 b/67hERSiO3Rn6qjF2BovO6tydFk3i1muhZeWVwaNUL6R7GGZtTnEOl/qTCD5t3Hjq4LNQKiv
 9nzInNlEV9tJ0ktysDRznjvGMDU4TOp9/B2MqGbhscjNNH2AlxoF5enjBfDZCI0CqXI5j5D4n
 9D68PL/jwbQ0J8trtz+Q9z/9tOtmuqXymPvpRK9mtmXQWk37tpyrWpyQJ6syXI4ew7E2ifEhJ
 KvWTGFErQ2Za94+Aesp+qr5ExvOQVP/3t/DsmCXM8eSpPMD2W8eCB86XV6nA0g2jd50bhupOz
 sMSp+PkQkgMsE7pyS/yiUOor0pY7Mw4APyj0KUsqzQ7ojiX7hERF6JN4dsYkE/fdwHU+EHduj
 M4eHPuEa4uz3kItFi86W8rLDdqCeXrsG+US/8wlia40fTazLmbRTPCP2+EFqHvsnzz0ZJtoE/
 fA0HuNwy5RMhkaXF6CvHdqb99xCpoNLwC8AchEcFYLjQtmACWeIwAmuKYvHAX1mAS7fi4N2+E
 OrCeMr86o2zqp1wUa7yxw3t5QSijelOva2dCkul2AVi6BjxSYBX9JsfZ301ArfdJtz6oIsoF+
 p2JpfShxx+IpaU/QewNrp/rv2Q2Fg68qhqZ6RpV9j8mkXUzvDN8mDbXfkWJJvXNepk2E=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This changes sys_rt_sigtimedwait() to use get_timespec64(), changing
the timeout type to __kernel_timespec, which will be changed to use
a 64-bit time_t in the future. Since the do_sigtimedwait() core
function changes, we also have to modify the compat version of this
system call in the same way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h |  2 +-
 kernel/signal.c          | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index eaa32317f573..a756ab42894f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -622,7 +622,7 @@ asmlinkage long sys_rt_sigprocmask(int how, sigset_t __user *set,
 asmlinkage long sys_rt_sigpending(sigset_t __user *set, size_t sigsetsize);
 asmlinkage long sys_rt_sigtimedwait(const sigset_t __user *uthese,
 				siginfo_t __user *uinfo,
-				const struct timespec __user *uts,
+				const struct __kernel_timespec __user *uts,
 				size_t sigsetsize);
 asmlinkage long sys_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t __user *uinfo);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index d4ccea599692..d8d68a9556ae 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3113,7 +3113,7 @@ int copy_siginfo_from_user32(struct siginfo *to,
  *  @ts: upper bound on process time suspension
  */
 static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
-		    const struct timespec *ts)
+		    const struct timespec64 *ts)
 {
 	ktime_t *to = NULL, timeout = KTIME_MAX;
 	struct task_struct *tsk = current;
@@ -3121,9 +3121,9 @@ static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 	int sig, ret = 0;
 
 	if (ts) {
-		if (!timespec_valid(ts))
+		if (!timespec64_valid(ts))
 			return -EINVAL;
-		timeout = timespec_to_ktime(*ts);
+		timeout = timespec64_to_ktime(*ts);
 		to = &timeout;
 	}
 
@@ -3171,11 +3171,12 @@ static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
  *  @sigsetsize: size of sigset_t type
  */
 SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
-		siginfo_t __user *, uinfo, const struct timespec __user *, uts,
+		siginfo_t __user *, uinfo,
+		const struct __kernel_timespec __user *, uts,
 		size_t, sigsetsize)
 {
 	sigset_t these;
-	struct timespec ts;
+	struct timespec64 ts;
 	siginfo_t info;
 	int ret;
 
@@ -3187,7 +3188,7 @@ SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
 		return -EFAULT;
 
 	if (uts) {
-		if (copy_from_user(&ts, uts, sizeof(ts)))
+		if (get_timespec64(&ts, uts))
 			return -EFAULT;
 	}
 
@@ -3207,7 +3208,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 		struct compat_timespec __user *, uts, compat_size_t, sigsetsize)
 {
 	sigset_t s;
-	struct timespec t;
+	struct timespec64 t;
 	siginfo_t info;
 	long ret;
 
@@ -3218,7 +3219,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 		return -EFAULT;
 
 	if (uts) {
-		if (compat_get_timespec(&t, uts))
+		if (compat_get_timespec64(&t, uts))
 			return -EFAULT;
 	}
 
-- 
2.9.0

