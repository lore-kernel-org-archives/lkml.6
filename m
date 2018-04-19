Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524149027-2-10418147836228283958
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524149026; b=lgtTQJn6e+ycMaKxy6Tb5yWwSLpl93iuhUtBMWyLqBK00aTe7I
    fJC41MJTQByr880Vp+WZizLNKTmWR5qnTuxZTfMnctgLO3Catdo2qerP2z0Us+lY
    JXgGRvW0S/DnlbFmZS/GR9SSLiolEbnJHP8PTjRbZcoI4Nlqr7cvyYCW4X5408l8
    bFAFyCR91KEvC0+IB5hp/oa0oqZkD9LkKxI8osUcnSHHfQYfrJtkbYQwcOsyaz5q
    pACaivr39Ijh2wuC4joSB5lgwsBq3o0wggfhOVXeDVSyUEwdMDsPnbPV+nSH+DbQ
    3wB4CasnZRl07ixzl9jiQpeVD6/Jcurot25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524149026; bh=
    8FrWpl65o1YKDI0KzF2MRkCrrHIZtvoZrbfhhwJrdKM=; b=tJX5MXfxUl8VAtct
    bRZuFbYwBgxYbQ4WQ1euGvPajIjVUvQ4UZi8CHQ0UXY/poozdFxaEN1F7H/umW1P
    8UPRtTe23AM5OxYVCXMqSaS0v8fNtgbruFGTaYZQPOTZhfeHPJ3vfOcPF9Yvchb7
    yIugwJ8ZPwK48QYzBFy60zahL+jlOGFnSQ9fkzC5x6T8QN7pjp80pZPgs31Z0Yd3
    M8sIx4VNEw5tqlt+d/RzvXcALUKb0vI5d5pBOJz1axfi/bauXCtQ+e7KuQWEi2L8
    tvafidC6VwCXGQFme+ytZqU3DAQSljOvFQwqNRMHr1C4/ZwiRRlQxr4ZiT+WcNc8
    V7VxBA==
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
X-CM-Envelope: MS4wfBsBOY8nPS3IDYFflaXMyrvx/wMHsV/Zx6QAMDXXLyU3RdtTaBJJSaZjhPXeXXgTDshRSh5g0EQESC1IsoVUMm2atLW9WmnBpETgD50pxc/qmevTZBYC
    k8AwoiAzmnazRh2vHyffUGqcjEWheqA1pxduim7fv37zlxmTHlUlz79bNMCN72vl+cTNREW6rlILePC8/V/8EKNi/BT1ddgGvikHhBSqi+k1ST/EMhYafGky
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=JWfEK_nTYSbs3IZf51wA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeDSOit (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:38:49 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeDSOir (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:38:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 12/17] y2038: ipc: Use ktime_get_real_seconds consistently
Date: Thu, 19 Apr 2018 16:37:32 +0200
Message-Id: <20180419143737.606138-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:AJu2JDmyhTJaYI9k0Zdc69izyoMEo0YL+nuQkh2V03hjQ1rd4Ov
 zruaA3lje7KdQL5PWitbTyhVZHbYvJh2RFA6Osql1KYEvvdR4WFv4pjh7VhdH3VLludctrG
 kwaqL818bVfWwNMixkTp746xBv5tgEg2bP8UE22wBPijsCqG61yUXAt1617AncIIRgV9iDV
 ZjflBWNgO/uSVhsMx0eww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gamAfTntK3c=:Y84ZIW/sL96pFrxVIiQxKO
 XNl5i4VA4tAsRztW5MVcW+5deXMPX0mrHYEiLkvXiSj+GTVhULDHEF2GWRr8LMSS/hc6DNHpA
 IeQzVzt/Ll5oqCYy38voBTLGp25VUAjylYt+SeHGdgH+a57/egjuscZkdYAI+D5XwyluuFr5T
 Ojl/XSRa8EhSChMa3xqUQZ+dlILqEgsrHNwa8Z39muGttZ/gtjbCL3pAQsGDR8RUjgrU93oKW
 pFNxje4WDtcrCdEciG7IQ2dzi3Kgp/r0+QhyD0gUVnJtRs7dq/Qtuq9VoSQ3WVpSuqrfNZP0x
 o0iOBlpHjtaSpQpHMVoxQykWwrba/JqgNVUKZCfEqnOlGK3CMZ5JJvNulR14jB+VKo9I513my
 GPYV97Bp0D/XkIiDkIPxz86q2f52i25Apbgw/tGf7NhtkbLcBrD/HhJ5rQuhvJaFbb/xANGzc
 KNL2YOBI5AzAOS+pmXaw5H4Yl2B8mGR6eeo4dTsWwpfn0rucp/KsyZe4METvgRzZKRifZ/Qzq
 VqR9uPfbb6xwR7zvthg4PjiZoTft/+1hLwivufStEK+ImMs/L5Z1vswGnRxUgARynKUyX4h6m
 tvt7ZDRocyxgQA7jGpubGxAOaTaYTmYiE47roivgLYT/5Nv9f5PNNhT99xtBkevS3jBtDc61E
 B4+vGQt3Gg2vlZFmOSpNSsXGSRsHmwoB5hrm02R2B+r59sD79iuCaQ0JFGCwqQTfcSARGPMft
 4AverK4XmyzeEH81Wl7xyNo8oeJFWUMt9EYEVw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In some places, we still used get_seconds() instead of
ktime_get_real_seconds(), and I'm changing the remaining ones now to
all use ktime_get_real_seconds() so we use the full available range for
timestamps instead of overflowing the 'unsigned long' return value in
year 2106 on 32-bit kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/msg.c | 6 +++---
 ipc/sem.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 56fd1c73eedc..574f76c9a2ff 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -758,7 +758,7 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
 				WRITE_ONCE(msr->r_msg, ERR_PTR(-E2BIG));
 			} else {
 				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
-				msq->q_rtime = get_seconds();
+				msq->q_rtime = ktime_get_real_seconds();
 
 				wake_q_add(wake_q, msr->r_tsk);
 				WRITE_ONCE(msr->r_msg, msg);
@@ -859,7 +859,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 	}
 
 	ipc_update_pid(&msq->q_lspid, task_tgid(current));
