Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2401354-1526989251-2-14091093950609343768
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526989250; b=SXhj79Zq3SAMwvjxF5Jv/8ViG4x08WNutRGetrDepDIVprd3sa
    bwSIDSRIvskNV3MdXeScSX+a5HfWoAoTT2LZR4nONLFUkdO85MjMUK7lAc6C3TbF
    0gko+SlU7kCROLfRXDxQOSFN7ihrGtz/iwHl0OwJebY89V0KSypIYmB1AJw5E0y5
    F57H5zQwZui/zRl58fvgY4ra8vWwNody31qfqo9JVn4LRlqi8FWM4UKUf+s8FkTm
    p2pQjcC/GVV84nfUVs5rBd/GGokC47JwbvFSownLKd6dt0zqLunq8dNnqfZqSmLn
    eG/dJP1v+AzUFwmHRyZ6tKRHruKehUeAFJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526989250; bh=
    jvkF0tUckVN+sU+s2KrOcYA4hcJkBAhlhg/TjIhRy+A=; b=i8+6Y/bQK7dCNcxw
    LL8WxUqWy/DxSjTqBkRrlxJBomvfMycSACYhTytLwTFpcVjAIdXRPRZ+fRjCuF7q
    26azPkDo/ZAG0DbtiHlyh/zyti3AYWTTXbvxElCBZy2IO/ktXMEH5kv8xMGAEM8h
    hCttutfi5slxSGaVtckMlGwSvhzRoy0MURAeuZVTn47RX5A+DS4iIa+VQl90qmsw
    lrxLd1gun3Su7AWucGeACcaQvA4QlOlhDF072dRQw8Ie8aXz9nBysKE7TiEVOqEq
    1l9UG+vqCEpogMM0tLgqp2u+4tdQEwVTppEdTAG9tmZBrh7NR8hMoNerl3/UNZUZ
    XtwLFQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=fZas5uM7
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
      header.d=infradead.org header.i=@infradead.org header.b=fZas5uM7
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
X-CM-Envelope: MS4wfKireMDOZKgPYIRbPN3MyqShRDfLhLQPZEEClLvA5fh64lXKLDzy6MKvykgtRMfu/DI1w+BG9a6NzqaY0Ge+6mAnlD9NBTtE++VNM6ZGprleAywZ1OzY
    HwKk6CczCLYa0HtWB4Phbkw4XeuW8+XGyXT+H82WcNJth7dnnafMshsZJSDj9v6RgH44QSS1JdX5D6m2yR5ctucm/UuK2Ik04XD3e4gDRJ4QTb/3GDMg4+Fr
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=KaBQk26Pbc5VCaRScTQA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeEVLcG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:32:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeEVLcD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:32:03 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/31] net: refactor socket_poll
Date: Tue, 22 May 2018 13:30:47 +0200
Message-Id: <20180522113108.25713-11-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522113108.25713-1-hch@lst.de>
References: <20180522113108.25713-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Factor out two busy poll related helpers for late reuse, and remove
a command that isn't very helpful, especially with the __poll_t
annotations in place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/busy_poll.h | 15 +++++++++++++++
 net/socket.c            | 21 ++++-----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 71c72a939bf8..c5187438af38 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -121,6 +121,21 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 #endif
 }
 
+static inline void sock_poll_busy_loop(struct socket *sock, __poll_t events)
+{
+	if (sk_can_busy_loop(sock->sk) &&
+	    events && (events & POLL_BUSY_LOOP)) {
+		/* once, only if requested by syscall */
+		sk_busy_loop(sock->sk, 1);
+	}
+}
+
+/* if this socket can poll_ll, tell the system call */
+static inline __poll_t sock_poll_busy_flag(struct socket *sock)
+{
+	return sk_can_busy_loop(sock->sk) ? POLL_BUSY_LOOP : 0;
+}
+
 /* used in the NIC receive handler to mark the skb */
 static inline void skb_mark_napi_id(struct sk_buff *skb,
 				    struct napi_struct *napi)
diff --git a/net/socket.c b/net/socket.c
index f10f1d947c78..571ee4005192 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1117,24 +1117,11 @@ EXPORT_SYMBOL(sock_create_lite);
 /* No kernel lock held - perfect */
 static __poll_t sock_poll(struct file *file, poll_table *wait)
 {
-	__poll_t busy_flag = 0;
-	struct socket *sock;
-
-	/*
-	 *      We can't return errors to poll, so it's either yes or no.
-	 */
-	sock = file->private_data;
-
-	if (sk_can_busy_loop(sock->sk)) {
-		/* this socket can poll_ll so tell the system call */
-		busy_flag = POLL_BUSY_LOOP;
-
-		/* once, only if requested by syscall */
-		if (wait && (wait->_key & POLL_BUSY_LOOP))
-			sk_busy_loop(sock->sk, 1);
-	}
+	struct socket *sock = file->private_data;
+	__poll_t events = poll_requested_events(wait);
 
-	return busy_flag | sock->ops->poll(file, sock, wait);
+	sock_poll_busy_loop(sock, events);
+	return sock->ops->poll(file, sock, wait) | sock_poll_busy_flag(sock);
 }
 
 static int sock_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.17.0

