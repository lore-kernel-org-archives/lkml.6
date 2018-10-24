Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CC0ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A9C20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A9C20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJYBg4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:36:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50361 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeJYBg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:36:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DA2E920A7D; Wed, 24 Oct 2018 19:08:03 +0200 (CEST)
Received: from localhost (unknown [185.7.230.213])
        by mail.bootlin.com (Postfix) with ESMTPSA id 10B2620993;
        Wed, 24 Oct 2018 19:07:51 +0200 (CEST)
Date:   Wed, 24 Oct 2018 18:07:51 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH] arm64: defconfig: Enable MFD_AXP20X_I2C
Message-ID: <20181024170751.uf4xxo4h7ew5lpne@flea>
References: <20180731133828.2582-1-jagan@amarulasolutions.com>
 <20180731134036.mzgntiv6fwxg2vja@flea>
 <CAMty3ZC2==BYChib71qyzd7oRkUHB3hunKw2FGRj3t=U2vK5nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMty3ZC2==BYChib71qyzd7oRkUHB3hunKw2FGRj3t=U2vK5nw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 01:52:37PM +0530, Jagan Teki wrote:
> On Tue, Jul 31, 2018 at 7:10 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, Jul 31, 2018 at 07:08:28PM +0530, Jagan Teki wrote:
> > > The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
> > > connected via I2C.
> > >
> > > Enable the driver for this PMIC.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Can you apply this? needed for mmc to detect on H6

Please resend it.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
