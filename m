Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA3C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EF32081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EF32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeKHSYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:24:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58417 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKHSYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:24:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8567520787; Thu,  8 Nov 2018 09:50:22 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2421D2039F;
        Thu,  8 Nov 2018 09:50:22 +0100 (CET)
Date:   Thu, 8 Nov 2018 09:50:22 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: Applied "spi: Add QuadSPI driver for Atmel SAMA5D2" to the spi
 tree
Message-ID: <20181108095022.66ad3ad1@bbrezillon>
In-Reply-To: <20181107151836.GB6809@sirena.org.uk>
References: <20181105103625.9644-6-bugalski.piotr@gmail.com>
        <20181107150327.B6DC41124E14@debutante.sirena.org.uk>
        <20181107151836.GB6809@sirena.org.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, 7 Nov 2018 15:18:36 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 07, 2018 at 03:03:27PM +0000, Mark Brown wrote:
> > The patch
> > 
> >    spi: Add QuadSPI driver for Atmel SAMA5D2
> > 
> > has been applied to the spi tree at
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git   
> 
> Sorry, I got confused about which patch series Boris had asked me to
> apply for him - it wasn't this one!  Since the review looked like it was
> just one minor issue last time I'll just leave them for now, they were
> applied on a separate branch for sharing with the MTD tree so it's easy
> for me to drop them if that's required or if I should put together the
> pull request for MTD.  Sorry for any confusion this ends up causing,
> it's entirely my mistake.

I'm probably missing something, but I don't see where you made a
mistake :-). It's indeed the series I asked you to merge, the only
comment I had was actually a suggestion to help Piotr solve his perf
issue (which was already present in the old driver).

And thanks for creating the mtd topic branch BTW.

Regards,

Boris
