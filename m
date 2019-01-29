Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC81CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62A520989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfA2Osk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:48:40 -0500
Received: from muru.com ([72.249.23.125]:36560 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfA2Osj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:48:39 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 51985804F;
        Tue, 29 Jan 2019 14:48:47 +0000 (UTC)
Date:   Tue, 29 Jan 2019 06:48:36 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
Subject: Re: linux-5.0-rc3, ti-soc-thermal: unmet dependencies Kconfig warning
Message-ID: <20190129144835.GZ5720@atomide.com>
References: <8baafd04-eda0-778d-84d2-7ccc1d07db6b@infradead.org>
 <20190128163433.GY5720@atomide.com>
 <6c970fca-35ea-f327-3f77-9b61c37554d5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c970fca-35ea-f327-3f77-9b61c37554d5@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190129 03:39]:
> On 28/01/19 10:04 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Randy Dunlap <rdunlap@infradead.org> [190126 06:54]:
> >> Hi,
> >>
> >> FYI, I'm seeing this Kconfig warning in 5.0-rc3:
> > 
> > Thanks for reporting it.
> > 
> >> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
> >>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP || COMPILE_TEST [=n]) && HAS_IOMEM [=y]
> >>   Selected by [m]:
> >>   - MMC_SDHCI_OMAP [=m] && MMC [=m] && MMC_SDHCI_PLTFM [=m] && OF [=y]
> >>
> >>
> >> Maybe there is already a patch for this?
> > 
> > Keerthy can you please take a look at this issue?
> 
> https://lore.kernel.org/patchwork/patch/1030366/
> 
> This is fixed. It is in the linux-next already.

OK good to hear thanks!

Tony
