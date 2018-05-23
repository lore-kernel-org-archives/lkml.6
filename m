Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527104068-2-15287637880158608935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527104068; b=T49Y2RwTyvY33O4g22u+IlsQvcqH+NjzENg8SUQFZq1Z7I8g6K
    Ov3VbfPkDfZn+k5wvKCm19HGaa+gYX1oizM9XTv3oC5TVKWMwf0yhtKv9pCBBjj7
    M048jekMXu4SMFuokQ3+21+7igeBO2ynKT+84k8HTN2hQ6fR2BBmKuELMiGP78Yz
    pwv8+A+oTkJEMbapx3dxZIUQwWszahFxFQgvBvR+G+ZPIoJ+dC9QKlteFd1dYghx
    RZ14p95XXPhk8N3TZTv/ODlexO61+aiAWC8yZvu/rW9A+aHEByzdLTkI54V7aks4
    zQoJRA5x0bO0EdtHLcfMyIN3lAgZlkNqibcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527104068; bh=
    jWzV8yEzk9uv10Y/q8/JWjzgx4frRIjm5VqayLmwd7k=; b=IzCUnOEaN7IeAQU3
    OC53wx3VDiTFXo3wsIwV5pBx0/7i+VwwYvaIQJOzrcpFo+R1sBAaa1IyTyhXdVKV
    9drAG8GNU39D243OULVIf0Rt3r6rF6CtnhWtvDkU294N4xKtd1CxwYy41Q5xnH3l
    WLrA3xhu89QM1Scju1MZC6Y3N1rObHpyv4ANgZNuM/duTbPohtefcHhGqUA9y/h3
    wXBmIczMj6A4V+cOHbtu6xzoRKfZ7o1WtSN2ZZCqQXKqofRsgMUxXGvtcnMUzppF
    R0SZsUGGuwWpNKQ38bkCYG6KzMNU8jm6Yu6OEg2pu/exLg/w7x7M/eAaZLNmgheu
    Smf+pw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=t/FOjuyE
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
      header.d=infradead.org header.i=@infradead.org header.b=t/FOjuyE
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
X-CM-Envelope: MS4wfKW5ctaacpV+nwEkZTCifXLQFzI08DsmVnk7xjzfZ8M6ehr0IH29fkkvjG/6gOGHwtwvBHJ7Mz70r1gy9EGRt87aLBuTBzwpLNnAqifd46/3ybnQBn0V
    IcspwDRdSrBmvC4kgmxCuOOWhUQrNTigBkUSargv0ywmi8sKogbEO1JEmj+xtl4pf0hWQ0VNCJS0JL6hfnBstEMvHdbFssL3Pj/h483o7PvCOSuOVkxnEzTi
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=sdapQSm_P28a7qtZbq0A:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934284AbeEWTda (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:33:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934326AbeEWTUh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:20:37 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/33] fs: cleanup do_pollfd
Date: Wed, 23 May 2018 21:19:53 +0200
Message-Id: <20180523192022.1703-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use straightline code with failure handling gotos instead of a lot
of nested conditionals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/select.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index a87f396f0313..25da26253485 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -812,34 +812,32 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 				     bool *can_busy_poll,
 				     __poll_t busy_flag)
 {
-	__poll_t mask;
-	int fd;
-
-	mask = 0;
-	fd = pollfd->fd;
-	if (fd >= 0) {
-		struct fd f = fdget(fd);
-		mask = EPOLLNVAL;
-		if (f.file) {
-			/* userland u16 ->events contains POLL... bitmap */
-			__poll_t filter = demangle_poll(pollfd->events) |
-						EPOLLERR | EPOLLHUP;
-			mask = DEFAULT_POLLMASK;
-			if (f.file->f_op->poll) {
-				pwait->_key = filter;
-				pwait->_key |= busy_flag;
-				mask = f.file->f_op->poll(f.file, pwait);
-				if (mask & busy_flag)
-					*can_busy_poll = true;
-			}
-			/* Mask out unneeded events. */
-			mask &= filter;
-			fdput(f);
-		}
+	int fd = pollfd->fd;
+	__poll_t mask = 0, filter;
+	struct fd f;
+
+	if (fd < 0)
+		goto out;
+	mask = EPOLLNVAL;
+	f = fdget(fd);
+	if (!f.file)
+		goto out;
+
+	/* userland u16 ->events contains POLL... bitmap */
+	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
+	mask = DEFAULT_POLLMASK;
+	if (f.file->f_op->poll) {
+		pwait->_key = filter | busy_flag;
+		mask = f.file->f_op->poll(f.file, pwait);
+		if (mask & busy_flag)
+			*can_busy_poll = true;
 	}
+	mask &= filter;		/* Mask out unneeded events. */
+	fdput(f);
+
+out:
 	/* ... and so does ->revents */
 	pollfd->revents = mangle_poll(mask);
-
 	return mask;
 }
 
-- 
2.17.0

