Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-889516-1524668928-2-2727624894843092230
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
    1524668927; b=pAGbcGZuhdBbnnC/3aU8PHG9LuytXJTcSK7B/tjZ6740u/1ses
    IMOxh8BPTwd2ugQHrP3tmeMAE2OpnEH9y25MK+tjzUdkSsklENljG8M9QGlZOii2
    UO7M5FwHHibRIxYSyrgD3bcUQ4UwulA2/PA9vfaQqxy9MZMajj3NqXrXaO9Fepy3
    IsgGt+iZPd0mzOpUGYjaQwFSf2syNtJ6tWXof/7ZyCh9b008ky3hn3QHvAOydawf
    zdIxkGxxLES3t0x0Ta6LOH6jGaVNiXx5N7eqVEm4uQ/vMRb7CdZgEOoTop237L/P
    2jHt55ulHMm/XanzMJTMuradM0Uya1LcULNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524668927; bh=
    o0tR1e+eBQPV5jbS0xxBWb4mTZcW/DooVkUVHXFw0gw=; b=ckstaXwj14PG/RE1
    GnDJM/H1U33Gi+me9qqCc1X8qW2R4nCDRPB9R8L4qkmnHztyzJY10DAyO41d/u6h
    l5wr+C0Qvcy9pXPFR+EFBp5KwzWdP5UrCrJx4AFzumvIY3bbsOU0QpxpQcziophT
    pl4HyTGsG8E5TcS7tHpgQDMMofLtnkG89HlYnPezUendDgXyqIwjdkeh6hq6t38Z
    cX6ALzadIOf+7FKjDv4DTD8YAMos8EsSMtOTfQ3TWnS4nQqCADuckNL7xfCg7nTI
    tQKrd9PgtcUfbZX9dGunlb/f3MlvSDfY5fSICkgIALYSpxOu6I42G5TzWO/jFFz+
    yZwXrA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKCP88bL7W20i5ivPOTDknXaQXeczSo6kkFN5B/4VIxi1QAO0lJcHxX1qIn0DkUCbH7th6EDhYROwXZcGG7ISsp54xNu7yed41O/oSinN43kYtCJkf8c
    kjwxJb45b2P8tVkIbUCGmcS8j1yNGfqayacpK4nSII8ab3LMhXgzxPZBGjOPxFaSv90tlwgjmfYcGx+aSZm32jb45IN5ycrUHRjvTkvkl2/TkL+lHlV1e9U7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=9aIODNJXDyEBx6x27aYA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeDYPIn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:08:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754898AbeDYPHZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:25 -0400
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
Subject: [PATCH v4 13/16] y2038: ipc: Report long times to user space
Date: Wed, 25 Apr 2018 17:06:03 +0200
Message-Id: <20180425150606.954771-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:U4bZ56OkJwX121pfYf1OxCU+WQTpWhsRjZP3Yu2XsWUfTW4h9F7
 8M4ApLronLL42j70AlJ8L8nE/NF8G8eKAKgVn92L7MO0AlU6Crh4yjcIFayeBvLAHGhT6yV
 C/dklrPQjCp2qttgopbz8xAmNr5kZo8/Lhep6OFY3zHd2ls0y5MZb4OJK2IZ2inOeiETZW5
 jwNdzMGeqrBSY5CMvq4Eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v1ELBJjk/7o=:a1dd3vJ6Iso1u9JooSEz+7
 bB3CFBWaYtL1A3h+wW63eO5Dm1qZW7pvgsNb87u3xmcWsnC+rjhCpujcmU2NvnPPrO2xeDI7Z
 k0cfz3sU4QZqO8bg54FUK4wABNrrD5aYcDi4F5r4Tqx4ZrLcGaIDG7WcI1242K6UK5FvY4ZYu
 8uay4InHjbk7plAVl0c0x105+21vfFe9I/Sn4MZQsqhGVsO05ywgKgRXmqkH/5JtCF6Rektl0
 k9IhDd6mRrY+tKagUtdu1WN2TMn93oVht69HHt1ITAJQ44HijwnDEs8fBxQvxzJzdMw0Yj/1K
 ztq1mScq0oE/onlHHhNNHnmWMG6rdQgRpLyHF3zmrKgIYgD7PWrypzMAnh8ujfms2+w1zzib2
 KZTMYR6mP58dHt2Oyv8yxOwcQ7VFxbdga2Y1f9gd/sIFzRVC8ay/6YV1TCQh9UsDk08OppjSk
 YOp3qqGl0w0XrETtSo9FB5b4kfhkztWJhssOJEgXfNiYYh9ksqk0lGFfeDymrmqiGXEQ06fRe
 wj6+jpIXU6aXvRCxZx/PXociCuT0CGp1xknA1aOqpWzXA+wyoqywK0VJbdIvOCVwqT/PJaTLM
 8bKkU1vxssQiMSG0nKLRBfHLm+fK2Q6BKzuxrfQAR4UJ9drftHOufTXOxI0t7x+SBfp0tmtZM
 zz9MFIv8qzqXjAvwty7QswsRYPeKMOG9mdjuVU8ssXhsWEv2jmXBVqvU7mVg5pHCKDHaG6C+B
 2PfPGXDIJzl50llRpP7mHqpbpZAZ82fQiulDag==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The shmid64_ds/semid64_ds/msqid64_ds data structures have been extended
