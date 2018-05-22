Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2401354-1526989023-2-1421240186385513343
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526989022; b=O37xeTr/MTQQ66hCjqXCVB1Oc1UFHTY83fFRiqt81Jghca8wfQ
    hhZjTMYipPi8gsYY/MEDb+30KvR6SBPCY/IXnahG+4BOqPyLtI95/x+yxl9kq+Yh
    piPsdoXPiYAVgS/p5nsM6gjHT9EoobT2TmYhZjG2SRkZ+wmsYCeCTLAilHTgaiWq
    8yy5HzgDptsQhbPoZYN/qRkfMEHPG1lqvrOKK38XAhoo3CTTs6kxO7fUNYxtDaD3
    qihoRxl4jv0OWBVleq5jVYMQ9XWXBCXxkmjHgbT2MZf8hUMgCAfa4ZTc0gBhT6m3
    7+QTt6gdKY3rjKnGyO+j3xX0ruro0mruRhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526989022; bh=
    CJngXk0JSl6ppGwXxcyp9Tcaq4h/2Gzyuprv/eFYuio=; b=VeaSppd4iiCBmdQe
    gnN2UOl3S4exS493prnbPiAvq3psGge50Z91q5vpWHNmot4xplNGg8RWHoOI5VH6
    X3G9XxGB8gRqa015AyBeOBephU8EXefJWu8DgfXspcjrSR59amXQLOjNw9707KdQ
    mlqgl9D3AUQ31s3whR1EH9K+aF3S7i7WA/QgyqUnBm6qR9WEkouinfqO6BNy6yNM
    zv6SXlfhzTfArpnOeVYCCBGTnig5hP7nuC91SdVT2MPqs/q17uqbNmbVTpBu7l+O
    vEp4t7eR7P99zutN09bgJ2RMPlUPVyS93aX0IZ8yrZmohPoVJey2AnE8qpqT1alR
    y9gkZQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=qAZqutIa
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
      header.d=infradead.org header.i=@infradead.org header.b=qAZqutIa
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
X-CM-Envelope: MS4wfBPaOFgvR3yB+cRDd0vR0L4N06C5w8ZwLAQ79bdxdIGbFO2fjH52VzCEvLjxx2FcsvjnLxJH8AqBW8hWE/p9vWtmfJtDwXDGIyCp+1NXGttNk0fGz9ak
    vW+qmcidSwFGtcSr18apsbripHARUMl4qPRz5k3O5SiO1toJ7tYHOSbKI2K3L4+VSzv9pxq3NJdzVgzawPRIWJFm8yA14OLhw+t+gSZ7Xqns1tK2lOStKCDY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=BwNymlt9F6pNbMexjPIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeEVLgj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:36:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbeEVLco (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:32:44 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/31] net/bluetooth: convert to ->poll_mask
Date: Tue, 22 May 2018 13:30:58 +0200
Message-Id: <20180522113108.25713-22-hch@lst.de>
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

