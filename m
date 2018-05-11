Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3842726-1526037194-2-1080223120248995024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES sk.us-asciienro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037193; b=ccj1IARsatjOJxxlOHap54mhRtGwyuMbluvUq7picvj0nuGB4y
    LolpBYN6kDpYcTSsQr+03BR2GtPDESP8CH9uJH1P+X6PGGQuQI8V8EuFaYUVtn9A
    uH9DW5csbeLMcqGTMmPQAV3dyzir/4dw8PrYIqS7ZkD4VgAAR9xBGKonYr2zJ2Wx
    BwMNEvD99ZzNPvzgiMbdicmMHiovfqLWeH849bGYHR1l8Wyv7H4Ol3dJwDXEXc2/
    k1WhcHSr4y7bYQYyrYwp7D2C1TBc+Au2zPJXuuSsJOP+udJTMX4Lh8uKRFEEZZ9T
    rg0poCul734bJYJMPU0bd+0K8RVPlHXE7J0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037193; bh=
    U53uYYGUbgEN4EZWDxE0U7DcmVM684CThQNXqWAQW9o=; b=CGJly0Nlgbqrvvhg
    xsksfqV4yQWIAgOfvsbEY8QMnUDH232bIoHx/fLjaMYylNGsRKljnsZcmrvOp6GS
    e+8rIFfC81baayehJlBDQIJ2PAMQ2z3mfG9nZzuZZ9a8cu8ihHRPXP5EsyBP5GnW
    6cr3pkWxSGN+grs/VXs4l7DS5F6p57agONpLKuAeQjz5aqoJ2KIZZKdEeLVKLuQ8
    wat2nSoLOvLZnhQ5ucGnlD1DSiFManmaPuRRSjMoEYS6KclWe5CYSq2qcEHXVbdO
    nfrkFpqwlnSMjmk4Ob4nN/NakRtgOULNZZCosKblTvbUFRd/ZuxHhVj0K0hwthGv
    j4BXWQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=rASMNHZI
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
      header.d=infradead.org header.i=@infradead.org header.b=rASMNHZI
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
X-CM-Envelope: MS4wfPW3lgkQv5U/JLQ+evNLXSVDErs+AvUhU5MIwyQ8nImhPC2SqE5/jlbgR+nZWaOwYU68LG1Xmfpf/q2u9+J8YMMk1Q6Mm5z7UC9PP2acT5TNX8WjqoSB
    1khRR03qCpU3W1NfyqLGQqF+fOZo3JCuad/soq3Wu9JPZOBDCVP+zGo0Nz+/r1K/One5Ady2nM6c7ZlRLymnOaDw52m/fRLNWcmpzACepTXbz3UGyLITS3l1
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=Bt-OzgS1u0sNeZ1bWukA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbeEKLMU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:12:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753406AbeEKLJe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:09:34 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/32] crypto: af_alg: convert to ->poll_mask
Date: Fri, 11 May 2018 13:07:59 +0200
Message-Id: <20180511110803.10910-29-hch@lst.de>
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
 crypto/af_alg.c         | 13 +++----------
 crypto/algif_aead.c     |  4 ++--
 crypto/algif_skcipher.c |  4 ++--
 include/crypto/if_alg.h |  3 +--
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 80838c1cef94..89ed613c017e 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1060,19 +1060,12 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
 }
 EXPORT_SYMBOL_GPL(af_alg_async_cb);
 
-/**
- * af_alg_poll - poll system call handler
- */
-__poll_t af_alg_poll(struct file *file, struct socket *sock,
-			 poll_table *wait)
+__poll_t af_alg_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct af_alg_ctx *ctx = ask->private;
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	__poll_t mask = 0;
 
 	if (!ctx->more || ctx->used)
 		mask |= EPOLLIN | EPOLLRDNORM;
@@ -1082,7 +1075,7 @@ __poll_t af_alg_poll(struct file *file, struct socket *sock,
 
 	return mask;
 }
-EXPORT_SYMBOL_GPL(af_alg_poll);
+EXPORT_SYMBOL_GPL(af_alg_poll_mask);
 
 /**
  * af_alg_alloc_areq - allocate struct af_alg_async_req
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index 4b07edd5a9ff..330cf9f2b767 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -375,7 +375,7 @@ static struct proto_ops algif_aead_ops = {
 	.sendmsg	=	aead_sendmsg,
 	.sendpage	=	af_alg_sendpage,
 	.recvmsg	=	aead_recvmsg,
-	.poll		=	af_alg_poll,
+	.poll_mask	=	af_alg_poll_mask,
 };
 
 static int aead_check_key(struct socket *sock)
@@ -471,7 +471,7 @@ static struct proto_ops algif_aead_ops_nokey = {
 	.sendmsg	=	aead_sendmsg_nokey,
 	.sendpage	=	aead_sendpage_nokey,
 	.recvmsg	=	aead_recvmsg_nokey,
-	.poll		=	af_alg_poll,
+	.poll_mask	=	af_alg_poll_mask,
 };
 
 static void *aead_bind(const char *name, u32 type, u32 mask)
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index c4e885df4564..15cf3c5222e0 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -205,7 +205,7 @@ static struct proto_ops algif_skcipher_ops = {
 	.sendmsg	=	skcipher_sendmsg,
 	.sendpage	=	af_alg_sendpage,
 	.recvmsg	=	skcipher_recvmsg,
-	.poll		=	af_alg_poll,
+	.poll_mask	=	af_alg_poll_mask,
 };
 
 static int skcipher_check_key(struct socket *sock)
@@ -301,7 +301,7 @@ static struct proto_ops algif_skcipher_ops_nokey = {
 	.sendmsg	=	skcipher_sendmsg_nokey,
 	.sendpage	=	skcipher_sendpage_nokey,
 	.recvmsg	=	skcipher_recvmsg_nokey,
-	.poll		=	af_alg_poll,
+	.poll_mask	=	af_alg_poll_mask,
 };
 
 static void *skcipher_bind(const char *name, u32 type, u32 mask)
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 482461d8931d..cc414db9da0a 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -245,8 +245,7 @@ ssize_t af_alg_sendpage(struct socket *sock, struct page *page,
 			int offset, size_t size, int flags);
 void af_alg_free_resources(struct af_alg_async_req *areq);
 void af_alg_async_cb(struct crypto_async_request *_req, int err);
-__poll_t af_alg_poll(struct file *file, struct socket *sock,
-			 poll_table *wait);
+__poll_t af_alg_poll_mask(struct socket *sock, __poll_t events);
 struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 					   unsigned int areqlen);
 int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
-- 
2.17.0

