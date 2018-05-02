Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525295774-2-5886615972321144504
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295773; b=cxK0L+jUBzdNRMGaQ6nxwRqATqOjBx+VIDDY/vE1+dgxeQcdsm
    rZrmicyCNKIq4DtXNS8/4+gOIA0s7rYc6L09b2ht/qZI3qz+mXSdQadKGAW5jUKS
    mkOuF/UVc9w9xs9fn5/GlXIY0BDLNIMgMmU0qx9IMFkg663SCkGMX5w2zslohSe/
    UJqcGmgurk9qxUCwt7xp1Q5KK5rLiyNszYWDrOc5a3uYyYqZ2WdE/DJ0HccdIlym
    eL3xjtkAEK4jajfs4RqqwT/l7joktFOiq3MQjqTiABbRKMq7xlW56jQSzddJJDIB
    kvtxk6PltfAKUA6yX3yIbyTHRAcq6Ub6UjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295773; bh=
    YaLhptsgXaBRoJwnWDmZq1gH27POTQUtRI1RReqg5/0=; b=Z/r0nfx+Gx4ty9l9
    iiUZBIM1ERDuTo3388jGQZiOdSB4ocxOdur+ravl89MeN6gEuNvQ2Co+54NYLX4x
    5ZdDSQgYIcUH0JY5xT+tbA6qDKQedL5vjC040TPNwUUKfTMnk9kdoWe9KTG84PRd
    8lTL6Lu1GJhqfHR6i3MXz3TIdYnPCtZq0G0VudyomRxi9ojU+8zwz+IExYCMtyRz
    yjhXG4ncaKIocu53BZvTLpuaMmRl+pc5jdOYDD4+a6FGZBcqkfgPuAngGi29XbTy
    9lLuh5GNt0bx6TB31uCYxsdHA2LeEMmWb9wKtbt9ZZhj8A63Wmb8Qb2PUlRzmDIV
    4xn/Vg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=HFTZnlYZ
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=HFTZnlYZ
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
X-CM-Envelope: MS4wfHDg4m50Hd3G7Mza/gxETZOa8cjnM3qZuJap2fYpskNAn6s7WQMEQ/uWLtCOAr8VGcTk1A50vJGSoZjukLos8iPdV3A3c1AYe89CaZNoCEzKndNfx8+c
    dDR6GapG54OpaRaaZX+7irf2o4fjvESXezQLfs92oiSJtB/WoOsgwS0lQeCFFufHxMtGPiCGGh8Qx4Ak6Q7jfExBEPBLYPwHvF/qyMIRFn4uibUw79afs/ok
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=BU7OBiu2QJBTmSxWuzEA:9
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeEBVPz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:15:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeEBVPP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 17:15:15 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] aio: refactor read/write iocb setup
Date: Wed,  2 May 2018 23:14:46 +0200
Message-Id: <20180502211448.18276-6-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502211448.18276-1-hch@lst.de>
References: <20180502211448.18276-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Don't reference the kiocb structure from the common aio code, and move
any use of it into helper specific to the read/write path.  This is in
preparation for aio_poll support that wants to use the space for different
fields.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c | 161 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 92 insertions(+), 69 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index e5866e2fc331..d07c27b3fe88 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -170,7 +170,9 @@ struct kioctx {
 #define KIOCB_CANCELLED		((void *) (~0ULL))
 
 struct aio_kiocb {
-	struct kiocb		common;
+	union {
+		struct kiocb		rw;
+	};
 
 	struct kioctx		*ki_ctx;
 	kiocb_cancel_fn		*ki_cancel;
@@ -549,7 +551,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 {
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, common);
+	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
@@ -581,7 +583,7 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
 		cancel = cmpxchg(&kiocb->ki_cancel, old, KIOCB_CANCELLED);
 	} while (cancel != old);
 
-	return cancel(&kiocb->common);
+	return cancel(&kiocb->rw);
 }
 
 /*
@@ -1046,15 +1048,6 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	return NULL;
 }
 
-static void kiocb_free(struct aio_kiocb *req)
-{
-	if (req->common.ki_filp)
-		fput(req->common.ki_filp);
-	if (req->ki_eventfd != NULL)
-		eventfd_ctx_put(req->ki_eventfd);
-	kmem_cache_free(kiocb_cachep, req);
-}
-
 static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 {
 	struct aio_ring __user *ring  = (void __user *)ctx_id;
@@ -1085,27 +1078,14 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
-static void aio_complete(struct kiocb *kiocb, long res, long res2)
+static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 {
-	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, common);
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
 	unsigned tail, pos, head;
 	unsigned long	flags;
 
-	if (kiocb->ki_flags & IOCB_WRITE) {
-		struct file *file = kiocb->ki_filp;
-
-		/*
-		 * Tell lockdep we inherited freeze protection from submission
-		 * thread.
-		 */
-		if (S_ISREG(file_inode(file)->i_mode))
-			__sb_writers_acquired(file_inode(file)->i_sb, SB_FREEZE_WRITE);
-		file_end_write(file);
-	}
-
 	if (!list_empty_careful(&iocb->ki_list)) {
 		unsigned long flags;
 
@@ -1167,11 +1147,12 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
 	 * eventfd. The eventfd_signal() function is safe to be called
 	 * from IRQ context.
 	 */
-	if (iocb->ki_eventfd != NULL)
+	if (iocb->ki_eventfd) {
 		eventfd_signal(iocb->ki_eventfd, 1);
+		eventfd_ctx_put(iocb->ki_eventfd);
+	}
 
-	/* everything turned out well, dispose of the aiocb. */
-	kiocb_free(iocb);
+	kmem_cache_free(kiocb_cachep, iocb);
 
 	/*
 	 * We have to order our ring_info tail store above and test
@@ -1434,6 +1415,45 @@ SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
 	return -EINVAL;
 }
 
+static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
+{
+	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
+
+	if (kiocb->ki_flags & IOCB_WRITE) {
+		struct inode *inode = file_inode(kiocb->ki_filp);
+
+		/*
+		 * Tell lockdep we inherited freeze protection from submission
+		 * thread.
+		 */
+		if (S_ISREG(inode->i_mode))
+			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+		file_end_write(kiocb->ki_filp);
+	}
+
+	fput(kiocb->ki_filp);
+	aio_complete(iocb, res, res2);
+}
+
+static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
+{
+	int ret;
+
+	req->ki_filp = fget(iocb->aio_fildes);
+	if (unlikely(!req->ki_filp))
+		return -EBADF;
+	req->ki_complete = aio_complete_rw;
+	req->ki_pos = iocb->aio_offset;
+	req->ki_flags = iocb_flags(req->ki_filp);
+	if (iocb->aio_flags & IOCB_FLAG_RESFD)
+		req->ki_flags |= IOCB_EVENTFD;
+	req->ki_hint = file_write_hint(req->ki_filp);
+	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
+	if (unlikely(ret))
+		fput(req->ki_filp);
+	return ret;
+}
+
 static int aio_setup_rw(int rw, struct iocb *iocb, struct iovec **iovec,
 		bool vectored, bool compat, struct iov_iter *iter)
 {
@@ -1453,7 +1473,7 @@ static int aio_setup_rw(int rw, struct iocb *iocb, struct iovec **iovec,
 	return import_iovec(rw, buf, len, UIO_FASTIOV, iovec, iter);
 }
 
-static inline ssize_t aio_ret(struct kiocb *req, ssize_t ret)
+static inline ssize_t aio_rw_ret(struct kiocb *req, ssize_t ret)
 {
 	switch (ret) {
 	case -EIOCBQUEUED:
@@ -1469,7 +1489,7 @@ static inline ssize_t aio_ret(struct kiocb *req, ssize_t ret)
 		ret = -EINTR;
 		/*FALLTHRU*/
 	default:
-		aio_complete(req, ret, 0);
+		aio_complete_rw(req, ret, 0);
 		return 0;
 	}
 }
@@ -1477,59 +1497,79 @@ static inline ssize_t aio_ret(struct kiocb *req, ssize_t ret)
 static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
 		bool compat)
 {
-	struct file *file = req->ki_filp;
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
+	struct file *file;
 	ssize_t ret;
 
+	ret = aio_prep_rw(req, iocb);
+	if (ret)
+		return ret;
+	file = req->ki_filp;
+
+	ret = -EBADF;
 	if (unlikely(!(file->f_mode & FMODE_READ)))
-		return -EBADF;
+		goto out_fput;
+	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter))
-		return -EINVAL;
+		goto out_fput;
 
 	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
 	if (ret)
