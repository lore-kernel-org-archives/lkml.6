Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2B3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CFC205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404787AbfAPP6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:58:15 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37440 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfAPP6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:58:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AF3B420955; Wed, 16 Jan 2019 16:58:12 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5F871207AC;
        Wed, 16 Jan 2019 16:58:12 +0100 (CET)
Date:   Wed, 16 Jan 2019 16:58:12 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
Message-ID: <20190116165812.1ca10804@windsurf>
In-Reply-To: <20190116154717.GQ5544@atomide.com>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
        <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
        <20190116132747.GB11050@ulmo>
        <20190116154717.GQ5544@atomide.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 16 Jan 2019 07:47:18 -0800, Tony Lindgren wrote:

> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > 
> > Adding Tony and linux-omap for a slightly wider audience and hopefully
> > find someone to test this on. For reference, the whole series is here:
> > 
> > 	https://patchwork.kernel.org/project/linux-mmc/list/?series=66905  
> 
> Thanks Kishon can you please review and test?

I think Adrian's comment that ->get_ro() should be called first in the
core code makes sense, so I'll send a v2 with this change. Perhaps
testing should be done on the v2 instead, even though I believe it
should be functionally equivalent.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
