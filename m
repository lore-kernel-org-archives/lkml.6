Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-889516-1524669133-5-148425827668222451
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
    1524669132; b=dvpC+HNpQACtJVP2by21aq3XJZmwVW/LoLYXyT62P0jDEeOAeq
    c3F6IVgBe3VlY6RHPI/gS+K43eUK6Qi+8x7I4223mgrB8kAumnl0cKfTTjUJWN7e
    BBdYBpNZCO/x+3pal72e08BkQEQtQ04HhJfpXHoWfZXrDYdAAyeHeSiTMbMtqKJu
    Mn+hNswqidZVz2KiZ4t0DcjKtubl/Heqhyxp19PKMrPEnGEewjCH+6IpoKE18rAR
    m26hGZFjiWiQlTkKNMA3I63pRrMRx8UExUEBDOjFSe/lsCNZ9iSkGjAUojsX+oqt
    tXw2GP1PRCHvZM7LGJUT8DDyLY1H6aCbNvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669132; bh=
    LsvS7DcQxJZUIppftglfQwvXwMzRU28QlAmbrIgqmyQ=; b=RCgW+Iua+z9bScMT
    sl55Nu99tWZFfoTKIAvD2B6bA+lz+BhtgKY1wrB/geJrwZFvrS/KUbHNF3fBaD5o
    znjAwk4nyqg0THHy/FuA786kF/kDH2J+4njlxod4oOWKkJ/VvkRmYz8RvJ0FPRWb
    cv4ulCDyh5K+ukiepyv46BWVPw9Ka2OYmSNe5pJOxm2CCK/AzFfbrg+LcUqs9DlM
    5nvvahBfb1mexmdWE9IFQaq6xyXX3s2LPvGEPtsaSBFm59Ymwal0MRaRzID7nrsf
    2AdktS4ttKeA1RKeJTtJ5WQ88D4Z44A9QSyILWlknL21NNbffZj3bGLbIFzzrWq7
    5XmcRg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOz7btMn2trtZIGaONBkqFd5tTwwgIm1zvgXdPYSqgMCI3obcsdmGNMTmxcUz/RydAXQ6fsGseft/qreuPtxmKH8Zlc65l+5PYvwPGclOQkajQImJE3H
    RrhyQnRyzvlwRGAZ4cX3q1rbmcHt2v5kfSXgh6s8NCUT09KDMk2u7rjdGEx8PWdzFg088U+5pRtcsegb0FT5bUXMog9dyKeFGuqZFokRg0uTa/luwcdRLv/e
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=5QZOrnP-N_GQhJ_ZMqEA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755073AbeDYPLy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:11:54 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753632AbeDYPLq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:11:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, albert.aribaud@3adev.fr,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        zackw@panix.com, noloader@gmail.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 06/16] y2038: arm64: Extend sysvipc compat data structures
Date: Wed, 25 Apr 2018 17:05:56 +0200
Message-Id: <20180425150606.954771-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:fcRe0DNUcAVypwYlTp3IXYFjuFjQDfKycU59jL2OVL1JElO2Czw
 OE3O+8kugMP8MM8qSe0gl4B84vNx8+8fz8CM0FUk0juPvtVA5NIs2vXpuvE13AsmxMmxuWQ
 zAmwTXQC3OJAye3+ai4/1PSx820rUFtAlA13zxP95WAEKTVRPfspaYCR+JGE7Vc2mrI+6D6
 Q4DTVOwUDgW9NCviLvM4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5DF63PkmOZo=:aHh74NeT3u2ZSVdacBqemX
 +OgQnTWtvULVk3AyDRneAvKH3R/CC+2OEBKWWmZ47pfFbEuM7+OG44vQjTSD7aWscavqKlJE3
 D4dvgoDnYxHfRuzb7JWJJeVoHrFu089TjO05RGKg82S7i7DnMXiLihFnTUlTJ1qui+G8fMm0U
 KMnJgWaav9p7FrHCESq/tTzvtzhB0puPNTicKTVBIInsTFSsyXjBiJ2ynuCrTkslg7BIifFOf
 HI+gZ6lXmDQ+CysBvE6KiOmmrm4oOvJD6QMrK1/uODQqVhx69CYjPQytrNE4Whywbv8X/xSju
 olrd0EiPfTLFFrzpQ8tgOlJ2/aLpaJ2QNRuZj1pn7+YRw42r6GExgIA5kcpZvUwxAZEuH7lLE
 dlL+/gM+iKNsOxmqdeKhW2aULrnnObBT/M9zt1wadrhd6Rd43hsSM/g+WJj4P5lU+sXKmkAzM
 bU3BuyJ4urHe8HiTSSNvywsnvbjJJURyn6who2U5OZ3ltGomYF8D0qRgVCeP/MpOV4HC/9yK7
 DyN+VXaX3i31zpCCEQOZ0Ea5O8zTFYclkC11FOvloYIaxbW6uUx8N+kpwpuweAuTRKT2JHo0z
 5MENXYM4aJYUNNjDadPDn6hEYuHfq8jztoaSg+7lppghIwO6kei8lNZT5Xg39+GWSC4Esgv5u
 EB6WLUAuNpamsY10tyHcbHLB/zNmLu24NU7S0qMzWC/K8U9RfjAp+BIDFDFht9ElcSzutk8Uu
 l/9MKfuchOqX1rk7+wInQ0poBINe2fvOnxe+lw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Both 32-bit amd 64-bit ARM use the asm-generic header files for their
sysvipc data structures, so no special care is needed to make those
work beyond y2038, with the one exception of compat mode: Since there
is no asm-generic definition of the compat mode IPC structures, ARM64
provides its own copy, and we make those match the changes in the native
asm-generic header files.

There is sufficient padding in these data structures to extend all
timestamps to 64 bit, but on big-endian ARM kernels, the padding
is in the wrong place, so the C library has to ensure it reassembles
a 64-bit time_t correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 0030f79808b3..1a037b94eba1 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -181,10 +181,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __unused1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __unused2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -192,12 +192,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t  msg_stime;
-	compat_ulong_t __unused1;
-	compat_time_t  msg_rtime;
-	compat_ulong_t __unused2;
-	compat_time_t  msg_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -210,12 +210,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __unused1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __unused2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
-- 
2.9.0

