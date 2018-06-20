Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0026C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40AA20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40AA20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeFTKxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:53:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49013 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752787AbeFTKxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:53:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0C3A42087B; Wed, 20 Jun 2018 12:53:41 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id CE2BE20862;
        Wed, 20 Jun 2018 12:53:30 +0200 (CEST)
Date:   Wed, 20 Jun 2018 12:53:31 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, arm@kernel.org, linux-kernel@vger.kernel.org,
        matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 18/20] dts: sama5d2: Update coresight bindings for
 hardware ports
Message-ID: <20180620105331.GD7737@piout.net>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-19-git-send-email-suzuki.poulose@arm.com>
 <20180619212417.GB3128@piout.net>
 <abf65bac-0956-f1de-127e-38b0f41a6233@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf65bac-0956-f1de-127e-38b0f41a6233@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 10:44:29+0100, Suzuki K Poulose wrote:
> On 19/06/18 22:24, Alexandre Belloni wrote:
> > On 05/06/2018 22:43:29+0100, Suzuki K Poulose wrote:
> > > Switch to the new coresight bindings for hardware ports
> > > 
> > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   arch/arm/boot/dts/sama5d2.dtsi | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > Applied, thanks.
> > 
> 
> Alexandre,
> 
> Please hold off applying this change, as we are yet to come to an
> agreement on this. Sorry for the trouble. See [0]
> 

I've removed it.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
