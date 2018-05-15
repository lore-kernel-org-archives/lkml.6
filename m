Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3144061-1526414124-2-16373227414942315812
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
    1526414124; b=ZdQEGD0TOtHNMS+c8mW03tVgzbdYT2EGW55lV115IhhFM3MgBR
    BwakrSWHTIeQa2Z5XtlO9MAyZOf8FmjhtyMBQ5ueMpDPrGgfAeIIZShkoYgAg+92
    3raqcXOdqAqXLWgdoZcvtaetsdutTb9GrPQ0+tUHunnz454bcpfXkqKk8KHaiXF/
    aOTKIsuODucZsd5IOgOVL/gtTcprkwN1l1wCxAiFf0io5K+ZGHmR08uQ8BZQ5fmL
    1uH7/y0OZgE/Wed58DTV3WNzm+KbD9oh4SEMO2BKyWqxbn7dIJzGUF+9+hyVK2RL
    7UAjbz3j+DoI2DCzByMZ+wL5nNplz93ofjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526414124; bh=
    TEJuM+4w3kOXQ9ylj4TGuwy2e8/6CK2zN1QFePyGkmY=; b=kjTfJV0bylalPZ+Z
    MdlGYAQvBPt7F230qbnEU9G504raxTUfolG+tVTDL5YZQAlN2AReNoEQ7fK2PjQ3
    D42bc2EdPHBQW1JTDPP9Mt6BhQc5ToMgBE4s+0sHT2qIRRw0dqFAyGwOBxb8CM59
    lqfDtkSQdpJ1y8qdZRsYn0bReLSYvOtMfMLYAvv6umoUKQZqa5OUqb6Y+ocoKGcW
    P6hU1WOmgAFp+8YYc6ynXCz7bOKHOuYQMoUvvtxfuTgXvCK15To5VtSFt4b3EQ/j
    DAqQguckEUXu3oXJazdj500WTfYLvzyNiBi1r1HK7L29IuZzxO2+51kOO8WJah0B
    nfOh6Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=J4QLlLc5
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
      header.d=infradead.org header.i=@infradead.org header.b=J4QLlLc5
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
X-CM-Envelope: MS4wfJnX9IOwv09vSv0x3vw20K4gpHGlp8oK23h8jzjynR5tr4biWg1ZU46EzfpGPpP6cTsRjt7uOhzICaW9y2+ZMWVQ744GTxaGUDQpyfqtkGrJJDZvk+Mv
    IbzSGKDkWf3G3cHhoTZm9b6Mdn2uqgOzD47LrpeUjkmDYxlkeiN9/UiquZu9I1D3P6s9/NU/jJrKHhHdOItav/40+jtqdwfBnrSkdCIsahXl1QtLBGdFd3O/
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=8TZYhQDmn-aAtMH8ogcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeEOTt6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:49:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752893AbeEOTt5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:49:57 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/32] net/vmw_vsock: convert to ->poll_mask
Date: Tue, 15 May 2018 21:48:20 +0200
Message-Id: <20180515194833.6906-20-hch@lst.de>
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