-		return ret;
+		goto out_fput;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
-		ret = aio_ret(req, call_read_iter(file, req, &iter));
+		ret = aio_rw_ret(req, call_read_iter(file, req, &iter));
 	kfree(iovec);
+out_fput:
+	if (unlikely(ret && ret != -EIOCBQUEUED))
+		fput(file);
 	return ret;
 }
 
 static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
 		bool compat)
 {
-	struct file *file = req->ki_filp;
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
+	struct file *file;
 	ssize_t ret;
 
+	ret = aio_prep_rw(req, iocb);
+	if (ret)
+		return ret;
+	file = req->ki_filp;
+
+	ret = -EBADF;
 	if (unlikely(!(file->f_mode & FMODE_WRITE)))
-		return -EBADF;
+		goto out_fput;
+	ret = -EINVAL;
 	if (unlikely(!file->f_op->write_iter))
-		return -EINVAL;
+		goto out_fput;
 
 	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
 	if (ret)
-		return ret;
+		goto out_fput;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
 		/*
 		 * Open-code file_start_write here to grab freeze protection,
-		 * which will be released by another thread in aio_complete().
-		 * Fool lockdep by telling it the lock got released so that it
-		 * doesn't complain about the held lock when we return to
-		 * userspace.
+		 * which will be released by another thread in
+		 * aio_complete_rw().  Fool lockdep by telling it the lock got
+		 * released so that it doesn't complain about the held lock when
+		 * we return to userspace.
 		 */
 		if (S_ISREG(file_inode(file)->i_mode)) {
 			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 		}
 		req->ki_flags |= IOCB_WRITE;
-		ret = aio_ret(req, call_write_iter(file, req, &iter));
+		ret = aio_rw_ret(req, call_write_iter(file, req, &iter));
 	}
 	kfree(iovec);
