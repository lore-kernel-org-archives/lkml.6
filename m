Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523804649-2-13475360914387976797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523804648; b=Isj30wIAfm63Za673PzHHCDAUmTf21oj/DuNbhT69YtA3vTTCx
    jvsi30c23Quoi9FQVmFDWCX0XIDR5W2Jx1yYusGNyo/gNsW768DazYqgdvD9mB9e
    UEDGmENGdxpTgfXUN7w7V9dMq77wwxCw+ApKHl7C1HaeThwoaB23bYuDCpNaGVTB
    J2bLGF/2ux29I+lE3vzh8PfMxV0ZrTEWg9Qr3QcpO78Dv3c4b0oyF658eYMFjjzr
    fhJevmJVxkV8x4g1Q0X1pjhtwnBjXaFSAsaFKuW5zJ7QVgDKoAp0YoA1b1IkMQv3
    l5x+EG5U3sjoUSNhssfCuZyj7vu4jbK4aASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523804648; bh=
    YZtx+w3Ey2XDBXzeIYx8tdn2GvrN8gLv/s48jW1pTN8=; b=RIqRk/maUelRaHu1
    Q8rv43auaz0lAzRqP9MQi5SsjEdLbbKHkp2E+rOMVk/YMoD80rd8iFnq3+Pz/2C5
    euR4hucyO8lBaA+mKFoSvBgEbtbk1tdPElA6pqW8a3j5Y8XXpbvl52DRwhbW+mvG
    KTagQtvnjMNW4mp15peQBaRf5fVY1oUQ7FHNzRamQh23ja6Elyk2k77Tv9c9GY/1
    auSGIlCvrq23JVy5c8vaxSXOWFtzD9/iyC21pcPLPe4kAhRFWQ8JTFq3ihrjmcLh
    AC2joZ8ktfOqfCZL8PoxMA/sWumrthl+iTn5LIbDV1fHn6NBQBYIWL/xOD+FhHS8
    u8DnVw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Wq72ga45 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Wq72ga45 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGl6RBjkmyTP3FiwB0Zkm6phc8H8LgekI/NFlHojn3eXsijDvHztwY/frgKnrY9Z9v56OgGwT+oA60Y/VfFSH1gFg/jlpcmGJFAba4GBOUcNLHZWIWFY
    j0vQoMT2n4xJzIMRUYHFjieLdOzG9SR2FfozyZtQHoyfo1IU2r5qruA+enAWloQ2GS8R03ce0r+s9YBnhr216mDsuK6f5iSNrg/GCiJumgQOy3SsYJbFb7s/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Zmq7VYwpCUWw3LpwOMAA:9
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeDOPBf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 11:01:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeDOPBb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 15 Apr 2018 11:01:31 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] aio: sanitize ki_list handling
Date: Sun, 15 Apr 2018 17:01:04 +0200
Message-Id: <20180415150108.1341-4-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415150108.1341-1-hch@lst.de>
References: <20180415150108.1341-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of handcoded non-null checks always initialize ki_list to an
empty list and use list_empty / list_empty_careful on it.  While we're
at it also error out on a double call to kiocb_set_cancel_fn instead
of ignoring it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7c1855afd723..18507743757a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -553,13 +553,12 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ctx->ctx_lock, flags);
-
-	if (!req->ki_list.next)
-		list_add(&req->ki_list, &ctx->active_reqs);
+	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
+		return;
 
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+	list_add_tail(&req->ki_list, &ctx->active_reqs);
 	req->ki_cancel = cancel;
-
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 EXPORT_SYMBOL(kiocb_set_cancel_fn);
@@ -1039,7 +1038,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 		goto out_put;
 
 	percpu_ref_get(&ctx->reqs);
-
+	INIT_LIST_HEAD(&req->ki_list);
 	req->ki_ctx = ctx;
 	return req;
 out_put:
@@ -1107,7 +1106,7 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
 		file_end_write(file);
 	}
 
-	if (iocb->ki_list.next) {
+	if (!list_empty_careful(&iocb->ki_list)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&ctx->ctx_lock, flags);
-- 
2.17.0

