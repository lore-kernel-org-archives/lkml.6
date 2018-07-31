Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BC2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C016D20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C016D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeGaT6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:58:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47295 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeGaT6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:58:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0192B207AA; Tue, 31 Jul 2018 20:16:38 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id C80A720756;
        Tue, 31 Jul 2018 20:16:27 +0200 (CEST)
Date:   Tue, 31 Jul 2018 20:16:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v4 0/3] Add support for MSCC Ocelot SPI
Message-ID: <20180731181628.GX28585@piout.net>
References: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
 <20180731173809.eovsuiezlqzud7zi@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731173809.eovsuiezlqzud7zi@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2018 10:38:09-0700, Paul Burton wrote:
> Hi Alexandre,
> 
> On Tue, Jul 31, 2018 at 04:38:52PM +0200, Alexandre Belloni wrote:
> > Hello,
> > 
> > This series only contains the DT documentation and the corresponding DT addition
> > since it has been rebased on spi-next.
> > 
> > Alexandre Belloni (3):
> >   spi: dw: document Microsemi integration
> >   mips: dts: mscc: Add spi on Ocelot
> >   mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123
> > 
> >  .../devicetree/bindings/spi/snps,dw-apb-ssi.txt       |  6 ++++--
> >  arch/mips/boot/dts/mscc/ocelot.dtsi                   | 11 +++++++++++
> >  arch/mips/boot/dts/mscc/ocelot_pcb123.dts             | 10 ++++++++++
> >  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> Thanks - looks like the DT binding has been accepted, so I've applied
> patches 2 & 3 to mips-next for 4.19.
> 

Thank you, it is great to see that going in as this makes the platform
much more useful !


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
