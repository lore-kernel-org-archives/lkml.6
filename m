Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524669224-2-1032724092140286290
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
    1524669223; b=ihG8A5PR94vNpwETfcQp4P3jDT4NuXYPgAjkDhjf8rlcRbBvsd
    SFTyzn+n8SPeETkaqSsJcAypk7vZwfWMx63csIsDWMGU0IW5Ub370lHvciigs9d3
    uQ5ee06X5hLCQVm77g8Fz4ZSv6DL585xC0kCMkVuIAFAUh8ILBv9sAGbP3Pb9J5v
    yOXMPt2SSoqUIX5qdf0pXjFywZG7bFjkUPW+3yMELG7nOQ+iCnXhkbM4KYSoIBl0
    nWTlXCMYes3ZFj3kBn6AY1CKHAzSfzJGgqIWgafRVBeVTGQcc1EuLG/BQd7G3GZp
    5edPeG19GCCCOKt8jVeFELWQVQcc6KI+YHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669223; bh=
    l0jyEFY+hkPMnUceLQIWEALESZeX15JkgRWAQrHiulM=; b=QALVuaIA+o6VT8Vd
    z2IxuRRnwopWY0eOMqra0PLf3AI4YuiC5YxsMMt+natrtP2PNJaDxYZLye9XRA44
    X6KXfDOUA4DTlcAfYDptHXc6/gAA+nLqExle9XiyBJgkWBeyxtdSy4kanN1YnLhb
    hohkB0osfo8hGaJPXdedCz6uy2FVaEtaOlPbNvLloYXZboIiki70k6TKqlsn1zh1
    HBcp2z6098E2/baZ0zsPMvCrl3sOhnbu9lk2fqPNdvk7L7h80LtQ9NWyu+0CpTdM
    EG3wnuY1GOkTqIHm5Sm7s0UZfpk0qLhSAf2AOeQ8+UGxule9r5ESUST3PcCqVx6e
    HRkAOg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE+z4e8//Pctmr4ipBt4UtoPhGOzXaaCWQv/X/GckL1DhfewZ+OhlX1bjTs4C2Zq2YJ4Gv72Kc+ix/IPwgeUk1b4PbQsMD4v9pfPiWOkalQaDZ32qXpK
    p8gN1in2LcK+UGiEQ6pXqq+VAa5F+8f8PauTOYk2mwSMRm8KOxe2SrxV8DdswkpgvH3RPsb0Lwdb26IanS+NwCXfAE7j+pC4PoE0yzn5GGvc9/vkthcVwOH+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=uoltoFHUlbKcE8_BlpwA:9 a=5m7Ad2VrR9ME0qSz:21 a=arKeV7zCrVa9cqf6:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbeDYPNF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:13:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754757AbeDYPHO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:14 -0400
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
Subject: [PATCH v4 14/16] y2038: ipc: Use __kernel_timespec
Date: Wed, 25 Apr 2018 17:06:04 +0200
Message-Id: <20180425150606.954771-14-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:GC8B4lvTkw5Lm1bzN/Q0A6HXJ7loY8D2WCpwJQcWGCLtmTYV60x
 6nydte5iGaMkPNezDbJHWv2T6A5ubHs7YDmFg3Y2rfsTkcd05ISLJSwWNww0aqKLEIMuBwL
 or/J5Y0U0t8pM6SeboCMYjU7H/bpZ1ZaW+jVR/WfxHY71ZZ9GAJ9SfKNTQe4gvR6NkpfqTr
 C1PYQCGo71GjBGpLYbk3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BJXUDQ6Vvto=:iFZRn5T++Cyo0hzYvieKxi
 Ok5PngjIt0vhLUEbGiUjM/SlfiQ5tCzDqq375Cr2Rph9Zv9x0mr1syd10p7LKMtRWHWbGKwf6
 Z4+7h7MCrn0+YL0b7oxUtgxxv54/8r0fjP5Hzz1zAFl4mrbgIrdiL/VZp5w2xDFY7c7ReWwsj
 /fRzQYXKkfRqlHYI3pUhDWW4AXEti+yFtXik5o28vdGYBwFrBQ+DLp6BaJZv8DovmZcYIPdcT
 rFjEOiY1bfWKgfI+JAHkyodQWDzRJShBR6cJRDEzv5U9Kb1JqQMocf/a/ORBCN0FpIDO6wBls
 zKwWGUazjo1e5JlASCCKCAaB6CfAiDICLHR3YFTfRHhdFAW+cPwCHuR/rXuQP5dxqf1sMHrzQ
 gH43ULgvkBOedwCl6Dl/NFLAuEJ6o3B3DnC3x25FlQks1H3a92c1Cuv0Y8TFU50u9GiQkTtRi
 Dznbz8ZwrcUyncvhH5yp+QBLEX5iRqda/coMPqXqKjNeQTkq8MUZkgzOP6YTo4SjP238pd9tF
 1/e5QuKpH8SjunVfmQ82mYZZ83hBkabum39IAi3bmL3L+RtniK71/sVhDdZw8P24OzbVXmKBL
 PYKhk1N0qJUaXGbsSy3F2QuTY7fybJLnlXolQibwapDSpXLk2q4guJy67YYrw43FhcYMKq2Yd
 jld6R9gbggwVYyWntTBG6EB+kGuf64QdQAinoNjAhS5D9DlnDoDWxCmZDJ2juli2d6SlM5GDM
 zr0tmga1eO6+Zdmn0Vyv6ZlG8kh2VpTPSlv3uA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a preparatation for changing over __kernel_timespec to 64-bit
