Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1359032-1525295718-2-2137070658928377029
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
    1525295718; b=nH79Tpzu53o1PMdaeDo46GCKi3RlKm3PG/E+MXHhMB9MCjVvhN
    y7fRux0QqaBrAIjGYPN1Kdy0Ugps0GrRhUwnQRuRZWUBopgsS5rAn51UhnroA7kV
    fDfsUVXOkQGGxUxnK+sWRmrTAjOC7Rqt6BYsptQAZqyZ11ICFEgfKbMfswmFf765
    ITO04k680bslREOLeXDj0PWAeZg2Yvddd8ARIUvyRk+apzKWDiQyQUQgRL2WYxfB
    otxnOqd/yhr8bIaSoQGnZMLndVBPI9sjaDRQuRUmulBGFxEK0kgOPbb6a4/jT0DG
    tCH58nxh9/c0/4jyJQfwrIKJyMpi/fBIP8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295718; bh=
    GANtgY1CR9a5GvYAtJfRBOyXwvtXRO8SwTNKOANyDTg=; b=lU1vN1h+ysigIxij
    6ayn3thnxq7OFKSVNh3pfjp2sHLwDQ8MXIpvupVytQC10kHYyWPrrNb7VV0S8jdg
    k0fjTS/0+/7yn+5O2hfIs8w8fgvvaES92i+ZxVzW4jijEJXyfweup1U9TWU1CzAf
    ZoEBj69xEF78sSz0dx1/AYfh+ucLw0l9nwweKcVGqyZT1ODet2xx7Cvw/d3uC6Vn
    bI/XVuSrp4Usvl57tov6fOTS7EpGAvXrmtbA4DBIgjCxh7tL4usRDcNP2FrYMnDh
    BsnkfQoHqQ7BtIba5D7USDhs1h8kE6gt/f4mO3yDGyYv1bS4SrH9DS2IEIIvOTcF
    jR2mJA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=TKzIE9lv
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
      header.d=infradead.org header.i=@infradead.org header.b=TKzIE9lv
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
X-CM-Envelope: MS4wfOHTimY9fV+3iZofLrjFWWTpCLIwCGFFPrxW/e8Vnz0vjocNJhNWWCLIAuWsf6acGdNqfaKys06WOywbc9B5aiY3nSPrzG5eAPNxukxhr1fF/HMbT1rM
    kBPvPkzWu+xtM1OyTI7GLx56nxLnwZ32XuuiXIKVeT61CeseGziLQLJEm8yDnE0TmgyZV72BmV82Ff9Q58vmIzejQgU6h3l5UL+6kYdjqDANcBRS9lZIVEF+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=zxD_tP9ePE1xXreKThgA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeEBVPP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:15:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeEBVPL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 17:15:11 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] aio: remove the extra get_file/fput pair in io_submit_one
Date: Wed,  2 May 2018 23:14:45 +0200
Message-Id: <20180502211448.18276-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502211448.18276-1-hch@lst.de>
References: <20180502211448.18276-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If we release the lockdep write protection token before calling into
->write_iter and thus never access the file pointer after an -EIOCBQUEUED
return from ->write_iter or ->read_iter we don't need this extra
reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 18507743757a..e5866e2fc331 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1515,16 +1515,19 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
-		req->ki_flags |= IOCB_WRITE;
-		file_start_write(file);
-		ret = aio_ret(req, call_write_iter(file, req, &iter));
 		/*
-		 * We release freeze protection in aio_complete().  Fool lockdep
-		 * by telling it the lock got released so that it doesn't
-		 * complain about held lock when we return to userspace.
+		 * Open-code file_start_write here to grab freeze protection,
+		 * which will be released by another thread in aio_complete().
+		 * Fool lockdep by telling it the lock got released so that it
+		 * doesn't complain about the held lock when we return to
+		 * userspace.
 		 */
-		if (S_ISREG(file_inode(file)->i_mode))
+		if (S_ISREG(file_inode(file)->i_mode)) {
+			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+		}
+		req->ki_flags |= IOCB_WRITE;
+		ret = aio_ret(req, call_write_iter(file, req, &iter));
 	}
 	kfree(iovec);
 	return ret;
@@ -1599,7 +1602,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	req->ki_user_iocb = user_iocb;
 	req->ki_user_data = iocb->aio_data;
 
-	get_file(file);
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
 		ret = aio_read(&req->common, iocb, false, compat);
@@ -1618,8 +1620,13 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		ret = -EINVAL;
 		break;
 	}
-	fput(file);
 
+	/*
+	 * If ret is -EIOCBQUEUED, ownership of the file reference acquired
+	 * above passed to the file system, which at this point might have
+	 * dropped the reference, so we must be careful to not reference it
+	 * once we have called into the file system.
+	 */
 	if (ret && ret != -EIOCBQUEUED)
 		goto out_put_req;
 	return 0;
-- 
2.17.0

