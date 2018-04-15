Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523804585-2-5804804684048967800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523804585; b=D2NuWfTHJiHzaWhXEru3pe14cO/LSr+FSww/jYz69knwOdumHI
    4c55bVAOKtwf0SHd3TMsSkQv8+7M6PzknM/aOLGKWtp8XG8ob0ud3CCS1tVhWnpI
    jws/HqI0MMV5ek2soKAZP3Hly06jEmS/qHmyPROoYy15jeHHEGVLYrZNRIv6E0kE
    cytLwNreHBMRuj4P8Gkl6p3IzFa1zie05lrFCzrFBvOqP+e6jFl2TqUVVpcwobtF
    HWZy36VBHQzRn9vw0XfPFQqo+5thgj5BCUTodHaw6Bdho3PNpsROrPk1NbPnkdNf
    4r/bdXP+vdsR28qXZKZxhdqBfEZo2YoBUbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523804585; bh=
    VYduZ9WTa8HKMfSngBmZewaoixJ2zwHImPsKQShoR3g=; b=lGfcYig88iHHSC58
    gFwV+k3MWnDDRPWHlzikwOaRiU4qJynumfHHElOcPiDcNrFPI0hFw44txI9rbPuU
    xREgwYaAmApzu93UB9otOe2Xe7IpQAUaYVtXx63drfXVQdcMjddbIOK4O5mASh02
    bfzePFm56lIf1xKwJHp+cP/kWVf+i7J+UO9IPHyLdVNPImXhBF01CcBndrbVnaVX
    n4vXkAhzvqfU7HhgN5f9Nyq7+gcDWdESgPTk8CSyfb37DgPOCVdxV1JF5NFxhaav
    cFW4Ub/w4MwrYKUJM8Ujxb08JKaOmAGQKbYEEmkFNHNCd5C4Rgkm30XYPI1/BCoB
    1HoGQw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dHRPkXF2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dHRPkXF2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ6Bx5fVZoMMDoZCChlLgBsUBOciFpSd5vO63wTY7AqM4dHtfuUq8/45+9iyAHz6ly8J4nE/RJ9+/ZS5ewyFNOG5r6c1sMdC+iRgBq58N9VuPN0NCU5J
    SLqR9tEanC+bdB4DLkL68Kwk+WtF3HpB6GgDQL65ZQ3fdObsy9fp+ZkSZoAPsQ2TQ/ryR2yqE5s8iPIpc2IQxGJdWN3IsvxJJyQ2qKVUwOy8aHtSRUQCNk2A
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=WnEx2ZbQ94QqvHYnlNwA:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeDOPBk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 11:01:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753006AbeDOPBh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 15 Apr 2018 11:01:37 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] aio: implement IOCB_CMD_FSYNC and IOCB_CMD_FDSYNC
Date: Sun, 15 Apr 2018 17:01:07 +0200
Message-Id: <20180415150108.1341-7-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415150108.1341-1-hch@lst.de>
References: <20180415150108.1341-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Simple workqueue offload for now, but prepared for adding a real aio_fsync
method if the need arises.  Based on an earlier patch from Dave Chinner.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index d4dd002712c8..de56496ba86c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -156,6 +156,12 @@ struct kioctx {
 	unsigned		id;
 };
 
+struct fsync_iocb {
+	struct work_struct	work;
+	struct file		*file;
+	bool			datasync;
+};
+
 /*
  * We use ki_cancel == KIOCB_CANCELLED to indicate that a kiocb has been either
  * cancelled or completed (this makes a certain amount of sense because
@@ -172,6 +178,7 @@ struct kioctx {
 struct aio_kiocb {
 	union {
 		struct kiocb		rw;
+		struct fsync_iocb	fsync;
 	};
 
 	struct kioctx		*ki_ctx;
@@ -1571,6 +1578,36 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
 	return ret;
 }
 
+static void aio_fsync_work(struct work_struct *work)
+{
+	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
+	int ret;
+
+	ret = vfs_fsync(req->file, req->datasync);
+	fput(req->file);
+	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
+}
+
+static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
+{
+	if (unlikely(iocb->aio_buf || iocb->aio_offset || iocb->aio_nbytes ||
+			iocb->aio_rw_flags))
+		return -EINVAL;
+
+	req->file = fget(iocb->aio_fildes);
+	if (unlikely(!req->file))
+		return -EBADF;
+	if (unlikely(!req->file->f_op->fsync)) {
+		fput(req->file);
+		return -EINVAL;
+	}
+
+	req->datasync = datasync;
+	INIT_WORK(&req->work, aio_fsync_work);
+	schedule_work(&req->work);
+	return -EIOCBQUEUED;
+}
+
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb, bool compat)
 {
@@ -1634,6 +1671,12 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	case IOCB_CMD_PWRITEV:
 		ret = aio_write(&req->rw, iocb, true, compat);
 		break;
+	case IOCB_CMD_FSYNC:
+		ret = aio_fsync(&req->fsync, iocb, false);
+		break;
+	case IOCB_CMD_FDSYNC:
+		ret = aio_fsync(&req->fsync, iocb, true);
+		break;
 	default:
 		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
 		ret = -EINVAL;
-- 
2.17.0

