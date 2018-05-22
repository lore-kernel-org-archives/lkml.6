Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389970-1526988955-2-10376810738993611272
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
    1526988955; b=btPdk+xUk+PluLYIS+BcJX0NroJIdDQgSEgHXQ5ECevGVxAW0D
    FkEGEyP+2jyNKiNr2suN8YW98fOw2MK3ywaYq3xRotEbz7PlqchZBdBfkZ7RHQNw
    PcxL2NR2LCotiN/oKXZH8RGmp1QWyp8yvGAAGpd15UNDNdj7sm8SI9W/YA1NGcaq
    UfQhrsK8QZXFRVHx7SWoDT18jZrszUIBBiN67Lek2k8hVMwVgTdXBzgqWFrppFWc
    u33euEF0GxlJ/q9M5WXtSCcw0cF/qspE90C/l2PeoBPHdUAItF/EUjiCRSXp2Jqv
    xlH+hafeQ1ZymVH9BAIm3kFrql5H9inFJYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526988955; bh=
    wBgMHnIzTinHJ7/71n1pkOZkev56TvpSxLS0UnCZQZg=; b=JY+eHjdL56yR3QST
    zM1p1QV7ND8lZKhdgoftxLUepJeRAutTM4Q/RUZY2eRw6238h1FWwaj170hhK+k5
    vNPl8576sVbfhOo5qWy3Fitu0zhW9K9nksIyCf3yTwPk2Q5W38G58tC7Wz9BjYzm
    bnhc5lLVEDk/pJMvFeVGGoYt/ZuxcXoYEiVPYuxS7c//2vNZcGbj15U29drwrJ6e
    PJ/LXYPFZMDywd7g8gMqqDNamTTmR7lqjkgJEg6L2DkHigbFQaqxTAHWEArO+Fl8
    A3O5L5TZWCFjjohacwhJrZoDchF2y6D59armD1cj+ogEtAmG/Y7ZdP3NRc1V+jJh
    pJRvTw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=UgGk/Wt7
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=UgGk/Wt7
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
X-CM-Envelope: MS4wfFebVjQbn64T2k7fVhVow2S366iOayr/uGfA3EP3MWTwEj8RnD6PzVJrJ5oSYvkpNQRPG/fT+EP9irKEU3cDFvaWyzf0nnZ6235sR5j2346Ug+3hes52
    22ysehVfwxJeSJVRqcYgZoYltvUP1g/yavCre37YnriOu+EXYL8pPdGoRcLu1ftkTdj6ckTSnG54g68V5F7BWPdE1lcUCY19ZD8yIiYUycosA3DYS+guv2Ci
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=2Ns_JZRm6thByNElF-kA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeEVLcx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:32:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbeEVLcu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:32:50 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/31] net/nfc: convert to ->poll_mask
Date: Tue, 22 May 2018 13:31:00 +0200
Message-Id: <20180522113108.25713-24-hch@lst.de>
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
 net/nfc/llcp_sock.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index ea0c0c6f1874..ab5bb14b49af 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -548,16 +548,13 @@ static inline __poll_t llcp_accept_poll(struct sock *parent)
 	return 0;
 }
 
-static __poll_t llcp_sock_poll(struct file *file, struct socket *sock,
-				   poll_table *wait)
+static __poll_t llcp_sock_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 
 	pr_debug("%p\n", sk);
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_state == LLCP_LISTEN)
 		return llcp_accept_poll(sk);
 
@@ -899,7 +896,7 @@ static const struct proto_ops llcp_sock_ops = {
 	.socketpair     = sock_no_socketpair,
 	.accept         = llcp_sock_accept,
 	.getname        = llcp_sock_getname,
-	.poll           = llcp_sock_poll,
+	.poll_mask      = llcp_sock_poll_mask,
 	.ioctl          = sock_no_ioctl,
 	.listen         = llcp_sock_listen,
 	.shutdown       = sock_no_shutdown,
@@ -919,7 +916,7 @@ static const struct proto_ops llcp_rawsock_ops = {
 	.socketpair     = sock_no_socketpair,
 	.accept         = sock_no_accept,
 	.getname        = llcp_sock_getname,
-	.poll           = llcp_sock_poll,
+	.poll_mask      = llcp_sock_poll_mask,
 	.ioctl          = sock_no_ioctl,
 	.listen         = sock_no_listen,
 	.shutdown       = sock_no_shutdown,
-- 
2.17.0

