Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9A4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6332064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6332064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeH2WAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:00:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35123 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbeH2WAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:00:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B07642072F; Wed, 29 Aug 2018 20:02:43 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 81CEF203EC;
        Wed, 29 Aug 2018 20:02:43 +0200 (CEST)
Date:   Wed, 29 Aug 2018 20:02:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>
Subject: Re: [andriy.shevchenko@linux.intel.com: Re: [PATCH] spi: dw-mmio:
 add MSCC Jaguar2 support]
Message-ID: <20180829180242.GH16561@piout.net>
References: <20180829150955.GB7459@smile.fi.intel.com>
 <20180829151501.GE27808@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829151501.GE27808@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On 29/08/2018 16:15:02+0100, Mark Brown wrote:
> On Wed, Aug 29, 2018 at 06:09:55PM +0300, Andy Shevchenko wrote:
> > ----- Forwarded message from Andy Shevchenko <andriy.shevchenko@linux.intel.com> -----
> > 
> > Date: Wed, 29 Aug 2018 18:08:31 +0300
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Subject: Re: [PATCH] spi: dw-mmio: add MSCC Jaguar2 support
> > User-Agent: Mutt/1.10.1 (2018-07-13)
> > 
> > On Wed, Aug 29, 2018 at 02:45:48PM +0200, Alexandre Belloni wrote:
> > > Unfortunately, the Jaguar2 CPU_SYSTEM_CTRL register set has a different
> > > layout than the Ocelot one. Handle that while keeping most of the code
> > > common.
> > 
> > > -#define OCELOT_IF_SI_OWNER_MASK			GENMASK(5, 4)
> > 
> > > +			   0x3 << if_si_owner_offset,
> > 
> > Perhaps,
> > 
> > #define MSCC_IF_SI_OWNER_MASK		GENMASK(1, 0)
> 
> Oops, sorry - that seems to have been eaten somewhere.  :(

Do you want me to send a new version or a patch that you could squash in
the second one?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
