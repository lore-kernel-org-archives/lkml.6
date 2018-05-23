Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582301-1527103708-2-4679860842730144024
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
    1527103707; b=iC7qUDKbbWWnmeaGKysTJfxpD747D30Xd5/+Ki+3SbKYpKszk1
    B2E18Tl+kR6bVKomeGJwmzI714p7qSGVv93/4y08/Zcf9eVkgiO42uuwPU131isK
    RRZvrEJpgwm2IxKynKQdDbcoO74uC3kb9f29WGBbjnCYgGnHMuD9JmTzRl7uRgnk
    WPvQvAOd2qiPd1FZzvJLNp/mHFzEuSfD+rw3X9xL80pVZoVrJn98yCR9SbuhEcF6
    FCGXQBi8tRyuu+pt1TjB3RuXyyyVHtpOd4yB4WCc7k9SZXrUWCJPxi9pJBGMD1Mc
    QtaQRc3wj7YhyW801lr5QR+QE1E/KAQAZn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103707; bh=
    mLAIH2Hw7J/lKDTQl3oJFKDkU/iHFp/0d0Z5mAdp25Q=; b=DnqbQy5LHm1E7taT
    lSmtPeT8LgaBXmkh7K7OyQfoHpXo24nc8v2qdlAN67pIlRFSOJpTeu6enfH3HU/m
    06XoL/EXOQms/GF0m8X3g3aoyhhu4laabk9BwoMjH/hMmPCerfghSujEA/Uwvq5S
    cpUGPraQKl0edGA/3DI3kD61BpeJg8g/JuUAsgpUaAgTl2OmHsIFalzvtoWN0Vfs
    MnR68U3tIHQfqLL1BucouLZIMYvCxGQvBHGTwLw+7vqILyKyB1TTIhT5t85udw14
    xrgqOL0vyKYjPCkF4MFCTwk+GDAAy10wJ+JShJx7cr6sp8e+308yHyI5flzBcRAh
    oHUOdg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=thdOFt6J
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
      header.d=infradead.org header.i=@infradead.org header.b=thdOFt6J
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
X-CM-Envelope: MS4wfIJ55WM2/hvzxbBRbMmC00dDI5LMenetocCAqm+wpXK710XoBrPzEPa1haajydJKPE6+fHEgEePfXZu5KlhuAkPUu7mSJGJv416By7c6wt0T1aAdnNVk
    Hpx217e39w6FOdy/DW7+IsFnF3k7+dfquDzq9VqbDTv0E1UdW4UXbpB+9vDWqa4O4MVwfNA6/0kytWigFMRaT0CLbV1DM+D8EbvQWvx9NiqdUQNG4AEW743M
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=hHHsL0CiJGZsAvVjzFYA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934274AbeEWT2D (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:28:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934271AbeEWTVW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:21:22 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/33] net/atm: convert to ->poll_mask
Date: Wed, 23 May 2018 21:20:08 +0200
Message-Id: <20180523192022.1703-20-hch@lst.de>
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

