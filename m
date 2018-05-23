Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103474-2-7112017713196166083
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
    1527103473; b=ZhEnJJ5szEzViZ2su5fpcmgEi0YMKgjBMc6Elkq/Sufln1QQRZ
    vIXEyRzJvUlsrIXQZC8VlhLkeuidu7QY/oxttG1qS8RHqmqAYEcWFktsSAtnLhdw
    BxElMw2vJkPaqnxZ/epGSTM4BPD9ojxt1K5MCCGcbM4kvOgxdW+tmIdWRMNKrb9X
    RE0s8J0+xJe8xylxJDl3J2Ltds0qkFeV0Y1kN6sxBDQxUrwXrMeWOkXEGfzs/YsG
    8KEj/67Dmyz0ajyAEKBu/DddxWfeKHHqNeR9x5oHvAJ9wjoRB+PWDTcqLXRYHV+H
    nitgtYdiDdLIOcwpogm2j+rigLMkb5YQHG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103473; bh=
    pUX16YkTwq4fpEEgga6/BNJffLeoykAGMPSfcgyp0Po=; b=kpPACyxN3c5bBIUh
    2sAJdfpfwCF/cCdDvGGmlNfVn/GsV0iLxxWXPDT8Q+z3sO/upWKPjuM802vvWiew
    Xd91zdreuR33zS2pqxtCKBl7TroWygDJ0WLyK44xTcghJUItzDumitXI7n/dy/Ul
    2pkAP1LkaP6bVi4fyHdhXm/NUUTDlU9O0SomFKHDYJrwuePtZLbdjmeP7rNYUCon
    93unoqD+/XPX3UuLIdYMeJ1fQmpC50ii5cBQvj/5bowbeonA9swrU6ADahcdJUQy
    oxZr+l0jdzh7niZXjQp9LI/6dr5Ru8RApp5XOrmpOiFJa+NWFT5lBFfrZj+AEE0i
    nugl3Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=A4LQ61rm
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
      header.d=infradead.org header.i=@infradead.org header.b=A4LQ61rm
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
X-CM-Envelope: MS4wfBgjUtrUi2tr3vD+/Xbpy/+E8ZOTBJimItBA7aoUfkzTdvhX+YDxAzTD9uVLVeaO7ojAxTv1bngtXg2angj5MZR5/nXNIrDaRchdHlMCTfhC4WPFwW1i
    LESPRL4EJLPKNipINDewFPLiUohSsUlBQfkNUS5bJYe1mo+QsN14cywBrtlD6eCaaYRqrwoWI+4+qNyj68/6It/7PY/JInSsEqxEPD6PqER7mLpW8LLBgYBq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=Yz9eO4fydKry1Lvs7jcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934291AbeEWTYK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:24:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934572AbeEWTVs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:21:48 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/33] net/rxrpc: convert to ->poll_mask
Date: Wed, 23 May 2018 21:20:17 +0200
Message-Id: <20180523192022.1703-29-hch@lst.de>
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
 net/rxrpc/af_rxrpc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 2b463047dd7b..3b1ac93efee2 100644
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

