Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3144061-1526414082-2-17436513300671676791
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526414082; b=CVyMOlEbd9Pn220vHj66zp30pVY4p64TSbnBnQdRkpwsV5X1r7
    HYO3+PIFJ8NJmRPqeZ92HKcHy7KL/0IO9/egs2ZK1Pl2qn7Ox4eQfC27Oj6lf2kU
    QPL2Pzag0+fjx0kxbPvkURrSVFItcdOywE6WKo/KQE2JFPNVkVZFtgbjaLmMAbXt
    wHnUKb3/Vs6ZJwcqW3nSsprAGi3IGEbtkgdCQPTghowptwqR7QaLEggpsLMR9SjD
    +aP33xvbHevMIhhEnlISfS/vH2LG4RJ9NnLRqE62m/x+Wp6CiNj88p9hnmNiNQMk
    DW6V39/LTJkgwdFvpzhSjutFQcso3//I4deQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526414082; bh=
    CJngXk0JSl6ppGwXxcyp9Tcaq4h/2Gzyuprv/eFYuio=; b=aOtS6Y0qL+pfaGa8
    ne0FQ3sagqt8qKHa1LADzMjTxIAGNupn3dly5ZJU3sgYq1X3c4q5o7z06SuYSJs3
    2pOkpJCx498MhYTxmXIT50bjTQZZWWwsPuu1LaZUGXW7eqXl2nWuGnGfEVflm2KV
    OE6YCTQTxAOkPHKjyP0cTABlfrrSxVsrdLxIpjB6iM1G5qyMpQ11TVLWRUf+BEUm
    3xq7Y63eyGsXbCZrhXNPzR2CdppET7cEVavFZcsHARGUZIXBf3md4eeFN0xAUMcL
    jDgUy0IXBGrmZSg0u8LhhSTMSYp2oCsgW3Jz4fo/SdVBTarERCcXn/5DRfjx5wA+
    spuTbw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=aO8jDP3j
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
      header.d=infradead.org header.i=@infradead.org header.b=aO8jDP3j
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
X-CM-Envelope: MS4wfFA0JX0nqfyHcbMDQZjr/tsCyvSwdr1hNWWGQTlM1AmYV8Swp2xQadnrkvm5vqdbhHtbwR/lkT8q7heC1gNkMmq8XJyvWTJsvs0UuiSzkZi/FoM9mNlh
    H2vttZyRGj68uiOovU6ebbn+T/jOOu92ZUlRlu/j1ecVMc7iTCx6vMRDwX7PU8WN3ulanpNMCexOM8js5Pbril/W3W2CtNDeQ55u70sDEs5F0e4Rq5Wx3z/C
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=BwNymlt9F6pNbMexjPIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeEOTuM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:50:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbeEOTuK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:50:10 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/32] net/bluetooth: convert to ->poll_mask
Date: Tue, 15 May 2018 21:48:23 +0200
Message-Id: <20180515194833.6906-23-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515194833.6906-1-hch@lst.de>
References: <20180515194833.6906-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/bluetooth/bluetooth.h | 2 +-
 net/bluetooth/af_bluetooth.c      | 7 ++-----
 net/bluetooth/l2cap_sock.c        | 2 +-
 net/bluetooth/rfcomm/sock.c       | 2 +-
 net/bluetooth/sco.c               | 2 +-
 5 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ec9d6bc65855..53ce8176c313 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -271,7 +271,7 @@ int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags);
-__poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
+__poll_t bt_sock_poll_mask(struct socket *sock, __poll_t events);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 int  bt_sock_wait_ready(struct sock *sk, unsigned long flags);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 84d92a077834..80033a7e1de2 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -437,16 +437,13 @@ static inline __poll_t bt_accept_poll(struct sock *parent)
 	return 0;
 }
 
-__poll_t bt_sock_poll(struct file *file, struct socket *sock,
-			  poll_table *wait)
+__poll_t bt_sock_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_state == BT_LISTEN)
 		return bt_accept_poll(sk);
 
@@ -478,7 +475,7 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 
 	return mask;
 }
-EXPORT_SYMBOL(bt_sock_poll);
+EXPORT_SYMBOL(bt_sock_poll_mask);
 
 int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 686bdc6b35b0..742a190034e6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1653,7 +1653,7 @@ static const struct proto_ops l2cap_sock_ops = {
 	.getname	= l2cap_sock_getname,
 	.sendmsg	= l2cap_sock_sendmsg,
 	.recvmsg	= l2cap_sock_recvmsg,
-	.poll		= bt_sock_poll,
+	.poll_mask	= bt_sock_poll_mask,
 	.ioctl		= bt_sock_ioctl,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index d606e9212291..1cf57622473a 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -1049,7 +1049,7 @@ static const struct proto_ops rfcomm_sock_ops = {
 	.setsockopt	= rfcomm_sock_setsockopt,
 	.getsockopt	= rfcomm_sock_getsockopt,
 	.ioctl		= rfcomm_sock_ioctl,
-	.poll		= bt_sock_poll,
+	.poll_mask	= bt_sock_poll_mask,
 	.socketpair	= sock_no_socketpair,
 	.mmap		= sock_no_mmap
 };
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 413b8ee49fec..d60dbc61d170 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1197,7 +1197,7 @@ static const struct proto_ops sco_sock_ops = {
 	.getname	= sco_sock_getname,
 	.sendmsg	= sco_sock_sendmsg,
 	.recvmsg	= sco_sock_recvmsg,
-	.poll		= bt_sock_poll,
+	.poll_mask	= bt_sock_poll_mask,
 	.ioctl		= bt_sock_ioctl,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
-- 
2.17.0

