Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-639720-1527104105-2-14620573317030317425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527104104; b=U9iM8fS9whfXO/kcm/Ui9qgtGuxPDdqIMN5VIRyfioA4zfa2PK
    xsCA0eM34bQ5Ek9fCPwIw6F/ErUmjNngqKAys5IWJZ0RmnAovk5xA9oKh7Rfft9F
    yi/NCdYEr+iE1t1Zxr419Vl9Y91Lzq0EKSpi8j7bH5CFblOi5MQG2nurLK2B5zbO
    FdCN0ZSz1ilbOvfIbCs3taQ7ReDZp/t2OTXv5vTTdcBzzeEdPv0oCILdcChXncQD
    wX8C1gQFm4R9BBHNK91FLJVe0k8IsNJhXlOgTipYvRt1qO5AYLBjDib72vwE0uME
    W8RVl0c3PG8Vs9+ehz6R9phvhY89KYzNGyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527104104; bh=
    9uJ/9rkyQkHxVxsxFFs+avSoniZM4kOrtCAaQkrMDb0=; b=heUDMDOzJzRvm2xj
    NrUCpGXxybRppWvBROFGl59r2a7iPzPwKZgfE6hy3oc+8Wji/XATEctLgJhy014T
    szGtiT9HLJg9aglVQSiaNvlkTKnp6/oUiK7QSxux2CiGMBeISOYaQIleNc1pSB0d
    +kzeFNgpi30Q3uxJEu/sy8EOdMuextRkdjx+8u+GS+fmoR34qNDFV5rAkRJVGSKb
    Wc+6eFrJAifWj7fXGdhMMubFO51sVPK2IODtx7GSCxngRCthGUYMQC1SoIk+gAJY
    6eYr4HiGht6DS48YCQO9zMwVocG18eYkkSuxSWbL8e4lDQ9aL+mgL0SMOAJA/V82
    vLl0mg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=uILGLEP9
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=uILGLEP9
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
X-CM-Envelope: MS4wfIU8+abt9T2RxlXtdIUhUPfXobSK4TURAgk81XVOg6h57jePYWO2++yDTJfXVBHN534GAoGANXMhucKzq2DCXbFkIKNJj3ufoxBRZi5gHu2gWSQZrMO5
    0cYifVgsKwGFDrkTjqaNFmLj0ojVmKZcuHpc6aIQtb8xAhyhiYswBTh62bysD+Mjj9b2zhG5l6Dnc5HRiMOCHpfmGeaU5wSe2s/VO5lGjL0i2ZSVxqxVr6as
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=drOt6m5kAAAA:8
    a=VwQbUJbxAAAA:8 a=32GxPdB41DALxrjWDjkA:9 a=ZIexoJY8WHTOOgZQ:21
    a=xH4ctsHu6irhgxCo:21 a=x8gzFH9gYPwA:10 a=RMMjzBEyIzXRtoq5n5K6:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934282AbeEWTUe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:20:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934256AbeEWTU3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:20:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: [PATCH 01/33] fix io_destroy()/aio_complete() race
Date: Wed, 23 May 2018 21:19:50 +0200
Message-Id: <20180523192022.1703-2-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

If io_destroy() gets to cancelling everything that can be cancelled and
gets to kiocb_cancel() calling the function driver has left in ->ki_cancel,
it becomes vulnerable to a race with IO completion.  At that point req
is already taken off the list and aio_complete() does *NOT* spin until
we (in free_ioctx_users()) releases ->ctx_lock.  As the result, it proceeds
to kiocb_free(), freing req just it gets passed to ->ki_cancel().

Fix is simple - remove from the list after the call of kiocb_cancel().  All
instances of ->ki_cancel() already have to cope with the being called with
iocb still on list - that's what happens in io_cancel(2).

Cc: stable@kernel.org
Fixes: 0460fef2a921 "aio: use cancellation list lazily"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 755d3f57bcc8..1c383bb44b2d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -639,9 +639,8 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-
-		list_del_init(&req->ki_list);
 		kiocb_cancel(req);
+		list_del_init(&req->ki_list);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
-- 
2.17.0

