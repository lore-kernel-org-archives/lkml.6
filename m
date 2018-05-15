Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3119014-1526414341-2-17911914404245121579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526414340; b=XvZnM4UCDS/htaWRmqoIXBRBRk8eSemeWapPEE3vVdAa7eHpWJ
    uQAY+RxkvPJ6QvFXx5Nr8Stl0DVLn2M1yKlG7z8SrgPtnWQ0N7PzDmaQGnvKPvgj
    2vMzMwcOmu/9pWbpE/8tHqig0Ak7I41yjqp1oYs8hDXtTAOyJRFq83NcpdgSbjnN
    u85Evhht2FpjY7JKeAnmM2dnnlFqfYm4gUHPq6UqDNedw/CT7BI5d8jJO3odaq4W
    E6C+OeHE+90gyRsrHea6u09TDDEeutsTCaHGqAPtTR9lhIl9F/RsCyoAwgRc6tv0
    ixc9elwfstc1zg27ASi8FyUarXhqsQmEbNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526414340; bh=
    qfZUrfHsN4m/iI8MZPm7NS8ZsdwrIB5xDjNVdymXew0=; b=D4E7ZAkGuICl1tyf
    4XnUEom9Dcdzqr9Ok7CxYoigtqiFiWnWSUgId/HuIV+u3mQhSUvu5/q4OIOaHKfD
    EXDsG73aX/D54Ft1O+n8wH4fL0hLsr+EyGxTIip3m8+T2hRf/NwYGk+RVVH0AdKP
    dEtaDsXSQ7FY897eo0OoY1tPuabeVQiBeTZ1CiTycqHqP0YVL5/F4DTHLN5LIFF6
    Cf6v09gsYOs34yJ6vFVlv0x2NV9P/a6DbFfYR3bZ1NY7bnEMfsCfQ7ybKXNeDfbm
    CzNIxQOZsXi32knstThxHI3nCQAoAfeyjlSrHt5SxvUSrXJTKPKqSSqzmsqBF4UV
    BQMnUQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=oia4GB7D
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
      header.d=infradead.org header.i=@infradead.org header.b=oia4GB7D
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
X-CM-Envelope: MS4wfO8EmIP/bNHQ+ZyKm2SSZBqioOalbec3BQc5GniKe9C2XgIVPK77D8YyL86esL1FHf/K6/yk8AZgdq1E87jKzKamI5phOFeUaYu6cbK6Wky9FQN+z2Ez
    symarnva0a9AUDVoSAsCyk5Ijg3+DT7kcKDbYgeR9gW8468w9ZtnsCfY7vJDKcO9VEvbABcXeCelDYoIFak/rL9uHNcbEGf2dljtqfEkt41qniirhOjuluJx
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=vMO4zqW9XEIMtz_2Im8A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeEOTtQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:49:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752544AbeEOTtM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:49:12 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/32] aio: replace kiocb_set_cancel_fn with a cancel_kiocb file operation
Date: Tue, 15 May 2018 21:48:09 +0200
Message-Id: <20180515194833.6906-9-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515194833.6906-1-hch@lst.de>
References: <20180515194833.6906-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The current kiocb_set_cancel_fn implementation assumes the kiocb is
embedded into an aio_kiocb, which is fundamentally unsafe as it might
have been submitted by non-aio callers.  Instead add a cancel_kiocb
file operation that replaced the ki_cancel function pointer set by
kiocb_set_cancel_fn, and only adds iocbs to the active list when
the read/write_iter methods return -EIOCBQUEUED and the file has
a cancel_kiocb method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/gadget/function/f_fs.c | 10 ++--------
 drivers/usb/gadget/legacy/inode.c  |  5 ++---
 fs/aio.c                           | 31 ++++++++++++------------------
 fs/orangefs/orangefs-kernel.h      |  1 -
 include/linux/aio.h                |  7 -------
 include/linux/fs.h                 |  1 +
 6 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 0294e4f18873..531a7206407b 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -26,7 +26,6 @@
 #include <linux/usb/composite.h>
 #include <linux/usb/functionfs.h>
 
-#include <linux/aio.h>
 #include <linux/mmu_context.h>
 #include <linux/poll.h>
 #include <linux/eventfd.h>
