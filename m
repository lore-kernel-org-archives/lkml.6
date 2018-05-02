Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1359032-1525295808-2-16091504276632460329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295807; b=eevqUQbb/b1q8YSMNO7L5W1EKonmoZPRZUuKZNhBgqWveKXTjh
    kx+mevQLsMVPWshIhpKCzTgtYCyAyhmd5EuvExk2EtnThiBRyxRIG6bljJewcOUg
    zcaPyd/1B/Pk5PQ2DBPadiFvXcD1IMDC3jpQL9tg2BsaxsWtetyDvzpKgzxQ2FqJ
    qimcJ/xOTL2cMsjMqFFsFV2wlgTkpiwh+g9N3vrNxCQPnRAlY499HrDMfQ+UI9jo
    BRC6vT4ubr00Xp6N7hJH6RN1sYQMUljX2H7sFEQ8f4ojwndPB8tI+Yljo74I2roc
    +w7HmBmaqQLDS1u5vjoTXgStFWYxAdHbiVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295807; bh=
    IDHV1q44KNBqJedpwrcmCmGjZ03aFhiPmG3VpekIivI=; b=Ef+CpCPQX6OwLww5
    wTMA3dUzDqzGx7QOslPtR1Za7pNmewOBwKxV/64QrL2P8wfQiO+yE09v5ddmuXIX
    osU3oj5UtliN4twOB0CpIztsbvrnB9QMXhbZECMPtVdq2HU46dnsYDt5FfDk3uZX
    ppBL9D08Qj5jiQG7Qak6YnYhgaRLpEhqTb1/Uw0BL2+7W1Kkfv1aW5feGBhhfiL3
    dw2IWVWc1bNDCn50w6Aiq3zPX0KW9BOHqzYO6QFPWjuy+EcZ+mFXDAOqyVg0SxRa
    vzcRy1BOcRg5pdNdHu3nFH5fh/5tMgkZxTuvOHTdtOKfGOUwSSnYeXrfYBxtSoPY
    3Onqkg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=H1AGFS5h
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
      header.d=infradead.org header.i=@infradead.org header.b=H1AGFS5h
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
X-CM-Envelope: MS4wfOCM/qBZoHQD3q3cGMRkr8+LLtiCqm92hUGI8v19ncf/zM1Z+ep8o3kuLB+M5iTMkOv4yOqqCxKJ5W//tHLnjhKrPwlAmsX/zN3903LnBYCN6hY3Ecum
    /gsxWPNGpMMGB05xLb7LxxumH5R83MhiMZ/OyxpWfMtMZrOH9ZcITHbqYFtUn/AitKBqWNngQACq/K+8yA5WAYC+0bAnM0AzaXqnt7t6sNywsIZr3LC4P3Dx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=OmBnyCUHKzbxSlJ2ThoA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeEBVPD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:15:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbeEBVPC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 17:15:02 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] aio: remove an outdated BUG_ON and comment in aio_complete
Date: Wed,  2 May 2018 23:14:43 +0200
Message-Id: <20180502211448.18276-3-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502211448.18276-1-hch@lst.de>
References: <20180502211448.18276-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These days we don't treat sync iocbs special in the aio completion code as
they never use it.  Remove the old comment and BUG_ON given that the
current definition of is_sync_kiocb makes it impossible to hit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index add46b06be86..7c1855afd723 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1107,15 +1107,6 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
 		file_end_write(file);
 	}
 
-	/*
-	 * Special case handling for sync iocbs:
-	 *  - events go directly into the iocb for fast handling
-	 *  - the sync task with the iocb in its stack holds the single iocb
-	 *    ref, no other paths have a way to get another ref
-	 *  - the sync task helpfully left a reference to itself in the iocb
-	 */
-	BUG_ON(is_sync_kiocb(kiocb));
-
 	if (iocb->ki_list.next) {
 		unsigned long flags;
 
-- 
2.17.0

