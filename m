Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782484-1526037017-2-5585174688258047064
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037016; b=b2lm2kyABo036rsP4nAqA6Vr6lM1J+AkfwqPSOceKJ23LotjxO
    nRN8neuLhBt6ljXLPYiXhJiGiRPsubL5YoarwlqU+PbZUjc7CZFwwXadBBCDrZuY
    C27S2EEhnTrtAfFXRAJaVhhKnw5gyr7ceAeg71xAR91KB2QbSWTHTXL2DnjNMNvA
    JZWYl6apONHJN1Fo3qk9Y3ivnhbLwJ141CTXUn3RgkNYWT6IEsz+qJwX/rq4rc8M
    Q5TWQn0xymHz+oeAEpRS21rFESJ0kxaenBz0sJbr2NDDCfCdEBX1459Bnlln6Kh8
    DZB6f6GHHHaW6HywmdCdgSLbqOuiW6CYTvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037016; bh=
    u8SAPWy94mk5Fg4Ljjii8YZlrRVW7Db86+cDLYKl0DQ=; b=gTc3peo61tanJvO9
    ZpmmnZ1RZ0nBVUgWgb3SJ+t9klsQVg2UnPVV2lGclUw4fE59RRfCtSNHCXaymYe1
    fS6JLTYQn4bq87vmB/QpecjOVHGBXPQVJyogrA8ZRC0zEs5gBd2gEqWYppvwzI9e
    HYAvVHnlzCmbCsQdL6kUYpkJN9aMpM3afvVb6c3nENRHPsxuVmAO4JGddnx3Ie/5
    8azk88afcgXVW7NCxo6dXp4MCUQALVQRXgCEpFH0J4jH00QqaBdlD85nP1JU1rz1
    RDtKz53ziCx/FdpDL9w/9yYhPtgs1lextTdNuUDmkVdqyw1O+uUIB8LmS06jATZG
    LX3k8Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=TZ7rjf3Q
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=TZ7rjf3Q
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
X-CM-Envelope: MS4wfF/C/YBqD6BQ66adS2I0bpJhavWj1qS191xxGrSDZ0zYx1O3yRhHonNTn66pRhwVKxLm6OXEpeet72gzLuYLeaW9pE81EkPbh7RU0MHnk7U0F+R3CxIH
    2Zrd5nt+is5kSzBFusVEJkaD0XKUKAYesrauCrTzruqzyNUq21Qrv5ru5Mq4ollYUqk7Ym+KmimAW7W1bU9H2Ef92WWF2MyFor3zmHbGKFzIcfjyaSVDVp22
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=asEyZy900Z8-iek_oV0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeEKLKL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:10:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbeEKLJn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:09:43 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/32] timerfd: convert to ->poll_mask
Date: Fri, 11 May 2018 13:08:02 +0200
Message-Id: <20180511110803.10910-32-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/timerfd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index cdad49da3ff7..d84a2bee4f82 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -226,21 +226,20 @@ static int timerfd_release(struct inode *inode, struct file *file)
 	kfree_rcu(ctx, rcu);
 	return 0;
 }
-
-static __poll_t timerfd_poll(struct file *file, poll_table *wait)
+	
+static struct wait_queue_head *timerfd_get_poll_head(struct file *file,
+		__poll_t eventmask)
 {
 	struct timerfd_ctx *ctx = file->private_data;
-	__poll_t events = 0;
-	unsigned long flags;
 
-	poll_wait(file, &ctx->wqh, wait);
+	return &ctx->wqh;
+}
 
-	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	if (ctx->ticks)
-		events |= EPOLLIN;
-	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
+static __poll_t timerfd_poll_mask(struct file *file, __poll_t eventmask)
+{
+	struct timerfd_ctx *ctx = file->private_data;
 
-	return events;
+	return ctx->ticks ? EPOLLIN : 0;
 }
 
 static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
@@ -364,7 +363,8 @@ static long timerfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 
 static const struct file_operations timerfd_fops = {
 	.release	= timerfd_release,
-	.poll		= timerfd_poll,
+	.get_poll_head	= timerfd_get_poll_head,
+	.poll_mask	= timerfd_poll_mask,
 	.read		= timerfd_read,
 	.llseek		= noop_llseek,
 	.show_fdinfo	= timerfd_show,
-- 
2.17.0

