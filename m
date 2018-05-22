Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389970-1526989249-2-966334758382595258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526989249; b=dSzod5z2zbboEZ30BYXesr/GBpo9CV6HqoPlpxafv/xcPrq+xH
    3nK0CQTq7Viihm7/6DLxh54vSk59nD+9VeB8efvpKEJEV1jMMGRzSe3fhOJRCUXQ
    OwY5L15NdTlWhGDQ6jU1Xa47mwXWE5iJCuuA4IeDdGxp6wN3gDuc8fnI5bxmncjJ
    lDWUWMhd5ry2R/GlQM93liFN7bvrfeCsR9FHO1SM/apLgOvOkOzThV/Mrw1M5SbA
    1jrcEBCDeuRoFBFnob9ZgUkULpaRT0oBftyrZ6VOkHmenaF9DIUnZCW48cKW+8rG
    Hie4wQ+g+FxmOamXEKKNZwpVhNNZcvj+WsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526989249; bh=
    SaJDEdSiBTa1uzFqk0WI7RvH4OcKhTHCmcQo7V77HHI=; b=lXBLUx8+VwIRM0+q
    p0qsve6NqadvZ/eA/4phSdXEulJCHvmct2arfGFnvwElHExIRO1tOeKwR0kmBGpy
    x7toiOJBYAVNDhwmJ03hwTXWHoQKz/VcY6nuK0n7zzW3/ebIjVODbddPAPOpizko
    JLIuv/9j21+mqKmGVv13tARS5P+EvpOCeqv69S0iF5T3EX2WeYsw3Uwui15m/vNu
    ClPaZF4klgx8Mpc/DKYX5MK76l/G0vs930ECEdOwPgsrtNPqNzoWWJSocwhLmJcj
    CrAeUlEM66hIRv6bOVXCMdslH1b7G2zq1MDx4hGZJXgdgG33UiDIpQ11SbNeDz3n
    VJHumA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=uUCK/zc+
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
      header.d=infradead.org header.i=@infradead.org header.b=uUCK/zc+
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
X-CM-Envelope: MS4wfO+0RwlO0tu0BFbqmy93wGQhwFTo+vRdNo8KBZIdN3Fwc1YHf+M0fB8a/hZ3ZEProMdrJyHqmxSvQFML6UmeieBAxvacUvq4NU9Knh3FqQg1+ysUqz8u
    sDr4k88r9zh5Xa8ubapVD7MjJpVVFb6tJ1vHG98PaAYAGdRHhOKDnqvj6iSJ2YZmjctJ8tX3ooFNjCda3Wxtztsosqqx8BczppML4onTcFEqYIN/ARZ7I/5N
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=he-79dIXAyZrIu5XXBoA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeEVLb6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:31:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeEVLbx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:31:53 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/31] aio: implement IOCB_CMD_POLL
Date: Tue, 22 May 2018 13:30:45 +0200
Message-Id: <20180522113108.25713-9-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522113108.25713-1-hch@lst.de>
References: <20180522113108.25713-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Simple one-shot poll through the io_submit() interface.  To poll for
a file descriptor the application should submit an iocb of type
IOCB_CMD_POLL.  It will poll the fd for the events specified in the
the first 32 bits of the aio_buf field of the iocb.

Unlike poll or epoll without EPOLLONESHOT this interface always works
in one shot mode, that is once the iocb is completed, it will have to be
resubmitted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c                     | 134 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/aio_abi.h |   6 +-
 2 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 8991baa38d5d..4d1eabce6659 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -5,6 +5,7 @@
  *	Implements an efficient asynchronous io interface.
  *
  *	Copyright 2000, 2001, 2002 Red Hat, Inc.  All Rights Reserved.
+ *	Copyright 2018 Christoph Hellwig.
  *
  *	See ../COPYING for licensing terms.
  */
@@ -164,10 +165,22 @@ struct fsync_iocb {
 	bool			datasync;
 };
 
+struct poll_iocb {
+	struct file		*file;
+	__poll_t		events;
+	struct wait_queue_head	*head;
+
+	union {
+		struct wait_queue_entry	wait;
+		struct work_struct	work;
+	};
+};
+
 struct aio_kiocb {
 	union {
 		struct kiocb		rw;
 		struct fsync_iocb	fsync;
+		struct poll_iocb	poll;
 	};
 
 	struct kioctx		*ki_ctx;
@@ -1558,7 +1571,6 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
 	if (unlikely(iocb->aio_buf || iocb->aio_offset || iocb->aio_nbytes ||
 			iocb->aio_rw_flags))
 		return -EINVAL;
-
 	req->file = fget(iocb->aio_fildes);
 	if (unlikely(!req->file))
 		return -EBADF;
@@ -1573,6 +1585,124 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
 	return -EIOCBQUEUED;
 }
 
