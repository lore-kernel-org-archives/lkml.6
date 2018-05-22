Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389970-1526988693-2-5750297967667709542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526988693; b=WGhuTfhXL3qIe4MSPRqMYbJnPUkf3ikhJbpCDTQIqrY6Z1L+C3
    A1G5Stspa8LQVL7CSOqs2OylfUUbhAcqM4Dk4JGxxiU+u2V+WJrgli9A1N3kyRCm
    bJ09TmNXHJ9T5pIaS+Ipf1NSY1Tm50ytjZbL0s8My0fo0gyrYuhHdegQln9q/h30
    mMUB5zI8WcWNTSo3LudOJ8bCo7LLOEpSAw52qrAT5a5TBmHJsqwVowxWO0wPDpTy
    WyFqO8Jdfx4qeGVR1DW2C5bi7SCzsnXsBO1Vyw8uZ7vDiBf3VWp1oK708pPBxsQ3
    a4G1DqLCuuwrpNP72m2qIznN6smh756/gjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526988693; bh=
    HniXHEEQLp8dYZswypFEpwmGtREL+15LHz6tGMUZuZ4=; b=d2hHlqMljTeItVWN
    I4mwEYMEpxiEJM4YzMTCOgQivZ6qVkGzZAR//xoSn1cumjMKy7HlEfPhGjbQqW3q
    EbuRx5IENeq2qYdYRytWKsrn+AP2CSg7Zr8rCs2JAcdASZmfuqTK0dP29ajVFUZs
    bToxooMA0JHL0l+GC77ickj/VufXlqqix1a/4DiKD9Ao6dtOJh5Oh7EC6J3lW4FZ
    /VfpQzhDZiSiXgVzLNrGtKgPlYYjN80Xz1BvaNEYK5zbIf7Q1HCpB/P4FWzDZeNj
    z8hk155Yn8IrBCQ9zyL/A9WSlXR1M8zx+sVSkuD+sjGMPu6s4dsOIS+wrB6SCaHz
    jw3PZQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=daiPZ5zF
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
      header.d=infradead.org header.i=@infradead.org header.b=daiPZ5zF
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
X-CM-Envelope: MS4wfByx/He3+X96Advxd2BTJxfH6Tmbg4r8qfbBqqxOEGF7j5bpp0JoXwvRAZo98D437hNgvyzb2EOYmiSbdEHoEax3A+MlN4KmT9BUxddABwq+ysPq2rSd
    ELp3wnB60VI5jrqIEQWLHlwDE2dDfv7lHQjVg9XeppvThL1sLTyOtNHXyeuB4LFHsL8fBt1uniT6ftHSfTORLmppUVDMhY9dJooUpRKaUmxPuCPG7nkk1VC4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=cMft6xD86Lnvze5u8R8A:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeEVLba (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:31:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeEVLb1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:31:27 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/31] fs: update documentation to mention __poll_t and match the code
Date: Tue, 22 May 2018 13:30:40 +0200
Message-Id: <20180522113108.25713-4-hch@lst.de>
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

