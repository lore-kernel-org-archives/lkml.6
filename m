Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823B5C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267C9214ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erd7WbJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267C9214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389026AbeHGPAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:00:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbeHGPAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P9mFXoaYDcAzlaeHkHU0tKPP2EFw3OeaAy42ssg7NOA=; b=erd7WbJCbJnw8oZ2eSuV1PMhO
        et3NZqdFW/i3eT7ujeOa4V9UIHY0le57LbPXHqkB+iU/hq7c4Jb15mnbKuByKlFKooMMC3RVt+tfp
        lqahAoNRAeolvpKg+WSCBpBOJsEFMjU4R6nRxHwD20NPlZYbb/Prj7nn5KxlGzvDumhBUaQ2d2Dhn
        ieGHHPcPZFIhp8/CkzsLk8mtxWmI5HLq4EpcDKJHq03XhACQXhIsx79R9xiYFd8uI06SWqFSdq1ha
        Gms/ju2vM+p48/6rgnZaA/I4MHbU3hXdxzZFBM6VvzS76k3GlYSCoUEjV66EYgx8poB6q792oB+RU
        IHhypdH8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fn1Mv-0005Gm-Cz; Tue, 07 Aug 2018 12:45:45 +0000
Date:   Tue, 7 Aug 2018 05:45:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        linux-kernel@vger.kernel.org, Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: [PATCH v2] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
Message-ID: <20180807124545.GA15202@infradead.org>
References: <20180804085438.GA15840@infradead.org>
 <20180806204258.22280-1-palmer@sifive.com>
 <20180806204258.22280-2-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806204258.22280-2-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine (modulo any typos):

Reviewed-by: Christoph Hellwig <hch@lst.de>
