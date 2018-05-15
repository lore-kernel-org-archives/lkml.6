Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3119014-1526413980-2-11618952234458718864
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
    1526413979; b=bc19tESOIYjkk0+xjUuBKu9jmgXNXYGcmzZOrcaczZRTdH8NRh
    VHYbL3eYfHwIVXwd9jn8MEfO/H3ec+Eq+CKJwOJYlfgISV8cvIEBpikQjrSBOYdl
    3Mnx9GYis0qSffput7/wUeSkV+tXcZGyqlnYrE1ghU1j9C6ez8w64Iwg+iyH0pyf
    KAxMC+XqGmH5xJ9tgjGZcs4iaZVc7mVIS5Jg3N2Wd14EWzIE0xyHyDfg2KPdonmo
    rA6mbfTasw54b8hho5nb+E4IwCEBVCWsxHKRj40ehoZzrmvBB8tODBWAdkKT18aa
    9RTlfYtI9UI1GhkYhGxor9zlYbzLayYTPgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526413979; bh=
    ie4Ejgcjh/1Qnmw7Ll2JyW4OM8gjyFAy/8DdBN9mH2k=; b=RD/3O39VqdRdxVfo
    7ht/VX62/4mIJBbSXAt6Fmy8Buivbl1LWNAnwWghnTSiiIQXKtgO/4AqpwFFWdNd
    IJ1lpnYxNp1bO2BU2P6e0D4Q380ncTC7hGBbE9SyZWbjzOfgwXoBVbt/Pzis8HvP
    fDg3cLlQYn1WGQh9FpILCKO/k3/LDeYoTrsJIK3oslgrByXJUekCFBSpUjXLfxiu
    Pqz3BK9AG/ouq1w0TP2helJbMMUjmH0eYHIkrrja1UC/e4kzq9njH6ZS4iwNBzyC
    lRjVvhnTvSmI6SHxSTyuLlqmOl/QwYT8ABGSy4pIHHauq0OGsECcL6TdTyqgKePw
    W9HIiw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=X67eXrUD
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=X67eXrUD
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
X-CM-Envelope: MS4wfG3/AHb0mDQueYvMdtAfPqkE4dkYXPsYgptUu8X4JJ+KWjHN/FzC9y0Ivb8QSurn0pW5MHRtdNIUjVu01tsBpjH+RvOhxseP7DnUZgu6A7BPjm35wpDX
    1o1C6aEgxb2L6F1JGG2KDXeqTe6YbT3H0+t76nHpVOiskefvSaoiNoP1EUT0FAvO72xqSMEdJo1KyPrTBdWrndEw5qUhf48tSsHndVL5y3JBNu2pICcC5Zkv
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=F55Z69aUwsZ0p8WbI6QA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeEOTug (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:50:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeEOTue (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:50:34 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/32] net/rxrpc: convert to ->poll_mask
Date: Tue, 15 May 2018 21:48:28 +0200
Message-Id: <20180515194833.6906-28-hch@lst.de>
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
 net/rxrpc/af_rxrpc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 9a2c8e7c000e..6b170f2e47f2 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -734,15 +734,11 @@ static int rxrpc_getsockopt(struct socket *sock, int level, int optname,
 /*
  * permit an RxRPC socket to be polled
  */
-static __poll_t rxrpc_poll(struct file *file, struct socket *sock,
-			       poll_table *wait)
+static __poll_t rxrpc_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct rxrpc_sock *rx = rxrpc_sk(sk);
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	__poll_t mask = 0;
 
 	/* the socket is readable if there are any messages waiting on the Rx
 	 * queue */
@@ -949,7 +945,7 @@ static const struct proto_ops rxrpc_rpc_ops = {
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= sock_no_getname,
-	.poll		= rxrpc_poll,
+	.poll_mask	= rxrpc_poll_mask,
 	.ioctl		= sock_no_ioctl,
 	.listen		= rxrpc_listen,
 	.shutdown	= rxrpc_shutdown,
-- 
2.17.0

