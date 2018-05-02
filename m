Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1359032-1525295789-2-17565987425819852662
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295789; b=RJNo/M8sp4q6y9AFyCNL4XTdR4AFC4vJxU18lRhwEC93vw8AIg
    FSdhq1zdG3cDF5CJ5fMV5y1LIIOKOypmDOr5g4aEMIXU3+bMLGqpoVMmThtngpsF
    bQOz+ZJT7dYMXIvItjaoXvsJGjufk2LUVMAHySw40LLQEpYkICi75Yyz9JKRyqS7
    Lm03dch3BH7pi+aDnH13fKGySfzO2CyvalGWkWdA/P6peruVjXcB+E3Qh4nR6lFn
    bZZSdZMNFt3mQn+ECDkBPiM5C8RIOYcFDYf4PLFP/ZfabcOFQ0xY0kL0TR4g6N3Z
    EVUmQlXSqWLYGpfy11qKacIKIBE6UEVefJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295789; bh=
    YZtx+w3Ey2XDBXzeIYx8tdn2GvrN8gLv/s48jW1pTN8=; b=gGYdwaePaodFmVZp
    IC1jLgwZXDFYK9pUp17DMcckOyNZbpF93dHPmx9kv4WFQt0NAs+QRKFx1e6tdLGP
    JMQ0Cs+gUkWRL6Q++xKhaX3mfnI/ZEqoHRQEQe0ubDzT7eE4A15o7+odJlnyo0NY
    LaQvWjNyZipYVPCfXK4pMESolz1ISUfR6tmkduaETBhbLIGsVCYGLiUL+hi8j5Sj
    qQWKm7QHsjwz3MoSJv+6xSie+k6G/zZhqwJLyVHS7uDHGy/mvHlMPJnIsAI01ur5
    m+IFVejG43z5OyceMCMCbHvCqrWHtgwKU95v6FjKu38wyAca+NMGpF0HOH3Df6jK
    FVJ+/Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=c7n16Pmj
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=c7n16Pmj
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNMmKYmm1UJBrLOWUydyWfoq2ibqgVZE1WOTC9JpV46ilPHl9+lP8QMhPtRgwi6yZcW/GUJp/jLDvIIMIkt4pVe4ET4cWjYCZ58qJxNQa9flbQLAAaJP
    uE2xIg1Z52xz39M7fTdxdHU6JwtLj8QiE+vWMaYdSJe4yaI0l20ps+3mIcV0sTvdtHKhdbHYJJynrHFicbswcyfUkfYyaP34zYNDFatN8XSwRQas5idCw+ga
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Zmq7VYwpCUWw3LpwOMAA:9
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeEBVQP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:16:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeEBVPH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 17:15:07 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] aio: sanitize ki_list handling
Date: Wed,  2 May 2018 23:14:44 +0200
Message-Id: <20180502211448.18276-4-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502211448.18276-1-hch@lst.de>
References: <20180502211448.18276-1-hch@lst.de>
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

