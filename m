Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E900DC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30B920020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30B920020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754648AbeFTSpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:45:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34734 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753541AbeFTSpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:45:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6E65A206D8; Wed, 20 Jun 2018 20:45:16 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7EAD320CFE;
        Wed, 20 Jun 2018 20:44:48 +0200 (CEST)
Date:   Wed, 20 Jun 2018 20:44:49 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        alsa-devel@alsa-project.org, nicolas.ferre@microchip.com,
        boris.brezillon@bootlin.com, broonie@kernel.org, sboyd@kernel.org,
        Cristian.Birsan@microchip.com
Subject: Re: [PATCH v5 1/5] dt-bindings: clk: at91: add an I2S mux clock
Message-ID: <20180620184449.GH7737@piout.net>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
 <20180620154759.GA4755@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620154759.GA4755@rob-hp-laptop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 09:47:59-0600, Rob Herring wrote:
> On Mon, Jun 18, 2018 at 05:12:35PM +0300, Codrin Ciubotariu wrote:
> > The I2S mux clock can be used to select the I2S input clock. The
> > available parents are the peripheral and the generated clocks.
> > 
> > Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> > ---
> > 
> > Changes in v5:
> > 	- specified clock's parent;
> > 	- added a newline before adding the clock's compatible string;
> > 
> >  .../devicetree/bindings/clock/at91-clock.txt  | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> 
> Well, since Alexandre promises all this is going to get re-worked soon:
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, I'm planning to send a first version next week, it will be based
on top of that series.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
