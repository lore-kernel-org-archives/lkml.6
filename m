Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525295707-2-14885306948387932763
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
    1525295707; b=OWZeoqw2an2nK2DHC3kd06Iy83oD6czWRtC9iTjTMPy/gLrfxV
    RJf7jYFlrDOgZOXHABGRNZVJ9s4eTA5Ha+ToQF8yopC1XDfLrqNReX6AjMjTbnMz
    xoHyZHKgvj3NdNlo2ssUOCTU1/PcYNwBHPK9+kJmfwyOJO0ZzKbcrwM7vP9Vf8y1
    m7mca33pkU5H5Yz8hQqW9yzQE/rugfE0cWc7HNI9rUNniBR1pi+CYH7Pee4J6WCc
    23dkDflTb779DGELijSJRINX+WnmCnd1nay3ve8wBPkL98VW9dZWX5dWyT05ifqX
    yr7DdtCGuzH0qjSUksedlbc6VFIDaKTxJ/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295707; bh=
    UkcPF8lCPo56DZSL9c76JY6Exr2PfUlv5xf1yxVcOdk=; b=aOmEMmK35gUT9LQS
    SpmBZtLDmSoEJrJellboDW0r3UiCUypYRrUV0VjcflUY4igHci2qAEINq0h6j+tW
    Po2XYrZD/6x3iAcgSIUrOsTuLqYxBTbECGHIcu7dTCjAo6p7y8rlYxEZU4CKiYY2
    rr4IQV+BjaKc9i2V4smyD+OFh5NMmdBhKnMmsz80asiEYqGJUwdDh1TufQ4WSAOh
    m32R5v0DzDo+6rWVBGR8QOJMLQaxibU6aHjq8MdX2eFGqQ71OM3KDfnCgQFN/Py8
    AOki3zWZ/0nIlt1fLL73ckAaV6/QFXyJYOrPZC9JD8/FdhV2/clWEjvBdsHxk0If
    o40kCg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=H92GI4iS
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
      header.d=infradead.org header.i=@infradead.org header.b=H92GI4iS
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
X-CM-Envelope: MS4wfKhqYyMGIIeuYqysw+hwsdqljA1klnjtt9XnoRKM5rK/CQcuurKMJw8X70rWDndG4HzwgNacoIZLeRxbdscCmpIX+5UZdHCkFSL6YQs1BlJ/jMDNX5Cl
    EsqGPVasAbR1ZyRoUm6UTOX++js+JMhXLp+Aom3FL+OO4/ryl3eN8zgcl1ufFBciK3ICtwRwCNnuUqsXlBJjNkAAe5HAZgT1fAcnZU9aoQkGIGpvkX5fIhvK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=nqugOTiPH4_ZKRbTVM0A:9
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeEBVPF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:15:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeEBVPB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 17:15:01 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] aio: don't print the page size at boot time
Date: Wed,  2 May 2018 23:14:42 +0200
Message-Id: <20180502211448.18276-2-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502211448.18276-1-hch@lst.de>
References: <20180502211448.18276-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The page size is in no way related to the aio code, and printing it in
the (debug) dmesg at every boot serves no purpose.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 88d7927ffbc6..add46b06be86 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -264,9 +264,6 @@ static int __init aio_setup(void)
 
 	kiocb_cachep = KMEM_CACHE(aio_kiocb, SLAB_HWCACHE_ALIGN|SLAB_PANIC);
 	kioctx_cachep = KMEM_CACHE(kioctx,SLAB_HWCACHE_ALIGN|SLAB_PANIC);
-
-	pr_debug("sizeof(struct page) = %zu\n", sizeof(struct page));
-
 	return 0;
 }
 __initcall(aio_setup);
-- 
2.17.0

