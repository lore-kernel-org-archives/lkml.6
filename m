Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526037652-2-10347718639771251245
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
    1526037651; b=JitJikMgE8ee7B5F6LbQFkrfEpLv5FyP2Uqf10lCuoX171whpE
    wOHebWwe10vxiDdSRapvtTowlAuLKyi8xurf1MGLB6E4VgNmeywOXBomcLrKME1J
    cRhURoFtZ5GNp1hc/EVnsbeoQh7B8a6a9pu6RNWrZnHAFvNMrGkWZVAtyjSHBDcT
    tVuL1YdobnB5henBpdUjWBuI9chi9qgiozRpF3TVSWkoDPNvejtubv6WhDoLkVNN
    JR3B1AKiZzd0oH+11u0dd2Eb+jF6/0Hu5IsfK7UBfaoNlBpAqcQfcSdrU5rRlWS3
    iwL7dbUN1EWL0g9iY+7E6q8lSeoWLo9QLyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037651; bh=
    PJ7c0kODGJjajPJhm6lMy/GtBx11DZtVI7n7W2ont/Q=; b=bnWjlSRpS2mrZ8SZ
    Mrr1KQ//sOcztVcpMYx4xUZK5Te028Z4elnVWZgZYL5NGWkO9NyEQ/U5+F24hrlN
    S5NdO6ymmFgyb82zhb2NjOxdUKZu5bJoQ0FaHxBgk0k59IMOBFnzrQe816YKJnvC
    1zeE3bTsS68lZHZNRKvwqJuC966LyEmCh/LhBreqcQaPG4uGNWnyB8An+PuiRT3G
    n5sZbsjmI9rsCwHHRQRQT26u/7+A2nqfM0HrBQIEw9SaA7mokO+/AWVT4zPxPwhq
    swq3YegO7TU0vLzKpSlhXaKrPwLDvHS3q1z/7L2i1SBb7cF14mScJEWQvSCWeMfw
    qStXSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=EKVzVDpq
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
      header.d=infradead.org header.i=@infradead.org header.b=EKVzVDpq
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
X-CM-Envelope: MS4wfC7T/hvIbLKXb4URtBOZoK0V1MiJ7u8RXsixCDstuO9RWW2lPcxg5bSnZbPUO1qTgS4Fy8ZlSUUbC6iaDouXtC6dYzhYRlihgQYAQ66qS2EGp7zGtsBm
    ho8s4pcgdrz1N3Jumueg7C9qUNvQxnTmp5RgOzu6h1vEfKl7q31wUD9erYm6pFh/i2UWCxB+yXr0zNLdrZxmWpN+Xc/3m1f+d8c+9d8bfN0gUMmkKFM2T9kS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=sBy_PAm624FdtEvdJhYA:9
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeEKLUa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:20:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbeEKLIk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:40 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/32] aio: implement IOCB_CMD_POLL
Date: Fri, 11 May 2018 13:07:41 +0200
Message-Id: <20180511110803.10910-11-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
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
Acked-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c                     | 92 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/aio_abi.h |  6 +--
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3afca506c7f0..f2c7674e2151 100644
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
@@ -165,10 +166,18 @@ struct fsync_iocb {
 	bool			datasync;
 };
 
+struct poll_iocb {
+	struct file		*file;
+	__poll_t		events;
+	struct wait_queue_head	*head;
+	struct wait_queue_entry	wait;
+};
+
 struct aio_kiocb {
 	union {
 		struct kiocb		rw;
 		struct fsync_iocb	fsync;
+		struct poll_iocb	poll;
 	};
 
 	struct kioctx		*ki_ctx;
@@ -1569,7 +1578,6 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
 	if (unlikely(iocb->aio_buf || iocb->aio_offset || iocb->aio_nbytes ||
 			iocb->aio_rw_flags))
 		return -EINVAL;
-
 	req->file = fget(iocb->aio_fildes);
 	if (unlikely(!req->file))
 		return -EBADF;
@@ -1584,6 +1592,86 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
 	return -EIOCBQUEUED;
 }
 
+static int aio_poll_cancel(struct aio_kiocb *iocb)
+{
+	remove_wait_queue(iocb->poll.head, &iocb->poll.wait);
+	aio_complete(iocb, iocb->poll.file, 0, 0, AIO_COMPLETE_CANCEL);
+	return 0;
+}
+
+static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
+		void *key)
+{
+	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
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
+	__remove_wait_queue(req->head, &req->wait);
+	aio_complete(iocb, req->file, mangle_poll(mask), 0, 0);
+	return 1;
+}
+
+static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
+{
+	struct kioctx *ctx = aiocb->ki_ctx;
+	struct poll_iocb *req = &aiocb->poll;
+	unsigned long flags;
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+	list_add_tail(&aiocb->ki_list, &ctx->delayed_cancel_reqs);
+	spin_unlock(&ctx->ctx_lock);
+
+	spin_lock(&req->head->lock);
+	mask = req->file->f_op->poll_mask(req->file, req->events);
+	if (!mask)
+		__add_wait_queue(req->head, &req->wait);
+	spin_unlock_irqrestore(&req->head->lock, flags);
+done:
+	if (mask)
+		aio_complete(aiocb, req->file, mangle_poll(mask), 0, 0);
+	return -EIOCBQUEUED;
+out_fail:
+	fput(req->file);
+	return -EINVAL; /* same as no support for IOCB_CMD_POLL */
+}
+
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb, bool compat)
 {
@@ -1652,6 +1740,8 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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

