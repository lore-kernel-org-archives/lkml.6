Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103287-2-4516459042886930503
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
    1527103286; b=jiBngPh1t6nkRYAgWIFElHiG922jvk9Sc04Vo7e4mKY3IxZH0v
    xdYdPqze8buLfFc9yiKtoheV06SiLHrRRssgsggMh4/AbXkQLy1zkFJJPhsu6xgQ
    yvZZTrHAJzeNi4Sjc1O/PeX3O8SMGYTs9gohMrxCrHf/PdcblllhDd+NObG1Nu62
    Z4z3uYEpzvw+LamXvA76iP4duBeernqs8tu0Xkqg5NxbGSu0jMcTBL3gLwE72Xic
    l998qItXRjiQ5fxl5+JYMHbtaoE6HzMSSR3yef/Uqbs0vhhdx90qh27dQa5FKgvq
    +uQFy6q5WrZTIzrqK9XXf0JaZwF726jRW+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103286; bh=
    RZebh14Nxj1OTkiJRsLKYf2pbv45iCPYG4H13ATN/xg=; b=mR2V+E3qp+n2uBPk
    qV7U3WTqHs1V981DYeE0Hrn9VWM0kaSXJCoKs/vABtPEYhQY9X27q7SG2XDGI2MK
    12xP9bNAKu9Ok95af2qvB6vmEDKbwsRukC0E4LqVyL/3WVMIe/z91P3dIBVVPm86
    0j4dBzCMusnncV4xVCDeYhDXAbfUgOAEd0mvXibQ8kTVJvoTZPp0j1rf8pZ/50CL
    cTJIS52qBGZ9Vbw3oS7SC+9CYLZyRO+wJsAFuEnOdYrNbiUu5dLtp/KfQJH+XT9s
    M0azKeMjcimA/BxI/FTX7ZS+if+lMD6EOga0mbIRcQ9caS8cJNN2TuvgwLgfaXq5
    A5SH7g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=L6Fc5Oiz
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
      header.d=infradead.org header.i=@infradead.org header.b=L6Fc5Oiz
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
X-CM-Envelope: MS4wfDCT9ZICbF2kcRiYZC4D+NAnOSMiNMeNbBltF2dyJ8G0A4BBdYC3VuC6wQtfqDC0FmVWYbC613kS5cwbI2oZ63EV+woaPXjG7sOQAsK/T9/WwYLaPfjk
    BvEDpTbUBuo1i5KBvNyrdAaEybzP6qfx3p+MoPJVhwbI+081hlZSBlF1Bj8BDUid7Q1K1Ahy+HlPrs3CAJsTb/g2zDaIjKHlOWBBOXSHEZfIUQW+EBGH4VyL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=qBVkKzBwSuRwKVmLvv4A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934481AbeEWTVY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:21:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934468AbeEWTVT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:21:19 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/33] net/dccp: convert to ->poll_mask
Date: Wed, 23 May 2018 21:20:07 +0200
Message-Id: <20180523192022.1703-19-hch@lst.de>
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
 net/dccp/dccp.h  |  3 +--
 net/dccp/ipv4.c  |  2 +-
 net/dccp/ipv6.c  |  2 +-
 net/dccp/proto.c | 13 ++-----------
 4 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/dccp/dccp.h b/net/dccp/dccp.h
index f91e3816806b..0ea2ee56ac1b 100644
--- a/net/dccp/dccp.h
+++ b/net/dccp/dccp.h
@@ -316,8 +316,7 @@ int dccp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
 		 int flags, int *addr_len);
 void dccp_shutdown(struct sock *sk, int how);
 int inet_dccp_listen(struct socket *sock, int backlog);
-__poll_t dccp_poll(struct file *file, struct socket *sock,
-		       poll_table *wait);
+__poll_t dccp_poll_mask(struct socket *sock, __poll_t events);
 int dccp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 void dccp_req_err(struct sock *sk, u64 seq);
 
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index b08feb219b44..a9e478cd3787 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -984,7 +984,7 @@ static const struct proto_ops inet_dccp_ops = {
 	.accept		   = inet_accept,
 	.getname	   = inet_getname,
 	/* FIXME: work on tcp_poll to rename it to inet_csk_poll */
-	.poll		   = dccp_poll,
+	.poll_mask	   = dccp_poll_mask,
 	.ioctl		   = inet_ioctl,
 	/* FIXME: work on inet_listen to rename it to sock_common_listen */
 	.listen		   = inet_dccp_listen,
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 6344f1b18a6a..17fc4e0166ba 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -1070,7 +1070,7 @@ static const struct proto_ops inet6_dccp_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = inet6_getname,
-	.poll		   = dccp_poll,
+	.poll_mask	   = dccp_poll_mask,
 	.ioctl		   = inet6_ioctl,
 	.listen		   = inet_dccp_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 84cd4e3fd01b..88b668db244b 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -314,20 +314,11 @@ int dccp_disconnect(struct sock *sk, int flags)
 
 EXPORT_SYMBOL_GPL(dccp_disconnect);
 
-/*
- *	Wait for a DCCP event.
- *
- *	Note that we don't need to lock the socket, as the upper poll layers
- *	take care of normal races (between the test and the event) and we don't
- *	go look at any of the socket buffers directly.
- */
-__poll_t dccp_poll(struct file *file, struct socket *sock,
-		       poll_table *wait)
+__poll_t dccp_poll_mask(struct socket *sock, __poll_t events)
 {
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
 	if (sk->sk_state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
@@ -369,7 +360,7 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-EXPORT_SYMBOL_GPL(dccp_poll);
+EXPORT_SYMBOL_GPL(dccp_poll_mask);
 
 int dccp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
-- 
2.17.0

