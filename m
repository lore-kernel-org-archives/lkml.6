Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC394C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40882082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SrQS7phe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40882082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeJBVbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:31:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeJBVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=SrQS7pheiN1m+P3EA8pg8G/08
        skuef9j9JydksQQg2ZLeNJojxUYkpssxbCyWfoVFe9FiXwQZj3QwVMtNeGZIiXD10cFhfe7MjjbBy
        asvz+tBc0/A3oIQqnYBwyMhHk/2dDKhtm6zJN/CX7d0Qu78OMdy1Hqc4c3+Xd5m89ITaJmLtG3cU4
        v7kwxds85ejLRu90x+IQuJJXZftJ/6rD08ztlcoaRdjJi+rnPQ95j1M9aoCSDdPbEhRvPU9nQL/Ns
        Os6FW5g3UZAWTtohfk0E7nM6dh2Z8gbEdNHSI7JS7UXZwopt9AgsGbhrjaSNmYrlne4ofLa0EarvT
        KyBJ4P6UA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7LxH-00011z-Rv; Tue, 02 Oct 2018 14:47:19 +0000
Date:   Tue, 2 Oct 2018 07:47:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, hch@infradead.org,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] RISC-V: Build tishift only on 64-bit
Message-ID: <20181002144719.GA3889@infradead.org>
References: <cover.1538470103.git.zongbox@gmail.com>
 <40c77db9ee2d23479ff90f2658539d29d7a30896.1538470103.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c77db9ee2d23479ff90f2658539d29d7a30896.1538470103.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
