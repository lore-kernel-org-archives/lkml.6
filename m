Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3842726-1526037543-2-655643020697221825
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
    1526037542; b=Yz8LAt5Q+w1tQpvy2reBSbEFdfnG6OuZKX6ygRp6jw8DnwxCa4
    nOfuW42OJTlxTy4/TfRjo6dRVDsbb+3k4W28/e5LLSlb03YClVjCqQamRXjfbv+7
    52EQkrBIzkZeDnkH8btt565hkmtDVFM8doI66vRikJwwoTogydQ/Uf7eLXldTx+m
    rxypDQQj/Qk8sShaOURYR0HWLRVfWiwzA6CeoUFOT4GESQH/GEmMNgMlH8s7qdNB
    Mifpo3YBAWRha669Ltk4P4FJgWExxqHmL/YDerzK7tn15UBcNgEGL6Cxh/WQP0AO
    TlcTxz8nYS7A/EG9FCoZO+pv8300lzaGef3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037542; bh=
    j8f8CACRQds4VBP+P+a3WDr50kpmQUgUZpYWjue4RU0=; b=mUpH1vt7uCeakkUB
    iodBb1nVJ8QCQjWZw0I4BNZCC9ixZPAruSNoK3sWgyZpW0m0X84noFkdSN3qEPdd
    bwlwNxG8GTqaWUXpVmkuBbkamqXnP23lZLQy1uCP78veWKIe7u3jaHT+LWSmN7ir
    jdvqMWEop15zIV4lyK4fMf2deemNdnJengUACrss84/Gh2G1x98maHf2hsEFzDsC
    Y5BPoOUTaznPHw4sWZ5edVUy9EBC3bjWya7MNAirWnuFlkOTKth+Qci8bYrrH1BO
    m54vfhgf9H/kGAutr2Xn+FUooTrm/qejmRv3FzqwjNT2C+iRGW5cJw7ybgTzYfku
    g6NsTA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=anoTKiEU
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
      header.d=infradead.org header.i=@infradead.org header.b=anoTKiEU
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
X-CM-Envelope: MS4wfIY96henKr9GxBAp6rNEFArCIHUeQVfJMQaurT6cx3jwcc6yVws6ypVFrDufu6a8ZbsXg8jCtXUKfrZMnuArRW94O1ZIU/hlX7T5SGXFKR0qqMJ3GQ4n
    XH4d03BcpQligIYPlVgWOgKi9hD3Vm3bVAFacxy5TIQ0JO69WcTxs1yLGnbDg9GQfLF1hRtjC3+jgC+0fGgjZHnRo2ltymHjUtbNo4bNu7VbFbl+hJA/ws02
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=yLH1FfHMVGKJ3JcWR_oA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbeEKLIz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:08:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeEKLIw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:52 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/32] net/tcp: convert to ->poll_mask
Date: Fri, 11 May 2018 13:07:45 +0200
Message-Id: <20180511110803.10910-15-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/tcp.h   |  4 ++--
 net/ipv4/af_inet.c  |  3 ++-
 net/ipv4/tcp.c      | 31 ++++++++++++++-----------------
 net/ipv6/af_inet6.c |  3 ++-
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9c9b3768b350..d4d72ea9128d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -388,8 +388,8 @@ bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst);
 void tcp_close(struct sock *sk, long timeout);
 void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op);
-__poll_t tcp_poll(struct file *file, struct socket *sock,
-		      struct poll_table_struct *wait);
+struct wait_queue_head *tcp_get_poll_head(struct socket *sock, __poll_t events);
+__poll_t tcp_poll_mask(struct socket *sock, __poll_t events);
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 int tcp_setsockopt(struct sock *sk, int level, int optname,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index eaed0367e669..220b51347526 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -986,7 +986,8 @@ const struct proto_ops inet_stream_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = inet_getname,
-	.poll		   = tcp_poll,
+	.get_poll_head	   = tcp_get_poll_head,
+	.poll_mask	   = tcp_poll_mask,
 	.ioctl		   = inet_ioctl,
 	.listen		   = inet_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9ce1c726185e..6ec0e7a13581 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -493,33 +493,30 @@ static inline bool tcp_stream_is_readable(const struct tcp_sock *tp,
 		sk->sk_prot->stream_memory_read(sk) : false);
 }
 
+struct wait_queue_head *tcp_get_poll_head(struct socket *sock, __poll_t events)
+{
+	sock_poll_busy_loop(sock, events);
+	sock_rps_record_flow(sock->sk);
+	return sk_sleep(sock->sk);
+}
+EXPORT_SYMBOL(tcp_get_poll_head);
+
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
@@ -600,7 +597,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 
 	return mask;
 }
-EXPORT_SYMBOL(tcp_poll);
+EXPORT_SYMBOL(tcp_poll_mask);
 
 int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 8da0b513f188..a43d967eeca5 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -571,7 +571,8 @@ const struct proto_ops inet6_stream_ops = {
 	.socketpair	   = sock_no_socketpair,	/* a do nothing	*/
 	.accept		   = inet_accept,		/* ok		*/
 	.getname	   = inet6_getname,
-	.poll		   = tcp_poll,			/* ok		*/
+	.get_poll_head	   = tcp_get_poll_head,
+	.poll_mask	   = tcp_poll_mask,		/* ok		*/
 	.ioctl		   = inet6_ioctl,		/* must change  */
 	.listen		   = inet_listen,		/* ok		*/
 	.shutdown	   = inet_shutdown,		/* ok		*/
-- 
2.17.0