+out_fput:
+	if (unlikely(ret && ret != -EIOCBQUEUED))
+		fput(file);
 	return ret;
 }
 
@@ -1537,7 +1577,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb, bool compat)
 {
 	struct aio_kiocb *req;
-	struct file *file;
 	ssize_t ret;
 
 	/* enforce forwards compatibility on users */
@@ -1560,16 +1599,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	if (unlikely(!req))
 		return -EAGAIN;
 
-	req->common.ki_filp = file = fget(iocb->aio_fildes);
-	if (unlikely(!req->common.ki_filp)) {
-		ret = -EBADF;
-		goto out_put_req;
-	}
-	req->common.ki_pos = iocb->aio_offset;
-	req->common.ki_complete = aio_complete;
-	req->common.ki_flags = iocb_flags(req->common.ki_filp);
-	req->common.ki_hint = file_write_hint(file);
-
 	if (iocb->aio_flags & IOCB_FLAG_RESFD) {
 		/*
 		 * If the IOCB_FLAG_RESFD flag of aio_flags is set, get an
@@ -1583,14 +1612,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			req->ki_eventfd = NULL;
 			goto out_put_req;
 		}
-
-		req->common.ki_flags |= IOCB_EVENTFD;
-	}
-
-	ret = kiocb_set_rw_flags(&req->common, iocb->aio_rw_flags);
-	if (unlikely(ret)) {
-		pr_debug("EINVAL: aio_rw_flags\n");
-		goto out_put_req;
 	}
 
 	ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
@@ -1604,16 +1625,16 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = aio_read(&req->common, iocb, false, compat);
+		ret = aio_read(&req->rw, iocb, false, compat);
 		break;
 	case IOCB_CMD_PWRITE:
-		ret = aio_write(&req->common, iocb, false, compat);
+		ret = aio_write(&req->rw, iocb, false, compat);
 		break;
 	case IOCB_CMD_PREADV:
-		ret = aio_read(&req->common, iocb, true, compat);
+		ret = aio_read(&req->rw, iocb, true, compat);
 		break;
 	case IOCB_CMD_PWRITEV:
-		ret = aio_write(&req->common, iocb, true, compat);
+		ret = aio_write(&req->rw, iocb, true, compat);
 		break;
 	default:
 		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
@@ -1633,7 +1654,9 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 out_put_req:
 	put_reqs_available(ctx, 1);
 	percpu_ref_put(&ctx->reqs);
-	kiocb_free(req);
+	if (req->ki_eventfd)
+		eventfd_ctx_put(req->ki_eventfd);
+	kmem_cache_free(kiocb_cachep, req);
 	return ret;
 }
 
-- 
2.17.0

