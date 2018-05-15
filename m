Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3144061-1526414430-2-2692478019118075197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526414430; b=EE5g6j0Yxg/nqxf75vHUgl4UzakQOqUZn15oEV4UBN04KxL2mk
    dWecWYP9SIFxlKeZkKiehcc7Btm4RdiffYr2GN6KlVgU9UkE19gIbQ09S1SZmKq3
    cZUusKfsd6XMli77HLEZQsg2imBfKtaHxUPAt6AD7rgXBaakluLmVOwuv92Z+9Dc
    qgR8dSgaq6whxElK3HKWUD9DVJhDNwAaPkBSXDEy/7rAKqeT9h9Euo/VVkmSqTIL
    YhdW9ZP0IZGk9rrRbgc80Jx1ImhKI7U+ncpIBB1lHd2xaPtuXtVUaZ8pAapPoy95
    cyKI4G2980tOiEcId97Xy6Gm1eO5HJlnzfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526414430; bh=
    HniXHEEQLp8dYZswypFEpwmGtREL+15LHz6tGMUZuZ4=; b=K6buRSBSc+fVkIyX
    mfv+xN6R+UOQLlTHPnJW44GZ2FdRS3kcRPbyU8AV1js/1rzO0wKUbrCqFGywf1fX
    AMN5LYHL6s5HepIjHZqikDqE5bm4rxrsVjHmM0sHtevXoaUFdt5g02suATfST/6M
    qHELcXk4KMzfVRAUzDmq8vp+VvKmH6a4WdYPwIUpVt781IONQwMkAzR4tK8xOD75
    xVtDotXz8ioXCAgY6ItPoaW8e4OHfSAPO3NKkeGgmwf1Lu0fQm+e/plBSQHMchP1
    7JGB/32vyFIMbmms4/K3zyFLXL5c3IJ6VWVB75ZyUVbde2oviScQ85y9g7aeHgri
    SRSS6A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=JvmU4Ln+
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=JvmU4Ln+
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
X-CM-Envelope: MS4wfCudu7z6XFOPash18t26ZMCZDgqe+0223TDjPLQjT6l9uaas5ZJLLbGrmlb4hrm+Qo48FI2TImbv/slGnBOZpJd1U49Gwc9aU74hdJOVsDu7Tmm+QG+B
    pW8vHcABEp9bflCN5r/y7InWuyVxk3V2xvhz2UCwG5QdYQKAz9khF0c6GrXZr6iRA9eWKwnLJcmycIkFxaAWEZsKlZGMZCbnPfQzBLffhH0UswSaH16jgWAV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=cMft6xD86Lnvze5u8R8A:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeEOUAI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 16:00:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeEOTsv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:48:51 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/32] fs: update documentation to mention __poll_t and match the code
Date: Tue, 15 May 2018 21:48:04 +0200
Message-Id: <20180515194833.6906-4-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515194833.6906-1-hch@lst.de>
References: <20180515194833.6906-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/Locking | 2 +-
 Documentation/filesystems/vfs.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 75d2d57e2c44..220bba28f72b 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -439,7 +439,7 @@ prototypes:
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iterate) (struct file *, struct dir_context *);
-	unsigned int (*poll) (struct file *, struct poll_table_struct *);
+	__poll_t (*poll) (struct file *, struct poll_table_struct *);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 5fd325df59e2..f608180ad59d 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -856,7 +856,7 @@ struct file_operations {
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iterate) (struct file *, struct dir_context *);
-	unsigned int (*poll) (struct file *, struct poll_table_struct *);
+	__poll_t (*poll) (struct file *, struct poll_table_struct *);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
-- 
2.17.0

