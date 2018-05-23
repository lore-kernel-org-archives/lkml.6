Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582301-1527103715-2-3887509760614856738
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527103715; b=iEQj7TJiitR4Tf5iKX8DM0/YlfDaQ30GLLzjZ23RRELovB0bbm
    q4JFo/wIPTzq6ztSo7OZmV9Nj4CTe2QHNGt1tPsA6q+sYJdu8BG/j0MsPUFzn/8f
    IHafuUmKBxwEHqNOKB5jXeEn94MR5ad/UcRtymC+1DtSywyG1Jcfz63BEyTg6fic
    z51P6JJTfmR2cMGMY8Bunx66nKMfRJa2g2Srtlip+GvzjWD8TviG4e9GmslNs/vi
    rbd4ZzM15d9M5d0E80I8tbQqWhwkXyblTHoBu2TAUUWzmXVNqXrOJb3qyr5onnN6
    fEoj3b5QKZ0ysBHrVc958+QuGprM2P/zcUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103715; bh=
    eSichode1YTYYBLjg83lrV4Xf9sw0lYKDpzqc6qFg+Y=; b=dmcz0P/G38zeiZFQ
    jt77PhI7J5fyOO/NzlfC87yA2Z50CvD5fF8K909pxC9OPkmWSO3iQCtZaGBe07Vn
    WAUjkBhJ8e8gwjeSUdWAvUWYi9If4LWJr599dLl6cdejX2fVLo+beHxsfmvyKaBq
    35RjrToEnPUJqDavRkAfmUOtC5G1+5GEpCBiugj2MALMxalK/fn50LqCLlq9yLqP
    Rkqmnr4JJZz1SiS+71qgnNlZY0e591+vK0QSED+OZav6cpZ7ew5gQPkHdV/Q4xRq
    IxUZjUbv7fDyeK2Zs9fDS1Vfs2EgJvHeMOaa96ACeuzandBrj9gSt33OyRQlNSWY
    TRlyxQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=i6AgAAFx
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
      header.d=infradead.org header.i=@infradead.org header.b=i6AgAAFx
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
X-CM-Envelope: MS4wfLayEECLITjXsIDoiEtg+rUkB2zyQf17vcKPwjI0EhRcWi5kxT5ABYW91aF+uQt95z0E1eRc8aHzQYDNfYTFHJFpJju5TdTmLavUH0ljy5w8Kqc6VmTo
    Jjs8XrLicrWFLDMSF1qZPFssgyW4Tbe1YpascLQr1nP9ohxvGRK+NxGEVtktrbKTw9kjTu/M9KGEQjqf0BJtXgeC+OmYhCey9ZpfRJrnYnHTeMPhGrruQscj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=0xgVzqWtobIYM8LKUaMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934694AbeEWT2a (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:28:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934299AbeEWTVM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:21:12 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/33] net/unix: convert to ->poll_mask
Date: Wed, 23 May 2018 21:20:05 +0200
Message-Id: <20180523192022.1703-17-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/unix/af_unix.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e5473c03d667..95b02a71fd47 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -638,9 +638,8 @@ static int unix_stream_connect(struct socket *, struct sockaddr *,
 static int unix_socketpair(struct socket *, struct socket *);
 static int unix_accept(struct socket *, struct socket *, int, bool);
 static int unix_getname(struct socket *, struct sockaddr *, int);
-static __poll_t unix_poll(struct file *, struct socket *, poll_table *);
-static __poll_t unix_dgram_poll(struct file *, struct socket *,
-				    poll_table *);
+static __poll_t unix_poll_mask(struct socket *, __poll_t);
+static __poll_t unix_dgram_poll_mask(struct socket *, __poll_t);
 static int unix_ioctl(struct socket *, unsigned int, unsigned long);
 static int unix_shutdown(struct socket *, int);
 static int unix_stream_sendmsg(struct socket *, struct msghdr *, size_t);
@@ -681,7 +680,7 @@ static const struct proto_ops unix_stream_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	unix_accept,
 	.getname =	unix_getname,
-	.poll =		unix_poll,
+	.poll_mask =	unix_poll_mask,
 	.ioctl =	unix_ioctl,
 	.listen =	unix_listen,
 	.shutdown =	unix_shutdown,
@@ -704,7 +703,7 @@ static const struct proto_ops unix_dgram_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	unix_getname,
-	.poll =		unix_dgram_poll,
+	.poll_mask =	unix_dgram_poll_mask,
 	.ioctl =	unix_ioctl,
 	.listen =	sock_no_listen,
 	.shutdown =	unix_shutdown,
@@ -726,7 +725,7 @@ static const struct proto_ops unix_seqpacket_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	unix_accept,
 	.getname =	unix_getname,
-	.poll =		unix_dgram_poll,
+	.poll_mask =	unix_dgram_poll_mask,
 	.ioctl =	unix_ioctl,
 	.listen =	unix_listen,
 	.shutdown =	unix_shutdown,
@@ -2630,13 +2629,10 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wait)
+static __poll_t unix_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	__poll_t mask = 0;
 
 	/* exceptional events? */
 	if (sk->sk_err)
@@ -2665,15 +2661,11 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
 	return mask;
 }
 
-static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
-				    poll_table *wait)
+static __poll_t unix_dgram_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk, *other;
-	unsigned int writable;
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	int writable;
+	__poll_t mask = 0;
 
 	/* exceptional events? */
 	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
@@ -2699,7 +2691,7 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 	}
 
 	/* No write status requested, avoid expensive OUT tests. */
-	if (!(poll_requested_events(wait) & (EPOLLWRBAND|EPOLLWRNORM|EPOLLOUT)))
+	if (!(events & (EPOLLWRBAND|EPOLLWRNORM|EPOLLOUT)))
 		return mask;
 
 	writable = unix_writable(sk);
-- 
2.17.0

