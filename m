Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526037557-2-6679104894676774057
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037557; b=giecIzdEMw33lcyqda3gkPs7JP3pDG5mD733qiis9KtCdECUfy
    T8NSmeD+TipYgDT0PnrgHG1A/Uq1ywN7kapyuVtiiyAjV037maU9fOsGSRKKGYkn
    i6UwKjaUED3VXfcTjuPIfcxg81cK34WplM8O9vRFP4ARd7gsPyqvdo1osnmDqrCl
    aWBcrOtEU8zzvjYpD8Yu1U15ACV+Ya3cJfdNVyJkT5MoMDTOL+UOg0cRo4andE9R
    0m5sFSNymHgjpiZEaY+cmpFu/avsmFGUxmq+WkPGknFig3nhaIE6RwaYf9XHE5S7
    ua7KU3+ZGTpXP7himZ60+HG0fVhnqwnq36zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037557; bh=
    nw7lIhzmpegBIsWhO9Z7C7jA1cVCGRXfd9Hs39Adoo4=; b=ABAW+SQTj6A31hGT
    H6/oL5MSb5S9NoD5om4SEWwmImsXqzi53ZZ/84bObzqoo2rb3vOel7hmoVuODy8a
    nbDMFVzjgO85hsbh4nzmfARzTRkdRRhnkfakfWaonryi3Z6EUZskq4TK+eybzL/f
    8lkqwJGqj0XIOvfIOFdLXBmrRYcu1RcCZA7wcn8c87ddtA00hZCPgYYpqKUuRaG+
    bxolTR7zAL0qz9MN3D5ZSRT49/WddeRTK1CywdyWInm098LQdVFwybScIjKBHpU2
    tgEZW25k4I+7Y4ac0mfpv3TKxAwLbuGS35QviSNKuARMdxvxLPsBolh7nxq9W4oN
    I+wENQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=ZljqQOue
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=ZljqQOue
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
X-CM-Envelope: MS4wfNGIYNDS8g1MV3hEZeBIiDZzmGtH78YVdX7v3a8knNxr9xCW8pGIzbhTDxDGRqXw2eTM9pBaxkzuV5oWbKqfkjmO5h5uxT4Ij/+s6unw2AsBmUy/SiEu
    lFdbBO4nZ6olf2pmrjXOjpqfNDc3B/aN6fDNq2JD7EHyD1h+dn9UwJmncFxMrAWzgLrzzF6AwcZJl1CkOdozNDnvHhsMcR4lWAl+ncYI/oxC8PF3yvVc4Mej
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=PwPxyESu6iuoCfwzTd8A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeEKLIu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:08:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeEKLIq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:46 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/32] net: add support for ->poll_mask in proto_ops
Date: Fri, 11 May 2018 13:07:43 +0200
Message-Id: <20180511110803.10910-13-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The socket file operations still implement ->poll until all protocols are
switched over.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/net.h |  3 +++
 net/socket.c        | 51 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 2248a052061d..804413cf1c72 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -147,6 +147,9 @@ struct proto_ops {
 	int		(*getname)   (struct socket *sock,
 				      struct sockaddr *addr,
 				      int peer);
+	struct wait_queue_head *(*get_poll_head)(struct socket *sock,
+				      __poll_t events);
+	__poll_t	(*poll_mask) (struct socket *sock, __poll_t events);
 	__poll_t	(*poll)	     (struct file *file, struct socket *sock,
 				      struct poll_table_struct *wait);
 	int		(*ioctl)     (struct socket *sock, unsigned int cmd,
diff --git a/net/socket.c b/net/socket.c
index 571ee4005192..3c4544ee0a16 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -117,8 +117,10 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from);
 static int sock_mmap(struct file *file, struct vm_area_struct *vma);
 
 static int sock_close(struct inode *inode, struct file *file);
-static __poll_t sock_poll(struct file *file,
-			      struct poll_table_struct *wait);
+static struct wait_queue_head *sock_get_poll_head(struct file *file,
+		__poll_t events);
+static __poll_t sock_poll_mask(struct file *file, __poll_t);
+static __poll_t sock_poll(struct file *file, struct poll_table_struct *wait);
 static long sock_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 #ifdef CONFIG_COMPAT
 static long compat_sock_ioctl(struct file *file,
@@ -141,6 +143,8 @@ static const struct file_operations socket_file_ops = {
 	.llseek =	no_llseek,
 	.read_iter =	sock_read_iter,
 	.write_iter =	sock_write_iter,
+	.get_poll_head = sock_get_poll_head,
+	.poll_mask =	sock_poll_mask,
 	.poll =		sock_poll,
 	.unlocked_ioctl = sock_ioctl,
 #ifdef CONFIG_COMPAT
@@ -1114,14 +1118,51 @@ int sock_create_lite(int family, int type, int protocol, struct socket **res)
 }
 EXPORT_SYMBOL(sock_create_lite);
 
+static struct wait_queue_head *sock_get_poll_head(struct file *file,
+		__poll_t events)
+{
+	struct socket *sock = file->private_data;
+
+	if (!sock->ops->poll_mask)
+		return NULL;
+	if (sock->ops->get_poll_head)
+		return sock->ops->get_poll_head(sock, events);
+
+	sock_poll_busy_loop(sock, events);
+	return sk_sleep(sock->sk);
+}
+
+static __poll_t sock_poll_mask(struct file *file, __poll_t events)
+{
+	struct socket *sock = file->private_data;
+
+	/*
+	 * We need to be sure we are in sync with the socket flags modification.
+	 *
+	 * This memory barrier is paired in the wq_has_sleeper.
+	 */
+	smp_mb();
+
+	/* this socket can poll_ll so tell the system call */
+	return sock->ops->poll_mask(sock, events) |
+		(sk_can_busy_loop(sock->sk) ? POLL_BUSY_LOOP : 0);
+}
+
 /* No kernel lock held - perfect */
 static __poll_t sock_poll(struct file *file, poll_table *wait)
 {
 	struct socket *sock = file->private_data;
-	__poll_t events = poll_requested_events(wait);
+	__poll_t events = poll_requested_events(wait), mask = 0;
 
-	sock_poll_busy_loop(sock, events);
-	return sock->ops->poll(file, sock, wait) | sock_poll_busy_flag(sock);
+	if (sock->ops->poll) {
+		sock_poll_busy_loop(sock, events);
+		mask = sock->ops->poll(file, sock, wait);
+	} else if (sock->ops->poll_mask) {
+		sock_poll_wait(file, sock_get_poll_head(file, events), wait);
+		mask = sock->ops->poll_mask(sock, events);
+	}
+
+	return mask | sock_poll_busy_flag(sock);
 }
 
 static int sock_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.17.0