-	msq->q_stime = get_seconds();
+	msq->q_stime = ktime_get_real_seconds();
 
 	if (!pipelined_send(msq, msg, &wake_q)) {
 		/* no one is waiting for this message, enqueue it */
@@ -1087,7 +1087,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 
 			list_del(&msg->m_list);
 			msq->q_qnum--;
-			msq->q_rtime = get_seconds();
+			msq->q_rtime = ktime_get_real_seconds();
 			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
 			msq->q_cbytes -= msg->m_ts;
 			atomic_sub(msg->m_ts, &ns->msg_bytes);
diff --git a/ipc/sem.c b/ipc/sem.c
index 06be75d9217a..c6a8a971769d 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -104,7 +104,7 @@ struct sem {
 					/* that alter the semaphore */
 	struct list_head pending_const; /* pending single-sop operations */
 					/* that do not alter the semaphore*/
-	time_t	sem_otime;	/* candidate for sem_otime */
+	time64_t	 sem_otime;	/* candidate for sem_otime */
 } ____cacheline_aligned_in_smp;
 
 /* One sem_array data structure for each set of semaphores in the system. */
@@ -984,10 +984,10 @@ static int update_queue(struct sem_array *sma, int semnum, struct wake_q_head *w
 static void set_semotime(struct sem_array *sma, struct sembuf *sops)
 {
 	if (sops == NULL) {
-		sma->sems[0].sem_otime = get_seconds();
+		sma->sems[0].sem_otime = ktime_get_real_seconds();
 	} else {
 		sma->sems[sops[0].sem_num].sem_otime =
-							get_seconds();
+						ktime_get_real_seconds();
 	}
 }
 
-- 
2.9.0

