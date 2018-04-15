Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523804660-2-8696148823886251328
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
    1523804659; b=FzUPm958sKlXy3RmRB42xD15hMKjE6QB2AfDHwOFsy9aEINyvT
    yNt6oAninYtn1ZmQpzRGP5SH3PJ7Xb/5npISkAZqVWrQEcyN43z0IHxLfvL/HQSw
    v4YsLjQAVW+T88QfFrEoKPN6abHfAwukPW6yn3hBXRXNgsCTvaj9kDN6/mj7oDjo
    gQp3mWtdqwKuZWWBdYG2Wo3yiKfoz30ovm19d4bM0V/LtAllOFvhEJ9PnF3KNWhY
    3vP3dM9odsNEL8bGwJdsB9FposOJPkKar2uEvTndtyfbT2bXy00OWSmAjniFEG9c
    jxUWOwZSqmZOOYN0x5FrZfbhV0wM3J0TY+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523804659; bh=
    vQf1BLNihSZ4229N3BpK+rlaphEmgZCVtXJSragE4nU=; b=AAobIk8JtzOQtODt
    jtDtZNRgJ2Fr/KMgGsoIgkU+XDINzuLYysddqynq9B/zA3h7MqDYnX+H4BIRsA65
    pT3ixHMFaQH0K/Sbkk2xOYXyCw1iSkbWkL9zyWqf2lT71h/XUNJLNHLJDAUFyFCb
    BkdDT/lkoOp5VfQJcRkFOc7TQl/cYlfmay3Nei8sNOryUQVi8I7Rioteh89Nb81P
    1axLSVkP91pN4S8WqCLpYwj3C+L93MntX16E1ytWqozQ3nju1VOBzfH8lYWW4aT7
    wPwUmRtlN+YYQVl+SmBSvaE5paIiwaKnQUXH+KcZI5XnEfDRurhuJ2Zvv/DIUpTQ
    7lYQQg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Mtf9NMrc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Mtf9NMrc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEQL2JLnMnC5cxWQ3c+Z6+8cz6XQKlZv15gLxPOSWCxPfmYZCRL9+LIUHeNAAWiCiiEudNjtHLrbcs1AgNSH8Jkb3INxi0LssN+Vn1SBv5oxxr4VIGXe
    Lydyoj6OzOqdehDODObeZBps9Neuxb1CuunrFNCnkeDRdy8Wt+L+hSSjrqLfRloRBIy8Eymlnqal6YIOGMopr9VYXzCSIcthICmla4Kvlw06uRyR9Yt7E58s
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=OmBnyCUHKzbxSlJ2ThoA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeDOPB2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 11:01:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeDOPB1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 15 Apr 2018 11:01:27 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] aio: remove an outdated BUG_ON and comment in aio_complete
Date: Sun, 15 Apr 2018 17:01:03 +0200
Message-Id: <20180415150108.1341-3-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415150108.1341-1-hch@lst.de>
References: <20180415150108.1341-1-hch@lst.de>
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

