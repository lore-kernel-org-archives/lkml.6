Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2463566-1526990697-2-4828647346917275823
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526990696; b=Co74fxABHBJv5j6+iU9ojMx9/vqMeXRGyE1FkEaHF47T0vK6M1
    PkCgY6xyonPTOWkmdw6G9mXTHqXnEd+VE8VIGXGt6hbmo6pWLKe4m3UBGDNyhjyV
    rWSPrSMcNeZKtJ5tcayQx6IR78LrIPHO6H0J73jtQlXpg7zgEjJJchqwkYzs0gW7
    gp7j2T/zFU34k7Fvf5J1oJBWyo2HOAAdcqFIpQylBqjRj8HqQCc5NNdfKKJ/Skht
    u4gjYq461JcNoop6SVQBo5RhbSNmDcMbD29l0su3n3EZBb1AUQvlexHxjOrZ5dAB
    wjNjgeSL5jOU5546ocn0m55IIb5h2xubxk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526990696; bh=
    hI3OXgIID5yBx5WeNw19cRYoKq7b3+UClm8FsQoHHIk=; b=imJqqrhN+2NFaHbU
    B3ZOTTVHbuZOr2IxGINvx9pHTxj9hVHM4Pe6O+LJpVHrPHYq3dzYlk7EdQhPre76
    JVV6wOadALH2IDQkhkpb6GrP76rY5/sNwZjZsuZKG/G27AweJLCc6FSMrlZMIc6D
    jJ4u5BZBGBArhyRW20ru5BWn1AaaPyEE/j7ymTo9RPo1LJTNUwdDpuAZsjiS66Za
    GPZJjCYYm2y0mHM6AH1/rbdVzADDZVdHTImwKRquAJa54JkDXeYO3wryjv3Ug8Yn
    Sq4EiD5KdcLsJx+LXcY7/J58YBHLGw20B0BypPwaWc1Nl40w9L1YtiXTTqMM4up6
    UP/xHg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=I4TTKp0v
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=I4TTKp0v
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL9wpJS+kfQqxto+ElQdi0ENVacSxkGEwNJ821wiGOT61bkUqM0tGbe1J+sxpm7DmCjgbmJ9fbWGhdvnt+yxsrz/0zHHRH/PDngygwVNL6f5YeZbYrel
    QWy7PhAfpRUOAbkcjaHVJEzMIkpKVkRpSVfJHRSNsiWddpWtzbt7gU75R4ivJ4tnGZiOKL1tv51JmA8HvJHnuEDH/Xi5fYbni/tdQ/LSf3hm7eI4rOdMK7es
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=rHKRJJzVt6977jGYumQA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeEVMEw (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:04:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeEVMEt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:04:49 -0400
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] hexagon: remove the sync_single_for_cpu DMA operation
Date: Tue, 22 May 2018 14:04:06 +0200
Message-Id: <20180522120430.28709-2-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

hexagon does all the required cache maintainance at dma map time, and none
at unmap time.  It thus has to implement sync_single_for_device to match
the map cace for buffer reuse, but there is no point in doing another
invalidation in the sync_single_cpu_case, which in terms of cache
maintainance is equivalent to the unmap case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 77459df34e2e..d2b717f352f4 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -181,13 +181,6 @@ static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
 	return bus;
 }
 
-static void hexagon_sync_single_for_cpu(struct device *dev,
-					dma_addr_t dma_handle, size_t size,
-					enum dma_data_direction dir)
-{
-	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
-}
-
 static void hexagon_sync_single_for_device(struct device *dev,
 					dma_addr_t dma_handle, size_t size,
 					enum dma_data_direction dir)
@@ -205,7 +198,6 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.free		= hexagon_free_coherent,
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
-	.sync_single_for_cpu = hexagon_sync_single_for_cpu,
 	.sync_single_for_device = hexagon_sync_single_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
-- 
2.17.0
