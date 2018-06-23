Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B420AC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E2624B4B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GqLyGVL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E2624B4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeFWHYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 03:24:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeFWHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 03:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yhVxFenIgPub/w/35qpJsH+EleYVEBaF1uzR5/OHDEM=; b=GqLyGVL0pub+oWHddcjElDbuE
        nUqURLBIOWFQt+RUfSAGccrt7XKb0mFDGOX+gsJxtCdPPcYzC2FKgG0aaxaMnzgavQJfygojpTUcJ
        4ngeZ2lYXlzncRVDQGpdbAoGBO0ZXU1WNRfmRnFl6otf3ms/E7LJKOi+MrNL3XPNZY+qHgb2XvtU0
        I1dQhcdYfz/OVzGXbXJFDJJgZQ7Z6V8yuDebYUNEXAUkWhD8AN3U8TRPxBvGHt0NFsufK8Ik5qsxm
        9lz7BE4z+hakEgAbtuja2PocQ2s+iLa3kn1quDlrsX07mxp6T2Dkxt16e1M6vSNJAQalIpY1KEgEx
        XHveo9KIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWcuZ-0006er-VN; Sat, 23 Jun 2018 07:24:43 +0000
Date:   Sat, 23 Jun 2018 00:24:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org,
        Michael Clark <michaeljclark@mac.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] RISC-V: Add early printk support via the SBI console
Message-ID: <20180623072443.GA25573@infradead.org>
References: <20180622221814.29025-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622221814.29025-1-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
