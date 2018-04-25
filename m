Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524672343-2-9312831905191298782
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
    1524672342; b=BL6s8GSrG5duADgHl/xxb80CyxzdZpD8dNiktpBudVuS4yb8fN
    1NBRSTElVd0s6O8yhLlpYZe1u9DL02olUQIb95Q1Qop+N7KVIDjTXP6clICVSpEt
    nu9xxP3zZSvr/ZFQXvGKxqKmCp6NIVGPHnvN5F4ijRXpCjzvmyAdOAm3Y7fkjwDm
    lwMJ4xfuykKiPjrpl9uj6iYamptaQsiNNMLZloDxf2ez6rDcMQROGAJQzptO/wYG
    Fc6pPr2IDEryW2GVItPmui3+FzM6RrMw0gOW4fBBmsmdYfWT1rF+AvnMuHp4SE0w
    AfVN3AH6lRtsnpwKmGY9ZkW6lC6QtmD7mpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672342; bh=
    Q/9sTdxbAukBxxigo3Ra99qUxmEyyo1RRUwzgUGGPjQ=; b=jyW1LeSRk3kjMcXz
    y9Dk0WsNInzTgIhB727qtXD09Bf86Ee9UbxtkzrmnBRQUjisIEQsFFW32M8ewd4o
    XjxiJXaEgDFFhlwG0hy9hyGw9pIBGPnGy3kNKkx4DArfwFAApFGeDrVuHDzjL+ol
    sx8kpts9HPercRZSCxkeYa6un36ptrkf+zgaj4MmQ885sKmCH6kpKMiGTeZlG0Ft
    wqCUt4J1Op3inLWmhUbnNf2Oz3KzrD8O/XD5u7Q8y+e3g0i8pZcpYZOxDrow7fwt
    iSJ4xBsflutwXtTBlLQNjSdLKso8ckfAL0BUkDqD6n7YRHy7alrOWCEK7Vcg4cZm
    A7ZgmQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfM5lDlNtGX5/gW16dDYoNfIr1j3tzzp84YOObimkeZeEx8avN7UhYcnzTDUx9CtjodFcn1l4s3g7QtX/cblQyoaDK5NgL4UF0YCCcgNInkyConjLLJQ2
    SoACRGz2i0k21jgPiYUFe1ucb/qrXpZg3cmal31/wlj0lAesJFi4N+SA14cNaNTL5AE0KdG/ueNQD8Sb9Jkpvva587YL1n/faPYuUlunF2+BeHnIJ7EMJUVF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=iSxYPVqvN7RSIxVSuwkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbeDYQFj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:05:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbeDYQFe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:05:34 -0400
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
Subject: [PATCH 10/17] y2038: futex: Add support for __kernel_timespec
Date: Wed, 25 Apr 2018 18:03:04 +0200
Message-Id: <20180425160311.2718314-11-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:R+roZ20fps50o8bhsoif6KUk5c477hWheUOOag1vwJQdx4bczbN
 QfoGM98CTTlwDtNDkOVTpy9x7hipDga2Z2modAfJNO+sp9UQE12ChlKBhOWakNTbQeebGVb
 +i9ONbOAZiyXkLceKX56at7KkSGrGQM6M8UhohZejnRQcjjPnaKFP9ipHESkBuQYjuvatfo
 EZimJGfab/3bHGhZukeZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SUiMPOKmfI4=:3TDfbWFT8Wz6ivM86zMSPl
 nxR4bHy+me6XFt7hAkwwVHgBqen9LzU2HvTQlpkwrsELgFOHafxg8a3X9BWme7AhoOzPIdZiu
 CK/bfMKIwKusVy6U2blk+zpa4kWBgPe/DQ0hR99e0uRdNMhlz2QXV0R3egzBgSqn6afaXHfaB
 XI508Eog+6/4ccqONNBgPmWxlCtFcs/5VodCGWxVlcXLCfzGqczzbySnHmh06BGKFoPe1kPom
 74/3LwC8tElpLiKBRsnIXeepQy0myvdcYNL1g1yu/TCA3jBstQ6KY+mapGzDaon/NmFuboFhC
 2iAvSfK7sbWeAdTuI7oy458utB1lFhza2OCF5vk7NUqrqsCn+A7mSd1vurnwq5YS2kB6Rkwlt
 x8BL/bVQbUZPEdq63Gap4fT16a03foTqVBjAKBZrDCWcoq1Pndb+/GjmJX5CX8HsvhdPrKL14
 lgMX2l2mL360WdNHrBHlamwxbzkefJAEIe+Mxy6U6kgBWqWIGGFQOD3SRsDTq+FGsbX/tJoxa
 ljD7EFNvyuCGl9Tmq08SChld/Cdg0KDRWNoAB43eAaW+LW1w/1ziattqg9DCOyUprcIqlcVsj
 aS4RAgOp+eAyfw8v5cCkEAbu/d45MLBcCtno/e/rtA0bcCktNSLgmppUn9jOzCIH5ocBy+Pqb
 9tQK7yKpg0jUR8drLG9wg7eDduAG6s2xp3bEHc7qLgysZrnfHMkFrMqc/QLInx6lILhk=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This prepares sys_futex for y2038 safe calling: the native
