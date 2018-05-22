Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2401354-1526988744-2-13661607320351632835
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526988743; b=DQzldmvvf78/jNkdUbwRUmcXnwoQipK3JV1iD0pVHtCZIYB3Zb
    TOBJGnHJfMCs836JbTKpZiL6p73AOwJYOrafrwSeq3SJaICs6AjSYFn+i9HLA2Lb
    LDNy/sPfnCM7jKWcnWXa9ZuIHgCnjNvio4NE8HVNRzq30vPCeryFT2qs1ttzld+Q
    QEIbDwxlIwioGjZQvK7p4zXKpKlwTgB0LakujJgnMiFAnPxEpWapizAwoixMnd1F
    OiJWDd02OMjCI2lfa3hfBY8c6K1Gkdvd2Aqaoef1+PJoLn+rdh6nbjlB9eggPrMd
    hZGwu4diL4MFR48++SQLlemsTeL/YWDUCvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526988743; bh=
    boli46TrLGmbP01/yQWRQl9/OyZzPjWMHqdu8js0sUI=; b=ELK91hbkuiUFiIhU
    +YxM4FcIqp8I2RvPSUQuyGB71iJyV02IqLmU1gFzkMmxJG2BioNS+JKciasJluCZ
    bdCQjEfOkFnu0YmMb2YLJx8ob0Ehq/c1zX18opViebPEebmL7izwvmK7Zd2mitBq
    0MJ7MygMoH9H6LfDUbv6I7TiXUZ9FFslt+GbjB3JzfLtbMvHTU3j89rpyCoT23mm
    6oDuwxpHlGOomugEkw7nfW8QBpUkCgySPqTBnGH73rceWVmRxG3fRzy9v5H55Ii0
    fUm6MWaEnTQa6IsIW0mBd+oM/OkxT1Cq0xau9SwDvzMyQkCxp8b+6NRZloVlnUYL
    05jZkQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=A1dzWpYB
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=A1dzWpYB
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
X-CM-Envelope: MS4wfGwEKcdQFb7zUo5e0g20w7I3HrdbVjJBTsbh6vFMmI1h3RYxtBJzCSyMmrmJzUwFghkjj/N6rbxTV/uGE1FUjGat+bN5H+NG4e8ZHPgt9idcobEu0w0X
    UJQerQoXEsLSpPrhYG9PRWB+Lg/61YOCLNfSgAMTDPexp9DItcSLcS7FZ8r+Y79KsyDKvHdR3V0/lbMDxQhbLKP5ciPCA+Z5biJZSxPUwlbnaTgP0OMs9U6K
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=Pmce8StkAcKj7r3Bg28A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeEVLcU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:32:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeEVLcR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:32:17 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/31] net/tcp: convert to ->poll_mask
Date: Tue, 22 May 2018 13:30:50 +0200
Message-Id: <20180522113108.25713-14-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522113108.25713-1-hch@lst.de>
References: <20180522113108.25713-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/tcp.h   |  3 +--
 net/ipv4/af_inet.c  |  2 +-
 net/ipv4/tcp.c      | 23 ++++++-----------------
 net/ipv6/af_inet6.c |  2 +-
 4 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9c9b3768b350..72b0ef0fe8cf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -388,8 +388,7 @@ bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst);
 void tcp_close(struct sock *sk, long timeout);
 void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op);
-__poll_t tcp_poll(struct file *file, struct socket *sock,
-		      struct poll_table_struct *wait);
+__poll_t tcp_poll_mask(struct socket *sock, __poll_t events);
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 int tcp_setsockopt(struct sock *sk, int level, int optname,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index eaed0367e669..116e3cd11515 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -986,7 +986,7 @@ const struct proto_ops inet_stream_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = inet_getname,
-	.poll		   = tcp_poll,
+	.poll_mask	   = tcp_poll_mask,
 	.ioctl		   = inet_ioctl,
 	.listen		   = inet_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9ce1c726185e..643c1ba27338 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -494,32 +494,21 @@ static inline bool tcp_stream_is_readable(const struct tcp_sock *tp,
 }
 
 /*
- *	Wait for a TCP event.
- *
- *	Note that we don't need to lock the socket, as the upper poll layers
- *	take care of normal races (between the test and the event) and we don't
- *	go look at any of the socket buffers directly.
+ * Socket is not locked. We are protected from async events by poll logic and
+ * correct handling of state changes made by other threads is impossible in
+ * any case.
  */
-__poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
+__poll_t tcp_poll_mask(struct socket *sock, __poll_t events)
 {
-	__poll_t mask;
 	struct sock *sk = sock->sk;
 	const struct tcp_sock *tp = tcp_sk(sk);
+	__poll_t mask = 0;
 	int state;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
-
 	state = inet_sk_state_load(sk);
 	if (state == TCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
-	/* Socket is not locked. We are protected from async events
-	 * by poll logic and correct handling of state changes
-	 * made by other threads is impossible in any case.
-	 */
-
-	mask = 0;
-
 	/*
 	 * EPOLLHUP is certainly not done right. But poll() doesn't
 	 * have a notion of HUP in just one direction, and for a
@@ -600,7 +589,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 
 	return mask;
 }
-EXPORT_SYMBOL(tcp_poll);
+EXPORT_SYMBOL(tcp_poll_mask);
 
 int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 8da0b513f188..57b85ea438e9 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -571,7 +571,7 @@ const struct proto_ops inet6_stream_ops = {
 	.socketpair	   = sock_no_socketpair,	/* a do nothing	*/
 	.accept		   = inet_accept,		/* ok		*/
 	.getname	   = inet6_getname,
-	.poll		   = tcp_poll,			/* ok		*/
+	.poll_mask	   = tcp_poll_mask,		/* ok		*/
 	.ioctl		   = inet6_ioctl,		/* must change  */
 	.listen		   = inet_listen,		/* ok		*/
 	.shutdown	   = inet_shutdown,		/* ok		*/
-- 
2.17.0

