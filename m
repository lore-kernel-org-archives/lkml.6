Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582301-1527103903-2-4603388885727140574
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527103902; b=lJTZCt9X94y/pZGdf3o7YxLAx9s7q/YT9PaVyXLUi+QRQZM2kt
    H852rEa4ZHn4vosGNdLpHoKIWG5XNDRmT87zJaOnlhai5sICCmw/7sqER9Ttthna
    kdWRLDyNLOCs9ue7XY64y5hC2jpkuFJy/dU2YnS+gR10XUkAtSaOecWIBl87Acza
    aHRrmBJLFuDHYbK7jor6LpKkt4WKTi9PUqdkIUhClzW+CEaQcRW9VoGBR01AtdkZ
    TaBc2eV513qA6nriq7hcPBZ2yQKFQqdRr08ZV+JfSSBHVxqK1FhLFFPUgXxqdWC5
    Lm1T1ho0lFOuTO1lJVPZJsjLy/32h4L5bKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103902; bh=
    FeeFSBPXQnnQjliKLzqEPghNPOUIx/ctsEs29iu+0zc=; b=ZB9jP7MwrZ5Sywgz
    s8GfvhXFZ0H+g2q0BmLusc+kyo/78QLQIf8n5ZEph85czFOFPcQXioFLj7KJsNOs
    52Ci7lhuZUV38uv8jxo213gYVli9zRgRUqD6EN7aWdqlpfs5zs9E9q0kGL2cbXnr
    3tbVSu0LW2Do588AEFc+8etSntqzDIw/f7DlD5rT8A2jUHCu56ghMlXO32egVoLz
    kGAghfc4zXWcG6VzMi0kucQTLFHBpEFyPe+gEu8kmcgHVQMibdIkO36UEs8Am8AU
    ruJozcSfYcEwcbup9zGccnvCiQEfqjqtyNPNjA25+Xa/VeKHldVoKQ8MbOPUHlNI
    KjKo5A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=uTK/6sHe
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=uTK/6sHe
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
X-CM-Envelope: MS4wfE8ozQNQk0gUMTPWPi+oVKHFORiid2TJ2aJXpeJzXGaPSsLkQHXMLW7D5GRoff7w5T7ku3LV+NRShHgwqW0/FAU8bxuDGb5aXFf2dGvtpAEiNuB/lpGj
    zAoLqtQfrymviK1tyo1YECLiYgyBkrmeVCOftv9fKRRikr6t1it9u2Las7ldq5WtQupkVf3YglYCw6Q/ZRRS6j1AQ50VxhOwniRdDUP4QYlO3iFVgC0hVOau
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=c5ubECay0r_8uFjs2PcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934378AbeEWTUy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:20:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934351AbeEWTUu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:20:50 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/33] aio: simplify KIOCB_KEY handling
Date: Wed, 23 May 2018 21:19:57 +0200
Message-Id: <20180523192022.1703-9-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No need to pass the key field to lookup_iocb to compare it with KIOCB_KEY,
as we can do that right after retrieving it from userspace.  Also move the
KIOCB_KEY definition to aio.c as it is an internal value not used by any
other place in the kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c            | 14 +++++++-------
 include/linux/aio.h |  2 --
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 1c383bb44b2d..50a90e5581ed 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -46,6 +46,8 @@
 
 #include "internal.h"
 
+#define KIOCB_KEY		0
+
 #define AIO_RING_MAGIC			0xa10a10a1
 #define AIO_RING_COMPAT_FEATURES	1
 #define AIO_RING_INCOMPAT_FEATURES	0
@@ -1811,15 +1813,12 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
  *	Finds a given iocb for cancellation.
  */
 static struct aio_kiocb *
-lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb, u32 key)
+lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb)
 {
 	struct aio_kiocb *kiocb;
 
 	assert_spin_locked(&ctx->ctx_lock);
 
-	if (key != KIOCB_KEY)
-		return NULL;
-
 	/* TODO: use a hash or array, this sucks. */
 	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
 		if (kiocb->ki_user_iocb == iocb)
@@ -1846,9 +1845,10 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	u32 key;
 	int ret;
 
-	ret = get_user(key, &iocb->aio_key);
-	if (unlikely(ret))
+	if (unlikely(get_user(key, &iocb->aio_key)))
 		return -EFAULT;
+	if (unlikely(key != KIOCB_KEY))
+		return -EINVAL;
 
 	ctx = lookup_ioctx(ctx_id);
 	if (unlikely(!ctx))
@@ -1856,7 +1856,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 
 	spin_lock_irq(&ctx->ctx_lock);
 
-	kiocb = lookup_kiocb(ctx, iocb, key);
+	kiocb = lookup_kiocb(ctx, iocb);
 	if (kiocb)
 		ret = kiocb_cancel(kiocb);
 	else
diff --git a/include/linux/aio.h b/include/linux/aio.h
index 9d8aabecfe2d..b83e68dd006f 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -8,8 +8,6 @@ struct kioctx;
 struct kiocb;
 struct mm_struct;
 
-#define KIOCB_KEY		0
-
 typedef int (kiocb_cancel_fn)(struct kiocb *);
 
 /* prototypes */
-- 
2.17.0