+/* need to use list_del_init so we can check if item was present */
+static inline bool __aio_poll_remove(struct poll_iocb *req)
+{
+	if (list_empty(&req->wait.entry))
+		return false;
+	list_del_init(&req->wait.entry);
+	return true;
+}
+
+static inline void __aio_poll_complete(struct poll_iocb *req, __poll_t mask)
+{
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
+
+	fput(req->file);
+	aio_complete(iocb, mangle_poll(mask), 0);
+}
+
+static void aio_poll_work(struct work_struct *work)
+{
+	struct poll_iocb *req = container_of(work, struct poll_iocb, work);
+
+	__aio_poll_complete(req, req->events);
+}
+
+static int aio_poll_cancel(struct kiocb *iocb)
+{
+	struct aio_kiocb *aiocb = container_of(iocb, struct aio_kiocb, rw);
+	struct poll_iocb *req = &aiocb->poll;
+	struct wait_queue_head *head = req->head;
+	bool found = false;
+
+	spin_lock(&head->lock);
+	found = __aio_poll_remove(req);
+	spin_unlock(&head->lock);
+
+	if (found) {
+		req->events = 0;
+		INIT_WORK(&req->work, aio_poll_work);
+		schedule_work(&req->work);
+	}
+	return 0;
+}
+
+static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
+		void *key)
+{
+	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
+	struct file *file = req->file;
+	__poll_t mask = key_to_poll(key);
+
+	assert_spin_locked(&req->head->lock);
+
+	/* for instances that support it check for an event match first: */
+	if (mask && !(mask & req->events))
+		return 0;
+
+	mask = file->f_op->poll_mask(file, req->events);
+	if (!mask)
+		return 0;
+
+	__aio_poll_remove(req);
+
+	req->events = mask;
+	INIT_WORK(&req->work, aio_poll_work);
+	schedule_work(&req->work);
+	return 1;
+}
+
+static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
+{
+	struct kioctx *ctx = aiocb->ki_ctx;
+	struct poll_iocb *req = &aiocb->poll;
+	__poll_t mask;
+
+	/* reject any unknown events outside the normal event mask. */
+	if ((u16)iocb->aio_buf != iocb->aio_buf)
+		return -EINVAL;
+	/* reject fields that are not defined for poll */
+	if (iocb->aio_offset || iocb->aio_nbytes || iocb->aio_rw_flags)
+		return -EINVAL;
+
+	req->events = demangle_poll(iocb->aio_buf) | POLLERR | POLLHUP;
+	req->file = fget(iocb->aio_fildes);
+	if (unlikely(!req->file))
+		return -EBADF;
+	if (!file_has_poll_mask(req->file))
+		goto out_fail;
+
+	req->head = req->file->f_op->get_poll_head(req->file, req->events);
+	if (!req->head)
+		goto out_fail;
+	if (IS_ERR(req->head)) {
+		mask = EPOLLERR;
+		goto done;
+	}
+
+	init_waitqueue_func_entry(&req->wait, aio_poll_wake);
+	aiocb->ki_cancel = aio_poll_cancel;
+
+	spin_lock_irq(&ctx->ctx_lock);
+	list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
+
+	spin_lock(&req->head->lock);
+	mask = req->file->f_op->poll_mask(req->file, req->events);
+	if (!mask)
+		__add_wait_queue(req->head, &req->wait);
+	spin_unlock(&req->head->lock);
+
+	spin_unlock_irq(&ctx->ctx_lock);
+done:
+	if (mask)
+		__aio_poll_complete(req, mask);
+	return -EIOCBQUEUED;
+out_fail:
+	fput(req->file);
+	return -EINVAL; /* same as no support for IOCB_CMD_POLL */
+}
+
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb, bool compat)
 {
@@ -1641,6 +1771,8 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		break;
 	case IOCB_CMD_FDSYNC:
 		ret = aio_fsync(&req->fsync, iocb, true);
+	case IOCB_CMD_POLL:
+		ret = aio_poll(req, iocb);
 		break;
 	default:
 		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 2c0a3415beee..ed0185945bb2 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -39,10 +39,8 @@ enum {
 	IOCB_CMD_PWRITE = 1,
 	IOCB_CMD_FSYNC = 2,
 	IOCB_CMD_FDSYNC = 3,
-	/* These two are experimental.
-	 * IOCB_CMD_PREADX = 4,
-	 * IOCB_CMD_POLL = 5,
-	 */
+	/* 4 was the experimental IOCB_CMD_PREADX */
+	IOCB_CMD_POLL = 5,
 	IOCB_CMD_NOOP = 6,
 	IOCB_CMD_PREADV = 7,
 	IOCB_CMD_PWRITEV = 8,
-- 
2.17.0

