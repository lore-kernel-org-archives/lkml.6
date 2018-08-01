Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380E0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CF320844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CF320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbeHAIwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:52:51 -0400
Received: from verein.lst.de ([213.95.11.211]:32830 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387475AbeHAIwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:52:50 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B0B419ED64; Wed,  1 Aug 2018 09:13:07 +0200 (CEST)
Date:   Wed, 1 Aug 2018 09:13:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
        palmer@sifive.com, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 4/6] dt-bindings: interrupt-controller: RISC-V local
        interrupt controller docs
Message-ID: <20180801071307.GA20224@lst.de>
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-5-hch@lst.de> <20180731223714.GA12168@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731223714.GA12168@rob-hp-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 04:37:14PM -0600, Rob Herring wrote:
> On Wed, Jul 25, 2018 at 11:36:47AM +0200, Christoph Hellwig wrote:
> > From: Palmer Dabbelt <palmer@dabbelt.com>
> > 
> > This patch adds documentation on the RISC-V local interrupt controller,
> > which is a per-hart interrupt controller that manages all interrupts
> > entering a RISC-V hart.  This interrupt controller is present on all
> > RISC-V systems.
> > 
> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  .../interrupt-controller/riscv,cpu-intc.txt   | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> 
> My questions and comments on the prior version from Palmer remain.

Can you point to these questions please?  I don't even rember when this
was last posted as it must have been a long time ago.
