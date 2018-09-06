Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF73AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A7E20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="frGihvTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A7E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeIFSmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:42:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeIFSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2YdehL+UmAzf86WL6WZ8b9Ys4F7LDbl/wT8Tg6RpDsM=; b=frGihvTu0tlxz8lUNCewNagzF
        WmVljuRvlY+JocOMOH/tQgJH9Q2jfU5sS2mIZ4I97zOX5kJtICqv29DJp1Gh9TJzuxPEHtUHfzTVG
        xZ61CdSNvTaeqnEM48qL/JQnAGgQj3xtPjPWhgAJYUR5Izr5z2wn8QBPPnPCscXFq1bxcrApZGr2N
        GV8Mo8Xow9BLA1FvFRw7n+SiNEiwA0VNKHBAAxBwXzTzr9H1lzJzkGQHnLryTjBGuZ2X3xT5I9X07
        tNvyc/GP6rHEDia4HI/n8YWaahTbdr1pC5ZHK3Ij1eK4D77h2fYd8UWheWiq3rRRaYI4NcNleYgEE
        tEmFPLvhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxuvU-0004LY-TS; Thu, 06 Sep 2018 14:06:28 +0000
Date:   Thu, 6 Sep 2018 07:06:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180906140628.GA10580@infradead.org>
References: <20180906123651.28500-1-anup@brainfault.org>
 <20180906123651.28500-4-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906123651.28500-4-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as before:  NAK to entirely pointless abstractions.  Please stop
beating the dead horse.
