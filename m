Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417DB13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC65820881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC65820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=trinity.fluff.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeG3LFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:05:49 -0400
Received: from trinity.fluff.org ([89.16.178.74]:39341 "EHLO trinity.fluff.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeG3LFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:05:48 -0400
X-Greylist: delayed 1621 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2018 07:05:48 EDT
Received: from ben by trinity.fluff.org with local (Exim 4.72)
        (envelope-from <ben@trinity.fluff.org>)
        id 1fk46c-0005RD-65; Mon, 30 Jul 2018 10:04:42 +0100
Date:   Mon, 30 Jul 2018 10:04:42 +0100
From:   Ben Dooks <ben@trinity.fluff.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        jonathanh@nvidia.com
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: tegra: Add a TDM configuration
 callback
Message-ID: <20180730090441.GE28143@trinity.fluff.org>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-3-jorge.sanjuan@codethink.co.uk>
 <20180730084908.GB5789@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730084908.GB5789@sirena.org.uk>
X-Disclaimer: These are my views alone.
X-URL:  http://www.fluff.org/
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@trinity.fluff.org
X-SA-Exim-Scanned: No (on trinity.fluff.org); SAEximRunCond expanded to false
X-Clacks-Overhead: "GNU Terry Pratchett"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:49:08AM +0100, Mark Brown wrote:
> On Fri, Jul 27, 2018 at 01:59:29PM +0100, Jorge Sanjuan wrote:
> > From: Edward Cragg <edward.cragg@codethink.co.uk>
> > 
> > Add a callback to configure TDM settings for the Tegra30
> > I2S ASoC 'platform' driver.
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
> 
> This says it was britten by Edward but there's a signoff from Ben before
> his?

Editing accdient, I was originally going to submit this series.
 
> > +	dev_dbg(dai->dev, "%s: setting TDM: tx_mask: 0x%08x rx_mask: 0x%08x"
> > +		"slots: 0x%08x width: %d\n",
> > +		__func__, tx_mask, rx_mask, slots, slot_width);
> 
> Please don't split log messages over lines, it makes it harder to grep
> for them.  Just use a long line.
> 
> I'm also not seeing any validation of the parameters?



> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

