Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3144061-1526414146-2-16743111110701326565
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
    1526414145; b=VrBq06U52pa9jAugsQsI479MxQ1lGf/k9CrhU32K/73tdEozim
    +kjl28ny03+YR6wNe1NtZf7/237IrGQutliGOKJEwDxe4bSaPEh4mg2lGzo4oN6Z
    rfA7FmWrrxRGatr4NV2sILUTfhVxLYlPHRHP43fJX/ITyPy7ky6nNanFQ7Jer6Y+
    DC5I0pG1IQkaQKAB29rVHZrw1XmGmjn2KNAArLSR2MjviuI8aUwV7mct76BYTy52
    IGwOJjAmHjMAji093UgBJkbXUrAXPUdVq0r5FGk3zoQ8njoPMYDnaIePwMvqnozY
    LTYd4v1KpTpYx9cDGNfU+/PhNU1LHbZBUO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526414145; bh=
    mLAIH2Hw7J/lKDTQl3oJFKDkU/iHFp/0d0Z5mAdp25Q=; b=jamsXdAMIlZ0verM
    9/zuZgYaGbENjfTkLtsNTCFRXwFjDTR5lKaDO326YwBmzOccg0f+u9ZlZJLj1JjZ
    GXxdBsH0HDJ5LFqRAi+D53ZJIYX3M6MaKiuMkct5zJo61SfvZwK1PsCbN/HQhgnh
    R7Y9UBoR6kyxoGbnl+W+CbMWs9dK6/cByxt8ipXlfT+UlOBmffljdv6aNPjmOvfS
    nRE1b4ccfQa7lRmgSOO0IHtaEnX0BX0IPsilAgjCQrw+AWd8lfq3KlCYuODZxbIj
    ISwLJJeKIybAsKVOckMBNJRv7ocIz3z6KJzM7ONszCkyemAoi3nEGgPEou4+Htnr
    JjSo1A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=LtsFbrN3
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
      header.d=infradead.org header.i=@infradead.org header.b=LtsFbrN3
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
X-CM-Envelope: MS4wfN+LXLRqbYSwLIqYq/uC4kJZX5tE63LNyv3StCY6Dst15vJ8kyEut0/ABuO1Ay+lnMITeBN2Yt7ljLgX9UurRrZ47/lAaxONrbg8H6xWezyWxRHntFTq
    ON1TFi49QcUaVNsAExHzPjig4qSv7XtG9MsDTY0DFv6h1BFlqTMR5B8BbuYgvoIgU/78JY1uyTKeezFVAYNtrqIlpNt6OsTiMuAYgRIlZb8mIfdPBZ6Ia9Ml
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=hHHsL0CiJGZsAvVjzFYA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeEOTtz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:49:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbeEOTtx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:49:53 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/32] net/atm: convert to ->poll_mask
Date: Tue, 15 May 2018 21:48:19 +0200
Message-Id: <20180515194833.6906-19-hch@lst.de>
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
 net/atm/common.c | 11 +++--------
 net/atm/common.h |  2 +-
 net/atm/pvc.c    |  2 +-
 net/atm/svc.c    |  2 +-
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index fc78a0508ae1..1f2af59935db 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -648,16 +648,11 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 	return error;
 }
 
-__poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait)
+__poll_t vcc_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
-	struct atm_vcc *vcc;
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
-
-	vcc = ATM_SD(sock);
+	struct atm_vcc *vcc = ATM_SD(sock);
+	__poll_t mask = 0;
 
 	/* exceptional events */
 	if (sk->sk_err)
diff --git a/net/atm/common.h b/net/atm/common.h
index 5850649068bb..526796ad230f 100644
--- a/net/atm/common.h
+++ b/net/atm/common.h
@@ -17,7 +17,7 @@ int vcc_connect(struct socket *sock, int itf, short vpi, int vci);
 int vcc_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		int flags);
 int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len);
-__poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait);
+__poll_t vcc_poll_mask(struct socket *sock, __poll_t events);
 int vcc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int vcc_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int vcc_setsockopt(struct socket *sock, int level, int optname,
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index 2cb10af16afc..9f75092fe778 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -113,7 +113,7 @@ static const struct proto_ops pvc_proto_ops = {
 	.socketpair =	sock_no_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	pvc_getname,
-	.poll =		vcc_poll,
+	.poll_mask =	vcc_poll_mask,
 	.ioctl =	vcc_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = vcc_compat_ioctl,
diff --git a/net/atm/svc.c b/net/atm/svc.c
index 2f91b766ac42..53f4ad7087b1 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -636,7 +636,7 @@ static const struct proto_ops svc_proto_ops = {
 	.socketpair =	sock_no_socketpair,
 	.accept =	svc_accept,
 	.getname =	svc_getname,
-	.poll =		vcc_poll,
+	.poll_mask =	vcc_poll_mask,
 	.ioctl =	svc_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	svc_compat_ioctl,
-- 
2.17.0

