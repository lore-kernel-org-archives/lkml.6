Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582301-1527103355-2-353777285606431923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527103355; b=a5H4fbs/NsMNZRJylzuuJZson2egeSoX9Lpm1GQYfRpEncdn75
    gaC2fzVYtdGIHWA+xWc88aRJdkIeaQCOGuvoDdxkB0AhgbZZeOK6TWus29l/a9v5
    SqssFMdEeaChx6JTyzGputWBIb0lagoWxmUBgUi4AWV3Y1e3gVm67LxXZqMVuUvI
    zjko/eeAq5WqPxB+ZQ5qWnX+2BUt1tUMtvunSRO9EEflqM5SfdypDFci452qSokh
    tIvmvlaAYv+GeAihOkjXRk8J+SwCFrGQtHxEHo00OQ9rX0sr+KhK4l5Jj5eGspMG
    Jaw3g1tiN6DUzJsWHgxOWzeah1E2fhWkktrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103355; bh=
    u8SAPWy94mk5Fg4Ljjii8YZlrRVW7Db86+cDLYKl0DQ=; b=XFg82r4l472KY0kb
    5zxNaVS3x/E73KlqVCQJMU+CzEddEjgq5JGZ8lrIH76r62Mq9QOhcdWnxx0qXv19
    UsBHqO8hHVkLIENILcLolbY7dcfCZdfeIp+XYGKYAJBVmKXOCBAaA8W6EojlVUuJ
    eoTd5Mq1Vk6vXUXCAu3HO1nkJtROKxFmtkOKGsXI49fZV+JdW+TYr3Eth11CRDsj
    H+MuPcDsSOcBQqF+Dm/SaPuMFtS3WUm48+HA3tLFzPwd62nUDBxf4Zb+SHmJriVZ
    nvSuHtGb6zpd1HFum49gPHesLUxPc2HT76jhab91WWFn4jTIRJyzJ26zqyLUzmgL
    +XL55w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=iiJb7cqQ
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
      header.d=infradead.org header.i=@infradead.org header.b=iiJb7cqQ
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
X-CM-Envelope: MS4wfNHseC3gABLeAskhIk0qpS8FXXyvyAoncMqlgE112kNC/VCqlEw3EWVlsvvPFajMVbOGZkmMqZHuz2ADItUzblw+rvOP7jzuMiwTs/a/6FV+WTnRvAn6
    Z2VVf4joh9w4ofkInqXG7wKQ9aCEz8BnOjrf9h+Izn1KzYNW3eisgqsqwdr9oV+duAXRcpMX6a12Yf4ZBHdeooUp/7yi05lbtoTtPDVrJtU7Jx99xcBt4zSh
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=asEyZy900Z8-iek_oV0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934373AbeEWTWF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:22:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934592AbeEWTWB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:22:01 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/33] timerfd: convert to ->poll_mask
Date: Wed, 23 May 2018 21:20:21 +0200
Message-Id: <20180523192022.1703-33-hch@lst.de>
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

