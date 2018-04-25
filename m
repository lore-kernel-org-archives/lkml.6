Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524669154-2-3453640333392789139
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
    1524669153; b=XGuj3yc14KlmPPSjvkBykq/eBYuilPO4hxVuOqYCEt5zsafzS0
    rmaGASs9Rlx1Z5CP+qthtyah6oVdAbYB0aqxXmYGkONnohNXpXueBh77/nN6sbRW
    zopEg8Hy+/8TVORPc/Gs/g00nTpAGurzDoLltzJA9ch0KjrLUP6hDEeR6647TOzW
    bF4hm0/nKJ8Vpu7MkrDv+O+/SzFiZUBWHOVzQRx0FlRZD1gBoUNagtRltJU3VbE0
    rIom+yaeb/+RwR++mj41G5CyD3bsWTucRbPWk+NYuWtlt4IuOmQkkMrc27mN8fLr
    u3PMXiH7mNdGJZhHK2SyuLQxH8r4DequXtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669153; bh=
    8FrWpl65o1YKDI0KzF2MRkCrrHIZtvoZrbfhhwJrdKM=; b=DNxwbF6rQj/2wIFW
    spa4bIbIB3OxqWGEkknguMFX13oFd2hlzqbmX2mVqZbYldRm7LC4RR1h7dd9LhCC
    02St0dwm9fAVFBed0i8hYFS60V40618mt9rSVJ47HSFl3jJO8AfFTcKvlHqa0ABp
    N8RgWzsB+KI+OlsgHJwQz+gUu0fdBBGd6/5Q95EWFmwaUx1AXAemE3Ugb2bVLKBH
    OqVGIkMMnlKS/QBDdbUCJbrfYdZcyG6cKjRWsuXHH0AB1u3zq2RPsQlFclpn11Az
    /L3pLLIsBZiFRDxdtp70lVJbFqnejRzXRtt7PL3vmv1vi+d6pVws5F+guhR9EJyp
    8+Yurg==
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
X-CM-Envelope: MS4wfMtjlnwojgSq7cBmf3z8UJGpqmxkDwqcnmdhZ2vlLTN3pTtBCZugIv5RKuuA5eES9rgDeZ9s29OrQjqLJF6saW/FWN8UVpmgZdjlY5BaxkhplXH2E7vZ
    TxwHXjNM+h6Ebz3m4krhdNuHeO1SRhUTSraEPLNmbdmmB/UjLb+hqW4PqhJHcEQ2uWh+Qs9fS8D6p8gLxQNp8QFGZF7USTfpPU0UWiI9hDVPQ8olbNYLP+Xn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=JWfEK_nTYSbs3IZf51wA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754969AbeDYPJO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:09:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754866AbeDYPHU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:20 -0400
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
Subject: [PATCH v4 12/16] y2038: ipc: Use ktime_get_real_seconds consistently
Date: Wed, 25 Apr 2018 17:06:02 +0200
Message-Id: <20180425150606.954771-12-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:lcpnyjY3zpI5QLP1cubIh+OF+WTg75stSO6F+EFOKuEIoD4DpDw
 OyyeHq0oFXtR/uhFffhgf/VPAV0uKXnLPQXilyLSYcxnLpjOXdDGBzylvhdUEx6KmSRqe+2
 h2Ymqn5cA+QNQBICFqubng5TdXc9HCdRbvMx+EdUmakwvg3nGRPHn8IT0f1c/Cg/CY7ZSVQ
 Te0lvdTzdF1ZZo7rh+ZUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0GSuoYBPUu8=:6g+iRgz4GwUCeThNrGE2z3
 e5yCaRxYlrxkQzxmVsoSjSFE42YUQ8t0EWyPkirJ/KVZL311TBsZ1DV5hlPGAiqW1wn6AF2b/
 5pZhWVcEHnwZc3LoOAiv8jOVPGWKqn9vtzFDVh1MILW5P/aI+hgkkAkdUbb/gtZKRJl+T0Sdz
 IKKUt4m8K6iTVf2PNyuURPbRXpmEKKgDY+Xvg7nD/AInU1yWBl50P6ZHn27pFxabilKMAAMv1
 CrTTanhr5fbqdHBWO5pYjuLKu1wImmriVlgOXGb3QeyblAoF1s/bRIkhtUbWcHasOwNYaTDro
 74W9zY+f9AkA6NTFOVBoc8GMsQIZjRBcCohGQYZOQEAEMTkBFXXkBQGPD8kn2FVGW0iQP7Nl2
 R4HufrR6SgAHOR5wKSqU0gV1Lm9Wn4liVRusifOP/44KOYpT9HnA7vXc/ZoCNZxP1zQUe0qr3
 fMiOxINmEDPJpnJscmfHvyK5Nz1Vona6HvPjRCsssd3yFWv8fuymJ5YHrJOe4lGow+QnjrjTw
 C0jLvEA84OGpeigtHVObbvRvVWXXOrI6iBR2TUVjUMQIdouVlkMAvKW8oG+rkm9KQERRIpzPP
 hf9JfXuIOqzo6yHu+ism732mxmt3W/Pt/28DpyOLJn9nm2yjJURGqLl2kZSy8YmCl/jW5vtuG
 vyJj82jleHLbv1ZxYlyLpsgdQxwSHt9mo7QD+zI8Oe3Yu4b0Wl5xfRI6JIuSQma4mLSLKIfzR
 CRIiPvDtxAIfucxJSDnZi23h4PEwCn0Uz74Riw==
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

