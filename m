Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684034-1522356365-2-12842846449136979279
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522356364; b=vW22GnGvZPhMkzNfu84RbOWBez+9OOgzalPFbtKnQrdJvODgG6
    AJv4Og8kdAUGJsWXtI74DtXS6L+Et2h0ySx9YrSCtYEtmCccBrNXQZxXIHZTnweb
    0Mza607BmCKZyhfGR3+rEGopyVQBog0CiOX01W4r30DCVu3Yeo7GIL2x4MDwJc82
    Abzjz7MrVJ404+3DYSDv+ouu8pJvkyCbTPunvkVgiRtT8uLQ7rRhACWvkbB9pa0p
    q5ovQZ6W0XbN5Nyo89+I9N1o2ZKpqTTaYbq+nw2zp1dsCYlgXK4RTQ1CrzbCSdY2
    xXhEo+fuDUAjqMNmrzVMKPBTlPuZ4Spo2P7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522356364; bh=
    fo7oLDEdGYA1TmjvJ4dqPxJH63maEIwJWwaITuWPRuE=; b=qrhzjwelaOoxebHR
    6D5y5XqSAS5vIgRxDOersF71cDYB6L+xBnouGwbwjx7ZxjrNrLBCZAQC3O1xXmLZ
    0RRZfgXIyPLZM/HKdpEUSmNvUTVzh9s/vVQRoy7BAzL6VjJVTWAfjfAYpT0bgdQQ
    5N3FcFnRSHd0dEsZ5K9d4VvpK3I/3Guh9kLSrRwud5GCqLV7uPCbAQSPReSr5Y0p
    5Shsp+uzPfPZHoC0GeIsfDjFqPUgejG+1s/7l+im0DiOgWXrbi8eG4op4KIblJaI
    Ooa9XhJog23JCX3sGPS/lj3KyHh/aedwkryUKiVzoEkPp7+4sHXbmOnRfQSsGAaE
    bTg1Cw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=h4Nxve0o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=h4Nxve0o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNWYEWKvr7HHtHnIsvIOCuSsk6Om1JcFVhfcH4zQ2DxQezTOTaCOcBD2osaFhRVtmNmiT0GHX377P2Pvb+p+cKnKvGLGeRDXCWSFRGBuYoGtJ7yuiwe/
    Wdo9e5nOYtCcoyagVOVVz9/nbepATCw9y+KTliMyWVuNpwnVuoI8/gru93J7m066QX8B4jKm63Y/TUp0GBIn679XsbDIWIRi31X0yuCs+mxZvTZH9Fu9/6ig
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=b3adHlZHBvu0lEI6to8A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeC2Ud7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:33:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbeC2Udy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:33:54 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/30] aio: simplify cancellation
Date: Thu, 29 Mar 2018 22:33:04 +0200
Message-Id: <20180329203328.3248-7-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180329203328.3248-1-hch@lst.de>
References: <20180329203328.3248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With the current aio code there is no need for the magic KIOCB_CANCELLED
value, as a cancelation just kicks the driver to queue the completion
ASAP, with all actual completion handling done in another thread. Given
that both the completion path and cancelation take the context lock there
is no need for magic cmpxchg loops either.  If we remove iocbs from the
active list before calling ->ki_cancel we can also rely on the invariant
thay anything found on the list has a ->ki_cancel callback and can be
cancelled, further simplifing the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 49 ++++++-------------------------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 0df07d399a05..c724f1429176 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -162,19 +162,6 @@ struct fsync_iocb {
 	bool			datasync;
 };
 
-/*
- * We use ki_cancel == KIOCB_CANCELLED to indicate that a kiocb has been either
- * cancelled or completed (this makes a certain amount of sense because
- * successful cancellation - io_cancel() - does deliver the completion to
- * userspace).
- *
- * And since most things don't implement kiocb cancellation and we'd really like
- * kiocb completion to be lockless when possible, we use ki_cancel to
- * synchronize cancellation and completion - we only set it to KIOCB_CANCELLED
- * with xchg() or cmpxchg(), see batch_complete_aio() and kiocb_cancel().
- */
-#define KIOCB_CANCELLED		((void *) (~0ULL))
-
 struct aio_kiocb {
 	union {
 		struct kiocb		rw;
@@ -572,27 +559,6 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 }
 EXPORT_SYMBOL(kiocb_set_cancel_fn);
 
-static int kiocb_cancel(struct aio_kiocb *kiocb)
-{
-	kiocb_cancel_fn *old, *cancel;
-
-	/*
-	 * Don't want to set kiocb->ki_cancel = KIOCB_CANCELLED unless it
-	 * actually has a cancel function, hence the cmpxchg()
-	 */
-
-	cancel = READ_ONCE(kiocb->ki_cancel);
-	do {
-		if (!cancel || cancel == KIOCB_CANCELLED)
-			return -EINVAL;
-
-		old = cancel;
-		cancel = cmpxchg(&kiocb->ki_cancel, old, KIOCB_CANCELLED);
-	} while (cancel != old);
-
-	return cancel(&kiocb->rw);
-}
-
 static void free_ioctx(struct work_struct *work)
 {
 	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
@@ -633,9 +599,8 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-
 		list_del_init(&req->ki_list);
-		kiocb_cancel(req);
+		req->ki_cancel(&req->rw);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -1837,8 +1802,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 {
 	struct kioctx *ctx;
 	struct aio_kiocb *kiocb;
+	int ret = -EINVAL;
 	u32 key;
-	int ret;
 
 	ret = get_user(key, &iocb->aio_key);
 	if (unlikely(ret))
@@ -1849,13 +1814,11 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->ctx_lock);
-
 	kiocb = lookup_kiocb(ctx, iocb, key);
-	if (kiocb)
-		ret = kiocb_cancel(kiocb);
-	else
-		ret = -EINVAL;
-
+	if (kiocb) {
+		list_del_init(&kiocb->ki_list);
+		ret = kiocb->ki_cancel(&kiocb->rw);
+	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (!ret) {
-- 
2.14.2

