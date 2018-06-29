Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D2CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6305824A0A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aTyfVdMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6305824A0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeF2HMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:12:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeF2HMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gk8GaiwIbTdCksXByfp8xBqgyAChLaJOJhNBqirV+ls=; b=aTyfVdMapDwJA7Hfsp0uhoXOf
        houdp6tUSZvcM0qe6ou27F5iXEAuYAncHjwWscKE21yjbP6j5XVBhS523NTNLoPRqHl4AsMT0Ytar
        lVsya60/2uHJhCMPdc7t+KrU8xT6qtyYhYPCu+Z78DIQ9hENSDVMx+mY6LSnqC6UC7rAWoEpYPPjv
        6zWBNcLww8aVAazBV+07o5DkZtRK6oa+B1u+Fz7Kxrk6T4KpxjF9QIMj9gKy4goDkZo23CyfXkpNG
        PUFMNPbCG2jkFOiul4K1osNIOfCxuftqF9pn4r/oCgfP5CxFFj20phCuwcbmIw9M3HAcovuTIS3Wt
        66jktvgxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYnZt-0005IV-7N; Fri, 29 Jun 2018 07:12:21 +0000
Date:   Fri, 29 Jun 2018 00:12:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong@andestech.com>
Cc:     palmer@sifive.com, hch@infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zongbox@gmail.com, greentime@andestech.com
Subject: Re: [PATCH v2 4/4] RISC-V: Change variable type for 32-bit compatible
Message-ID: <20180629071220.GD12956@infradead.org>
References: <cover.1529915117.git.zong@andestech.com>
 <cce1b10179f858477ecadcadc164aae783a63c79.1529915117.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce1b10179f858477ecadcadc164aae783a63c79.1529915117.git.zong@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:49:40PM +0800, Zong Li wrote:
> Signed-off-by: Zong Li <zong@andestech.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
