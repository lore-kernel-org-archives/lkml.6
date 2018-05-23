Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103780-2-4919378716432237655
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
    1527103779; b=SC3khdYlzlDYo1Rmx95Y1bI/PR00ID0ZisvKt28bd43GrU/HpX
    iVito+z4oVhakbN5VfOChiH+UZbS9QIcXu/AAxAfESfHVW6m7FaknQ1S4wmU8qde
    1uAsXH22Q6daPxcuCJbJVeYtxDhDkbsCDhKJO5WMCozFk9pP7A2ZKG9WrhDR5JC6
    VFBLhrHY3omlVI8g9D2KK5Ilu5hFwxg4uviADcsOMpj+rMoOSHmZY+Cumb4T31EX
    ne3WRPXoeBdu97zSpYHd6whqNp0+fXzJ0/OB3uXLVkL3C0nELhJt/jf28NHV5ZIG
    kLrXCfSuNrUcyjPlvGDatS9ZcpcRXL0GfRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103779; bh=
    kGK3b7qopcq08LkLsY+ReENpOzzVUR9Dlsb/8++GRFU=; b=ItJ6Aw+CToJIF3CZ
    4zlKiMfncTVDRUp6k88hoCVNSjax9028vl0NougzUWaQKXCMVDPlU9HcLtp3xxTI
    AUw6en8NXqlgkQ3wyAZeWHwmcsxvWmzyE2tuR/ZVtSH//oe9EO+kXJVO0/qj6INf
    nemfgqsBEk3u56DobnabBC4RPf2GG71Dr26aTkqFCeHQSmw+Lqmpn9b+FK8pcwMe
    EcXFS4eh1A1SceQRHUpHmFF/MHQiIsyde9AMOJS6At06dkKM2G0N8I2QbQ/iZv5B
    O2Aq1R+Rcw9fgwFD53UuIh8FkXstDOYBgwGf1ZBXB0LqBeR+5tm7g59mvIkf/88x
    UB2svw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=aEXuBbUp
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
      header.d=infradead.org header.i=@infradead.org header.b=aEXuBbUp
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
X-CM-Envelope: MS4wfEnxrtKV3qcE7R75/VwcWe12myjmpCZew4U46heURUAEL3Upczk8BmSoIwRaINk/tIENtoSPalVFakfk+eIrmn/Wy7f2lx27ouHYe5nwfGM0+f4jNBc/
    YO9sGZsQFM7Dw9PgSB7aSLcQ4lEsM8dW4CPnquMet5aK0cH30C7CZmcrw3b13JYbSWOfLr0oUiv/DcAERQbZC0b76f3jJ1C8U7Nia6IQB4Z8tphvJnoH9WcV
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=Pmce8StkAcKj7r3Bg28A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934299AbeEWT3D (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:29:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934441AbeEWTVK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:21:10 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/33] net/tcp: convert to ->poll_mask
Date: Wed, 23 May 2018 21:20:04 +0200
Message-Id: <20180523192022.1703-16-hch@lst.de>
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
 include/net/tcp.h   |  3 +--
 net/ipv4/af_inet.c  |  2 +-
 net/ipv4/tcp.c      | 23 ++++++-----------------
 net/ipv6/af_inet6.c |  2 +-
 4 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 51dc7a26a2fa..f88f8a2cab0d 100644
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
index c9d00ef54dec..dec47e6789e7 100644
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