@@ -1072,7 +1071,7 @@ ffs_epfile_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int ffs_aio_cancel(struct kiocb *kiocb)
+static int ffs_epfile_cancel_kiocb(struct kiocb *kiocb)
 {
 	struct ffs_io_data *io_data = kiocb->private;
 	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
@@ -1115,9 +1114,6 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	kiocb->private = p;
 
-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
@@ -1160,9 +1156,6 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
 	kiocb->private = p;
 
-	if (p->aio)
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
@@ -1274,6 +1267,7 @@ static const struct file_operations ffs_epfile_operations = {
 	.read_iter =	ffs_epfile_read_iter,
 	.release =	ffs_epfile_release,
 	.unlocked_ioctl =	ffs_epfile_ioctl,
+	.cancel_kiocb = ffs_epfile_cancel_kiocb,
 };
 
 
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 37ca0e669bd8..02ea83c8861a 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/mmu_context.h>
-#include <linux/aio.h>
 #include <linux/uio.h>
 #include <linux/refcount.h>
 #include <linux/delay.h>
@@ -435,7 +434,7 @@ struct kiocb_priv {
 	unsigned		actual;
 };
 
-static int ep_aio_cancel(struct kiocb *iocb)
+static int ep_cancel_kiocb(struct kiocb *iocb)
 {
 	struct kiocb_priv	*priv = iocb->private;
 	struct ep_data		*epdata;
@@ -528,7 +527,6 @@ static ssize_t ep_aio(struct kiocb *iocb,
 	iocb->private = priv;
 	priv->iocb = iocb;
 
-	kiocb_set_cancel_fn(iocb, ep_aio_cancel);
 	get_ep(epdata);
 	priv->epdata = epdata;
 	priv->actual = 0;
@@ -700,6 +698,7 @@ static const struct file_operations ep_io_operations = {
 	.unlocked_ioctl = ep_ioctl,
 	.read_iter =	ep_read_iter,
 	.write_iter =	ep_write_iter,
+	.cancel_kiocb = ep_cancel_kiocb,
 };
 
 /* ENDPOINT INITIALIZATION
diff --git a/fs/aio.c b/fs/aio.c
index 8991baa38d5d..be10dde20c8e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -171,7 +171,6 @@ struct aio_kiocb {
 	};
 
 	struct kioctx		*ki_ctx;
-	kiocb_cancel_fn		*ki_cancel;
 
 	struct iocb __user	*ki_user_iocb;	/* user's aiocb */
 	__u64			ki_user_data;	/* user's data for completion */
@@ -545,22 +544,6 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
 #define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
 
-void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
-{
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
-	struct kioctx *ctx = req->ki_ctx;
-	unsigned long flags;
-
-	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
-		return;
-
-	spin_lock_irqsave(&ctx->ctx_lock, flags);
-	list_add_tail(&req->ki_list, &ctx->active_reqs);
-	req->ki_cancel = cancel;
-	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-}
-EXPORT_SYMBOL(kiocb_set_cancel_fn);
-
 /*
  * free_ioctx() should be RCU delayed to synchronize against the RCU
  * protected lookup_ioctx() and also needs process context to call
@@ -608,7 +591,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
 		list_del_init(&req->ki_list);
-		req->ki_cancel(&req->rw);
+		req->rw.ki_filp->f_op->cancel_kiocb(&req->rw);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -1447,6 +1430,16 @@ static inline ssize_t aio_rw_ret(struct kiocb *req, ssize_t ret)
 {
 	switch (ret) {
 	case -EIOCBQUEUED:
+		if (req->ki_filp->f_op->cancel_kiocb) {
+			struct aio_kiocb *iocb =
+				container_of(req, struct aio_kiocb, rw);
+			struct kioctx *ctx = iocb->ki_ctx;
+			unsigned long flags;
+
+			spin_lock_irqsave(&ctx->ctx_lock, flags);
+			list_add_tail(&iocb->ki_list, &ctx->active_reqs);
+			spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+		}
 		return ret;
 	case -ERESTARTSYS:
 	case -ERESTARTNOINTR:
@@ -1824,7 +1817,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	kiocb = lookup_kiocb(ctx, iocb);
 	if (kiocb) {
 		list_del_init(&kiocb->ki_list);
-		ret = kiocb->ki_cancel(&kiocb->rw);
+		ret = kiocb->rw.ki_filp->f_op->cancel_kiocb(&kiocb->rw);
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index c29bb0ebc6bb..5cd598c59bdc 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -34,7 +34,6 @@
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
 
-#include <linux/aio.h>
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/compat.h>
diff --git a/include/linux/aio.h b/include/linux/aio.h
index b83e68dd006f..42e3cc953005 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -4,20 +4,13 @@
 
 #include <linux/aio_abi.h>
 
-struct kioctx;
-struct kiocb;
 struct mm_struct;
 
-typedef int (kiocb_cancel_fn)(struct kiocb *);
-
 /* prototypes */
 #ifdef CONFIG_AIO
 extern void exit_aio(struct mm_struct *mm);
-void kiocb_set_cancel_fn(struct kiocb *req, kiocb_cancel_fn *cancel);
 #else
 static inline void exit_aio(struct mm_struct *mm) { }
-static inline void kiocb_set_cancel_fn(struct kiocb *req,
-				       kiocb_cancel_fn *cancel) { }
 #endif /* CONFIG_AIO */
 
 /* for sysctl: */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4b6045ebb2f2..7fe64df9eb09 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1742,6 +1742,7 @@ struct file_operations {
 			u64);
 	ssize_t (*dedupe_file_range)(struct file *, u64, u64, struct file *,
 			u64);
+	int (*cancel_kiocb)(struct kiocb *);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.17.0