syscall is changed to receive a __kernel_timespec argument, which
will be switched to 64-bit time_t in the future. All the internal
time handling gets changed to timespec64, and the compat_sys_futex
entry point is moved under the CONFIG_COMPAT_32BIT_TIME check
to provide compatibility for existing 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h |  2 +-
 kernel/futex.c           | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d2b19e814218..c3d504dbba9c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -528,7 +528,7 @@ asmlinkage long sys_unshare(unsigned long unshare_flags);
 
 /* kernel/futex.c */
 asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
-			struct timespec __user *utime, u32 __user *uaddr2,
+			struct __kernel_timespec __user *utime, u32 __user *uaddr2,
 			u32 val3);
 asmlinkage long sys_get_robust_list(int pid,
 				    struct robust_list_head __user * __user *head_ptr,
diff --git a/kernel/futex.c b/kernel/futex.c
index e9013d1e65a1..129555a3b64d 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3556,10 +3556,10 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 
 
 SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
-		struct timespec __user *, utime, u32 __user *, uaddr2,
+		struct __kernel_timespec __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 	ktime_t t, *tp = NULL;
 	u32 val2 = 0;
 	int cmd = op & FUTEX_CMD_MASK;
@@ -3569,12 +3569,12 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
 			return -EFAULT;
-		if (copy_from_user(&ts, utime, sizeof(ts)) != 0)
+		if (get_timespec64(&ts, utime))
 			return -EFAULT;
-		if (!timespec_valid(&ts))
+		if (!timespec64_valid(&ts))
 			return -EINVAL;
 
-		t = timespec_to_ktime(ts);
+		t = timespec64_to_ktime(ts);
 		if (cmd == FUTEX_WAIT)
 			t = ktime_add_safe(ktime_get(), t);
 		tp = &t;
@@ -3745,12 +3745,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 
 	return ret;
 }
+#endif /* CONFIG_COMPAT */
 
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		struct compat_timespec __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 	ktime_t t, *tp = NULL;
 	int val2 = 0;
 	int cmd = op & FUTEX_CMD_MASK;
@@ -3758,12 +3760,12 @@ COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
 		      cmd == FUTEX_WAIT_BITSET ||
 		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
-		if (compat_get_timespec(&ts, utime))
+		if (compat_get_timespec64(&ts, utime))
 			return -EFAULT;
-		if (!timespec_valid(&ts))
+		if (!timespec64_valid(&ts))
 			return -EINVAL;
 
-		t = timespec_to_ktime(ts);
+		t = timespec64_to_ktime(ts);
 		if (cmd == FUTEX_WAIT)
 			t = ktime_add_safe(ktime_get(), t);
 		tp = &t;
@@ -3774,7 +3776,7 @@ COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 
 	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 
 static void __init futex_detect_cmpxchg(void)
 {
-- 
2.9.0

