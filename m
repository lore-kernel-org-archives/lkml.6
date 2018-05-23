Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103445-2-14786664078285198446
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
    1527103444; b=KJ0kryb6hUCKVRZuwROfcwWBdoQp7sPhQ+RMODRlifGk7K1M3j
    0HqT+I85NHjaVM2bRIUe9/GwBAXpWmHe0St75LXRH34opWXTbHx2iUnfLxctlOJN
    Ztcc/hzy5X99A4TQb/F0SUGQ76WvBhPpu9Ze9jvLZnX2dloCy5euxYkGK9dRvkBh
    337R5UfyJiFLnscHATIEqSNCBM/8XlGAiTKURaRiUJQWEYyvOfAD2QZWTX92ThNb
    RoYuW9UroAi0ZuxBMCNliisoz2gYSCubTrJ36V9MWbUWQDTI/Dvy83nSOzi0jDaM
    KotMg5+7q/88oKSWdtuSX0HxPKX9wo9McS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103444; bh=
    gL0d0YamFIwaZo14Z2Lx1ovYc9a8+OiSYk5xURHXzuI=; b=iE290PQ6QwdiWUSV
    x9OFd3rld1ZcMp0so37WbthNmRngJ16nYZHuTIKddQsQhgDQFu+kdVZftXOKFOX6
    cldErxFott4Npwxnvv99WQJagIPkhOfJpVnczQdF0JNHXmb5iUkGvhQA9iFxKPGo
    WyXQPO0ucdgHAXaSJEhyisl+agDZhzk1JL/1eA7H8TpMG0wnDr3cGsT6+FoqoygT
    R6av++vV5pDF/wM4a+qXxRcQs1BJaaXSr+P3aJ9D9f/63JZzJxEMIuishNlblX5D
    q0uEcf0lysbtHvrY9/6P2+RnV5TBSH0zeZKgQZkU7KstTOeRaEaF/0QOoy0c1NC2
    t4r9KQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=JK2La/k7
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
      header.d=infradead.org header.i=@infradead.org header.b=JK2La/k7
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
X-CM-Envelope: MS4wfMujeHYxrs6fiqjur9lh+B1WrKMvYIm8sc/8YDbt324sav4v2rah8Yl3duaJ3SaYSUgL1zfCkTt4t9KPvF3W3c1S1yoOXEZPgzL+1KMB7EiIffgecsYm
    okaz6vcRZVxKmaPohwS1okLTvgWDGkVEqOyGi9nwiSEWL8OvCkeEwKAbNelGHAPNmY4wznJKDuuZelIgkTEyesa4sGLX4MP3tkofZ2CpnK0iftBy00HuUMZv
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=glk3bNZYZL77nadNM_AA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934244AbeEWTXW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:23:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934107AbeEWTV5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:21:57 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/33] eventfd: switch to ->poll_mask
Date: Wed, 23 May 2018 21:20:20 +0200
Message-Id: <20180523192022.1703-32-hch@lst.de>
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
 fs/eventfd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 08d3bd602f73..61c9514da5e9 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -101,14 +101,20 @@ static int eventfd_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static __poll_t eventfd_poll(struct file *file, poll_table *wait)
+static struct wait_queue_head *
+eventfd_get_poll_head(struct file *file, __poll_t events)
+{
+	struct eventfd_ctx *ctx = file->private_data;
+
+	return &ctx->wqh;
+}
+
+static __poll_t eventfd_poll_mask(struct file *file, __poll_t eventmask)
 {
 	struct eventfd_ctx *ctx = file->private_data;
 	__poll_t events = 0;
 	u64 count;
 
-	poll_wait(file, &ctx->wqh, wait);
-
 	/*
 	 * All writes to ctx->count occur within ctx->wqh.lock.  This read
 	 * can be done outside ctx->wqh.lock because we know that poll_wait
@@ -305,7 +311,8 @@ static const struct file_operations eventfd_fops = {
 	.show_fdinfo	= eventfd_show_fdinfo,
 #endif
 	.release	= eventfd_release,
-	.poll		= eventfd_poll,
+	.get_poll_head	= eventfd_get_poll_head,
+	.poll_mask	= eventfd_poll_mask,
 	.read		= eventfd_read,
 	.write		= eventfd_write,
 	.llseek		= noop_llseek,
-- 
2.17.0