to contain extra fields for storing the upper bits of the time stamps,
this patch does the other half of the job and and fills the new fields on
32-bit architectures as well as 32-bit tasks running on a 64-bit kernel
in compat mode.

There should be no change for native 64-bit tasks.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/msg.c | 14 +++++++++++---
 ipc/sem.c | 14 +++++++++++---
 ipc/shm.c | 14 +++++++++++---
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 574f76c9a2ff..3b6545302598 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -537,6 +537,11 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	p->msg_stime  = msq->q_stime;
 	p->msg_rtime  = msq->q_rtime;
 	p->msg_ctime  = msq->q_ctime;
+#ifndef CONFIG_64BIT
+	p->msg_stime_high = msq->q_stime >> 32;
+	p->msg_rtime_high = msq->q_rtime >> 32;
+	p->msg_ctime_high = msq->q_ctime >> 32;
+#endif
 	p->msg_cbytes = msq->q_cbytes;
 	p->msg_qnum   = msq->q_qnum;
 	p->msg_qbytes = msq->q_qbytes;
@@ -646,9 +651,12 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
 		struct compat_msqid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.msg_perm, &in->msg_perm);
-		v.msg_stime = in->msg_stime;
-		v.msg_rtime = in->msg_rtime;
-		v.msg_ctime = in->msg_ctime;
+		v.msg_stime	 = lower_32_bits(in->msg_stime);
+		v.msg_stime_high = upper_32_bits(in->msg_stime);
+		v.msg_rtime	 = lower_32_bits(in->msg_rtime);
+		v.msg_rtime_high = upper_32_bits(in->msg_rtime);
+		v.msg_ctime	 = lower_32_bits(in->msg_ctime);
+		v.msg_ctime_high = upper_32_bits(in->msg_ctime);
 		v.msg_cbytes = in->msg_cbytes;
 		v.msg_qnum = in->msg_qnum;
 		v.msg_qbytes = in->msg_qbytes;
diff --git a/ipc/sem.c b/ipc/sem.c
index c6a8a971769d..8935cd8cf166 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1214,6 +1214,7 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 			 int cmd, struct semid64_ds *semid64)
 {
 	struct sem_array *sma;
+	time64_t semotime;
 	int id = 0;
 	int err;
 
@@ -1257,8 +1258,13 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 	}
 
 	kernel_to_ipc64_perm(&sma->sem_perm, &semid64->sem_perm);
-	semid64->sem_otime = get_semotime(sma);
+	semotime = get_semotime(sma);
+	semid64->sem_otime = semotime;
 	semid64->sem_ctime = sma->sem_ctime;
+#ifndef CONFIG_64BIT
+	semid64->sem_otime_high = semotime >> 32;
+	semid64->sem_ctime_high = sma->sem_ctime >> 32;
+#endif
 	semid64->sem_nsems = sma->sem_nsems;
 
 	ipc_unlock_object(&sma->sem_perm);
@@ -1704,8 +1710,10 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
 		struct compat_semid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.sem_perm, &in->sem_perm);
-		v.sem_otime = in->sem_otime;
-		v.sem_ctime = in->sem_ctime;
+		v.sem_otime	 = lower_32_bits(in->sem_otime);
+		v.sem_otime_high = upper_32_bits(in->sem_otime);
+		v.sem_ctime	 = lower_32_bits(in->sem_ctime);
+		v.sem_ctime_high = upper_32_bits(in->sem_ctime);
 		v.sem_nsems = in->sem_nsems;
 		return copy_to_user(buf, &v, sizeof(v));
 	} else {
diff --git a/ipc/shm.c b/ipc/shm.c
index 3cf48988d68c..0075990338f4 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1002,6 +1002,11 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	tbuf->shm_atime	= shp->shm_atim;
 	tbuf->shm_dtime	= shp->shm_dtim;
 	tbuf->shm_ctime	= shp->shm_ctim;
+#ifndef CONFIG_64BIT
+	tbuf->shm_atime_high = shp->shm_atim >> 32;
+	tbuf->shm_dtime_high = shp->shm_dtim >> 32;
+	tbuf->shm_ctime_high = shp->shm_ctim >> 32;
+#endif
 	tbuf->shm_cpid	= pid_vnr(shp->shm_cprid);
 	tbuf->shm_lpid	= pid_vnr(shp->shm_lprid);
 	tbuf->shm_nattch = shp->shm_nattch;
@@ -1233,9 +1238,12 @@ static int copy_compat_shmid_to_user(void __user *buf, struct shmid64_ds *in,
 		struct compat_shmid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.shm_perm, &in->shm_perm);
-		v.shm_atime = in->shm_atime;
-		v.shm_dtime = in->shm_dtime;
-		v.shm_ctime = in->shm_ctime;
+		v.shm_atime	 = lower_32_bits(in->shm_atime);
+		v.shm_atime_high = upper_32_bits(in->shm_atime);
+		v.shm_dtime	 = lower_32_bits(in->shm_dtime);
+		v.shm_dtime_high = upper_32_bits(in->shm_dtime);
+		v.shm_ctime	 = lower_32_bits(in->shm_ctime);
+		v.shm_ctime_high = upper_32_bits(in->shm_ctime);
 		v.shm_segsz = in->shm_segsz;
 		v.shm_nattch = in->shm_nattch;
 		v.shm_cpid = in->shm_cpid;
-- 
2.9.0

