Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2401354-1526988786-2-7208735928289423449
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
    1526988786; b=hIN3SE0kBxxsIwTucEyQ77RLQGRfQvU3IZUcrPWJ6lhZvdZ1En
    Iu+SRJAUn7WWWy5vjjPAUkDTdEU8mo3ln+0v9c0pCf1JNO+zg2aUFPn6v6UB1MvZ
    vTeOhEjmKhv4jUpdT3fxcbRiYyinsPh/oIQJ0wUHFXacwxoKwiBQBUmVsKxkoWcE
    0WTu8q+hNdlD4qt9qfuGkcykVQkj2R+wxaELH9jA0YqCYY0iiJoUJtHrtkXbiKax
    SS7gs89sWwxQtRIUU9OQ+c1TFM2Dtupi8nbdMOBPtmro8lAg6e+C+iPxfupb+H7w
    Dmcc304lbvq9lbGzMCsOSGA38Azwzao503YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526988786; bh=
    Eqmc4RFzj8Aiw+X9KlH3Rf6w8BUC755odUCkG/pVOPc=; b=Lmi5OJgxKU5jkA7D
    zkObDVG5FF1Qcuj/Vx83ODBoxQ3yMnx5Swq3N+PgFfBatA05PxOOpQhKCrRtryvn
    Yx7m/qT66jZEAkPYvNkKXcAiDREXgZD0PmlxtBR5TcJpcEOR2WEx1op84Jhrb1hE
    FeiMHQI02tf2YJmuXIbdxzNky6rZIuJvaP6rWe5oSpsrOPK1Gqgh57cq7XqMkhDL
    +yb0fByWFA8Fu9cR2mvi6/Oe43i1mpDDYxOgr096tMnHOy3IZrtDn0p6HRBYFSOk
    OSKqzJ3wafjuViJk+BSUp03u3zfT+2MhV7sV8BloumTYXwQRYSE8D0YkEhqpYE0I
    AxrAZw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=adiSBF4H
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
      header.d=infradead.org header.i=@infradead.org header.b=adiSBF4H
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
X-CM-Envelope: MS4wfK/8kVhxqxBLGiN4uRcc3+/RhOxMys+E7sSExAyWI0nNwU+SHy1EtOgZ9l/AMfBCxilcLTaBKGwODdvhcK3XGUF1ON0HVqbk6m4XhjES7CvPqZTBsGA1
    LwBN5ElO5ZphnQhBCKhoKtRwC4luWR5FQmwQgmU8F9Rqz9OYQJ3CJA0u0PwiCGNwV6MiBujsssjXXGsThF7ZKUZ9hv8JW52RojRDpMmPeVtHm/uOicuC+Y6I
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=93xJhb5qFrg3jIcMEpwA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeEVLc7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:32:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbeEVLcz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:32:55 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/31] net/iucv: convert to ->poll_mask
Date: Tue, 22 May 2018 13:31:02 +0200
Message-Id: <20180522113108.25713-26-hch@lst.de>
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
 include/net/iucv/af_iucv.h | 2 --
 net/iucv/af_iucv.c         | 7 ++-----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/net/iucv/af_iucv.h b/include/net/iucv/af_iucv.h
index f4c21b5a1242..b0eaeb02d46d 100644
--- a/include/net/iucv/af_iucv.h
+++ b/include/net/iucv/af_iucv.h
@@ -153,8 +153,6 @@ struct iucv_sock_list {
 	atomic_t	  autobind_name;
 };
 
-__poll_t iucv_sock_poll(struct file *file, struct socket *sock,
-			    poll_table *wait);
 void iucv_sock_link(struct iucv_sock_list *l, struct sock *s);
 void iucv_sock_unlink(struct iucv_sock_list *l, struct sock *s);
 void iucv_accept_enqueue(struct sock *parent, struct sock *sk);
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 893a022f9620..68e86257a549 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1488,14 +1488,11 @@ static inline __poll_t iucv_accept_poll(struct sock *parent)
 	return 0;
 }
 
-__poll_t iucv_sock_poll(struct file *file, struct socket *sock,
-			    poll_table *wait)
+static __poll_t iucv_sock_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_state == IUCV_LISTEN)
 		return iucv_accept_poll(sk);
 
@@ -2388,7 +2385,7 @@ static const struct proto_ops iucv_sock_ops = {
 	.getname	= iucv_sock_getname,
 	.sendmsg	= iucv_sock_sendmsg,
 	.recvmsg	= iucv_sock_recvmsg,
-	.poll		= iucv_sock_poll,
+	.poll_mask	= iucv_sock_poll_mask,
 	.ioctl		= sock_no_ioctl,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
-- 
2.17.0

