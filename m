Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524672575-2-17620510137370220533
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
    1524672575; b=Y9pVMjI4ILNdvZRqJf3QXztD5cRlH4uk8EZ+NpL7CFZHRuzhuC
    8PskzUwwiYwbgM8CuPPvwx2a2Jd2Ce6Hrt8uD0LZnLhtMsFTULLmArNDHhlz8+vf
    l1ixxp0O3dtvJq7G1vqQX8iq/+C7m9TwIADAdKKdHsXe14sSvYOT+Lk6JqsRbnl4
    EWQeonVKE0dR3R0/22VXUOE7ivE3T+oRpegqrfcHNxMg1REz/DDqseAAZDIpTVjD
    qA5fVDIZRX3G+Wz3Nxn0/mkaL6plmchEmDJZ5SrSzf+lRWIne3LPpOZon+EkjLLE
    +0XCV5P6L6212zPYIXF2SjN16W/bTALxlGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672575; bh=
    HyM6a9PjJf3gq41NDEhVX1AWeLhOqyPGOGx+uPMJ1fA=; b=F/MDcNdiY6+Wf9un
    7OYbZ2acObgy/Y2LBZ8HokhyyYaf1U/kOi+ftj6w6rmQCEMdST3N8DfdmMOqI6Ft
    yMSV427BUz6HT2FtWFHUnKXwVUyljrCSsGh3C8LuOX8Q4WhZfPhNZAVyaqq8Etpl
    hpL0FmR97wueDdgn3XHe3jIAe+VxWnwaNBZLi34+2N+zvGvMLHgRQ9GtCrP3abGS
    7vr5VSNKuj4CM9fXNk6nLcM5IY6hsrod3pG7bHTpQnV0mq/Vye18ulXqErbcuprt
    X9TzJmTr+81NSRdk2G4J0kjQvpHZI5h3AQ4naMwdpv9mWw7wwBpQdmmCbKFg64Qx
    U3Gqqg==
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
X-CM-Envelope: MS4wfFTYa8rSum3XJL3L10DaFa37v6s81MVP4nhb6dIY9lSCuzm2bk5f6fTkdNroH1bu4CI6coF2hsM/H0w9d6I2wbbtRd85yiz8l3OvFpoDslxrk+0UKpCJ
    hptB8n6uww/TjHVuTkuM3A3SnfPbfzypm9TWsPuSyhrKiC+jBHeGm8CTGdqRAMEpPNRDwRDM/asWtiH/nTxBdIfzi7IGDWtWcwpIMR+XR98kVXNxSi7Vg/qf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=DnCerq8oMvzEHMY4u2gA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755478AbeDYQJd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:09:33 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755805AbeDYQEj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:39 -0400
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
Subject: [PATCH 06/17] y2038: Change sys_utimensat() to use __kernel_timespec
Date: Wed, 25 Apr 2018 18:03:00 +0200
Message-Id: <20180425160311.2718314-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/YWcR8sQ57mqZzuX98OrLE+xHYwk29mULcqk+Lq/VNq3HRQQ6Qk
 g+df3ZyYln/eEoRJbKXJORdqoAeAjX0JGnz1O9XnbE1HohpcLQP5X+1b/1GuS+nBIJB/9J8
 jpY+/nZDAFLxN6kAjiZSlihcsgtQuKBS9rK7cQi2sUekTMi1y5qO0s0YrZHjGwErUW/3s8x
 wRGRYH+slRMLlKg0EmvpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WRcSPk41H4s=:aRIUhRdxQKZsyYruZo61Qz
 yha/TdFPz0PVepEvJd5TQhRAevY+c1N01Ji2yOk0+yUssbPv+G2rebscubmHDcpAKdo7LRR3x
 uH6JQMzocysQcTFw2atL4Gd4ocljp6MZg592pUf26ByCH+bllIef8M9hoSS6SamXwVnob9TSJ
 Vay/2cVtNXwNRzXDlneBzcKep9yGP0b42dBL6cXs7NT4TqiLHaHfuOdjnt2t5TqdmviK/78P2
 Pm2cJMVu5bHS04h75RXWUBR6uOVLXK8fO1oyX0kN39l4V9yEz4cASHxoJS7fiPVlJANjUf9hd
 L/H1fIHgBeJMhzGSf9v2NvfAH7lF8h9/u8zNY84Kbsr4K6K1qBlfrVWPANmGEH5EM/QApjxMx
 RMamj4XL7ycsgZ9iUr0hz9eQKgzhuLBbWFqX+9wobIEqJab0r6GvP97dKHqsJE+UpDJBK5mA3
 O3oH2g76bWmezZOIpUUTsgGY85bb1NBceok9TNHBKwrCa/pWggR8RY1DCOMb7qNHTv8nYaNhS
 MSPGZxUnyJeKhQ2StHBSZlrdORy4F748954B9MwpLsa/1bYzyA2bt5+Ydr3DMMG8v60vh5BTn
 go9gZdX8C9f1VIx4eSZV59CffAkpz/QtMtHeROvw52w7yqP6jiyGRJuoSyM1NgaYr4XnxlfUd
 vnBBxA4zxIsLQmB4O5yPFKVkmFZsWU+pgN4PH/cpvUa+/w9/E1anufQirX3rlQnL38Ls=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When 32-bit architectures get changed to support 64-bit time_t,
utimensat() needs to use the new __kernel_timespec structure as its
argument.

The older utime(), utimes() and futimesat() system calls don't need a
corresponding change as they are no longer used on C libraries that have
64-bit time support.

As we do for the other syscalls that have timespec arguments, we reuse
the 'compat' syscall entry points to implement the traditional four
interfaces, and only leave the new utimensat() as a native handler,
so that the same code gets used on both 32-bit and 64-bit kernels
on each syscall.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/utimes.c              | 2 +-
 include/linux/syscalls.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index 69d4b6ba1bfb..ca2c02a7985c 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -166,7 +166,7 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
 }
 
 SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
-		struct timespec __user *, utimes, int, flags)
+		struct __kernel_timespec __user *, utimes, int, flags)
 {
 	struct timespec64 tstimes[2];
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b92cb79d38c3..3d7dd665cdeb 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -500,7 +500,8 @@ asmlinkage long sys_timerfd_gettime(int ufd, struct itimerspec __user *otmr);
 
 /* fs/utimes.c */
 asmlinkage long sys_utimensat(int dfd, const char __user *filename,
-				struct timespec __user *utimes, int flags);
+				struct __kernel_timespec __user *utimes,
+				int flags);
 
 /* kernel/acct.c */
 asmlinkage long sys_acct(const char __user *name);
-- 
2.9.0

