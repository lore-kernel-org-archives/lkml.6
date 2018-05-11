Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526037518-2-17312801253754879993
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
    1526037517; b=G8TcHu6g7AyeoxuHJkLBvoDKw1PhUXnKixYeR12tCoKyADSHKO
    n8lHClGE6oORXVtl1u9nMoqq8JZR/pltJyht3eiJR5hANMKLVAu2NzAs7YvF4p4b
    rwAwZEm3nu4AQTtxp0eNHWTeIhJZnfFP2FOoEkugDzP636F4sdXmmzZ8hRVBqVW2
    LmPkVlwyI6D39dbJHgE3ag6zrZ+/smBpBqhES+JA84UaklLDOZEU90QL8sq15y+R
    NYUq354iUL/CJxanfUsIwaz7Q2xwsHIeztwpjyZVgjzuh483Ls1hY0DCRAH+gv86
    Bq6RuEjGtOlleQcFwLeQLObG/w+QucWWmGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037517; bh=
    RZebh14Nxj1OTkiJRsLKYf2pbv45iCPYG4H13ATN/xg=; b=FiaD9g3b90Eo3DBL
    1DM4Hs+eRpCrDdmFPgsHeexY8rKOy3uwTN+b5W3Tu1Mt+MfHqh1drsYfsoEFjb/a
    ZjT2coM46Rnr7EZ4aMLa9wCHFtiFmhqoiKNcAY9NWxSdACbc2c5rQagSLAgNUJ+K
    ERi4wRgujkxYytgCKSMQppZcvjEOeOpyW89plr9aIs6BNnFXZvd/+DIEqdjRb45q
    5d6IyQzCSw/1V33RVn8gw9Kasge/mVjiCQroDTsFjrKz2onRQ9lExb9MTT3rT6Sy
    kCBvcHEUPsFhV0l41GpQqK7mK/PMItZtx9XpINy+LRyv3Coz3eKPN59Y/PACRfN0
    lBTIAA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=LnbyW1yx
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
      header.d=infradead.org header.i=@infradead.org header.b=LnbyW1yx
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
X-CM-Envelope: MS4wfOMRLJbI8we7XWR0YPSct4GzR6dH8O4enZqeswiFW1iVLR4zG4UGfMZkGNAcCDCzdR8AysI65MM6mgCg5e2vBniWN7JNLoz9Y5T84SjgoFEKKVzAQLaX
    wcUwu3FkUr6eNrOP5LN/bMljp9S6nE24WobZfY34j1Gioc7IDuahg2aI/jFgVCYxzclIUPKF10/d0MTXUD2sgUAWrEJQkeQUM0iaBiuXAlea+a40oSOksDhh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=qBVkKzBwSuRwKVmLvv4A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeEKLJE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:09:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeEKLJB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:09:01 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/32] net/dccp: convert to ->poll_mask
Date: Fri, 11 May 2018 13:07:48 +0200
Message-Id: <20180511110803.10910-18-hch@lst.de>
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
 net/dccp/dccp.h  |  3 +--
 net/dccp/ipv4.c  |  2 +-
 net/dccp/ipv6.c  |  2 +-
 net/dccp/proto.c | 13 ++-----------
 4 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/dccp/dccp.h b/net/dccp/dccp.h
index f91e3816806b..0ea2ee56ac1b 100644
--- a/net/dccp/dccp.h
+++ b/net/dccp/dccp.h
@@ -316,8 +316,7 @@ int dccp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
 		 int flags, int *addr_len);
 void dccp_shutdown(struct sock *sk, int how);
 int inet_dccp_listen(struct socket *sock, int backlog);
-__poll_t dccp_poll(struct file *file, struct socket *sock,
-		       poll_table *wait);
+__poll_t dccp_poll_mask(struct socket *sock, __poll_t events);
 int dccp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 void dccp_req_err(struct sock *sk, u64 seq);
 
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index b08feb219b44..a9e478cd3787 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -984,7 +984,7 @@ static const struct proto_ops inet_dccp_ops = {
 	.accept		   = inet_accept,
 	.getname	   = inet_getname,
 	/* FIXME: work on tcp_poll to rename it to inet_csk_poll */
-	.poll		   = dccp_poll,
+	.poll_mask	   = dccp_poll_mask,
 	.ioctl		   = inet_ioctl,
 	/* FIXME: work on inet_listen to rename it to sock_common_listen */
 	.listen		   = inet_dccp_listen,
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 6344f1b18a6a..17fc4e0166ba 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -1070,7 +1070,7 @@ static const struct proto_ops inet6_dccp_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = inet6_getname,
-	.poll		   = dccp_poll,
+	.poll_mask	   = dccp_poll_mask,
 	.ioctl		   = inet6_ioctl,
 	.listen		   = inet_dccp_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 84cd4e3fd01b..88b668db244b 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -314,20 +314,11 @@ int dccp_disconnect(struct sock *sk, int flags)
 
 EXPORT_SYMBOL_GPL(dccp_disconnect);
 
-/*
- *	Wait for a DCCP event.
- *
- *	Note that we don't need to lock the socket, as the upper poll layers
- *	take care of normal races (between the test and the event) and we don't
- *	go look at any of the socket buffers directly.
- */
-__poll_t dccp_poll(struct file *file, struct socket *sock,
-		       poll_table *wait)
+__poll_t dccp_poll_mask(struct socket *sock, __poll_t events)
 {
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
 	if (sk->sk_state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
@@ -369,7 +360,7 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-EXPORT_SYMBOL_GPL(dccp_poll);
+EXPORT_SYMBOL_GPL(dccp_poll_mask);
 
 int dccp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
-- 
2.17.0

