Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103629-2-7735861140733329554
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
    1527103628; b=Ka351/RaRjrrjMroxpw9f7l5jcNKAwwZuDl1eu6c9L174af0AA
    GFOg83tjsYROOlIzWdubtMpW2nYAUx2MATKeh4qyqFqow59QCsqc5LJ45CvkCCwq
    KTaigu67QNnbZwnAj10fjMyl+7FiaCpi/sJQa+paamsza5g8+hwBul185A4kEhn0
    QMTrPZ2d+iixoQ0W5a+XxyuD1LeAnUJGG8Pho5hRqhu4ZljVyWnwCwnERWn2Z6Pq
    BsHzrCtgtG361+0eW28GH50Mc7WvQrHgl3GLd9eEYZ5QQ03qeROy5B+qtM8ceNZR
    JvOtgwLMPBa1MDTr2WoT1tcBJ0HrtWWjwSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103628; bh=
    TEJuM+4w3kOXQ9ylj4TGuwy2e8/6CK2zN1QFePyGkmY=; b=GKoc/seeQpWnnh0Z
    w9UyqqPQ+phb6DxBhgVwTMD55HqJE8DK7wqxQyJmP0qA9mdjnBtRZAVDY/ZVMcB3
    zHN4gMJi+/rZvbu65FxQWi32sgB4q7nHXGICwmGvKH/W5uXz+gwCo+NuwemAFpOX
    Folmq9H1sbDioN2czQc5CefiFZR66op1Ofxo7xiPs9sd+0OgI28Gga/cheJej8UE
    4JBibYbtRZEhsRl6SNhp2XG3TAeQWn0kfYziE9ZmzIfcBKfeY+WGl9UlJoboS7sU
    0/cAjc2Cx6g5L++8pjU80tokDtxHUcNzmGjU/ezB6MbsOsKufL09uzmiujXF9gLt
    l95qig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=UdM9ONF2
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
      header.d=infradead.org header.i=@infradead.org header.b=UdM9ONF2
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
X-CM-Envelope: MS4wfKpclGbsVW1T/IeuULM9TNCgPo55OERbJqkmevq/K+Jtvx2jzcc4okutUuS6PbNfPSbQ4JnmHYcYO2MCxj43xM8UzN1/hfQUouj2NsxF1VmT1O3kuqIP
    EVgvehShs8DXyxdl8HrGfj6+7RoiWQvscVr/R4TsZ6E9rebAQYstBV+vNrjjrf8TgebTnN84xg5Z9wgaPFeqliyeduvfJqmuvmWlyFPv28zoNI6ZcZ721XU2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=8TZYhQDmn-aAtMH8ogcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934601AbeEWT0y (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:26:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934489AbeEWTVY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:21:24 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/33] net/vmw_vsock: convert to ->poll_mask
Date: Wed, 23 May 2018 21:20:09 +0200
Message-Id: <20180523192022.1703-21-hch@lst.de>
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
 net/vmw_vsock/af_vsock.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index c1076c19b858..bb5d5fa68c35 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -850,18 +850,11 @@ static int vsock_shutdown(struct socket *sock, int mode)
 	return err;
 }
 
-static __poll_t vsock_poll(struct file *file, struct socket *sock,
-			       poll_table *wait)
+static __poll_t vsock_poll_mask(struct socket *sock, __poll_t events)
 {
-	struct sock *sk;
-	__poll_t mask;
-	struct vsock_sock *vsk;
-
-	sk = sock->sk;
-	vsk = vsock_sk(sk);
-
-	poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	struct sock *sk = sock->sk;
+	struct vsock_sock *vsk = vsock_sk(sk);
+	__poll_t mask = 0;
 
 	if (sk->sk_err)
 		/* Signify that there has been an error on this socket. */
@@ -1091,7 +1084,7 @@ static const struct proto_ops vsock_dgram_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = sock_no_accept,
 	.getname = vsock_getname,
-	.poll = vsock_poll,
+	.poll_mask = vsock_poll_mask,
 	.ioctl = sock_no_ioctl,
 	.listen = sock_no_listen,
 	.shutdown = vsock_shutdown,
@@ -1849,7 +1842,7 @@ static const struct proto_ops vsock_stream_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = vsock_accept,
 	.getname = vsock_getname,
-	.poll = vsock_poll,
+	.poll_mask = vsock_poll_mask,
 	.ioctl = sock_no_ioctl,
 	.listen = vsock_listen,
 	.shutdown = vsock_shutdown,
-- 
2.17.0