times, which involves assigning new system call numbers for mq_timedsend(),
mq_timedreceive() and semtimedop() for compatibility with future y2038
proof user space.

The existing ABIs will remain available through compat code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 6 +++---
 ipc/mqueue.c             | 6 +++---
 ipc/sem.c                | 4 ++--
 ipc/util.h               | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c9a2a2601852..b92cb79d38c3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -680,8 +680,8 @@ asmlinkage long sys_sysinfo(struct sysinfo __user *info);
 /* ipc/mqueue.c */
 asmlinkage long sys_mq_open(const char __user *name, int oflag, umode_t mode, struct mq_attr __user *attr);
 asmlinkage long sys_mq_unlink(const char __user *name);
-asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec __user *abs_timeout);
-asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct timespec __user *abs_timeout);
+asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct __kernel_timespec __user *abs_timeout);
+asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct __kernel_timespec __user *abs_timeout);
 asmlinkage long sys_mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
 asmlinkage long sys_mq_getsetattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
 
@@ -698,7 +698,7 @@ asmlinkage long sys_semget(key_t key, int nsems, int semflg);
 asmlinkage long sys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 				unsigned nsops,
-				const struct timespec __user *timeout);
+				const struct __kernel_timespec __user *timeout);
 asmlinkage long sys_semop(int semid, struct sembuf __user *sops,
 				unsigned nsops);
 
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a808f29d4c5a..9610afcfa2e5 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -691,7 +691,7 @@ static void __do_notify(struct mqueue_inode_info *info)
 	wake_up(&info->wait_q);
 }
 
-static int prepare_timeout(const struct timespec __user *u_abs_timeout,
+static int prepare_timeout(const struct __kernel_timespec __user *u_abs_timeout,
 			   struct timespec64 *ts)
 {
 	if (get_timespec64(ts, u_abs_timeout))
@@ -1128,7 +1128,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 
 SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int, msg_prio,
-		const struct timespec __user *, u_abs_timeout)
+		const struct __kernel_timespec __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
@@ -1142,7 +1142,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 
 SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int __user *, u_msg_prio,
-		const struct timespec __user *, u_abs_timeout)
+		const struct __kernel_timespec __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
diff --git a/ipc/sem.c b/ipc/sem.c
index 8935cd8cf166..b951e25ba2db 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2176,7 +2176,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 }
 
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
-		     unsigned int nsops, const struct timespec __user *timeout)
+		     unsigned int nsops, const struct __kernel_timespec __user *timeout)
 {
 	if (timeout) {
 		struct timespec64 ts;
@@ -2188,7 +2188,7 @@ long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 }
 
 SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
-		unsigned int, nsops, const struct timespec __user *, timeout)
+		unsigned int, nsops, const struct __kernel_timespec __user *, timeout)
 {
 	return ksys_semtimedop(semid, tsops, nsops, timeout);
 }
diff --git a/ipc/util.h b/ipc/util.h
index acc5159e96d0..975c6de2df9d 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -251,7 +251,7 @@ static inline int compat_ipc_parse_version(int *cmd)
 /* for __ARCH_WANT_SYS_IPC */
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     unsigned int nsops,
-		     const struct timespec __user *timeout);
+		     const struct __kernel_timespec __user *timeout);
 long ksys_semget(key_t key, int nsems, int semflg);
 long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
-- 
2.9.0

