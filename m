Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95915C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BD020811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390333AbfA1Qej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:34:39 -0500
Received: from muru.com ([72.249.23.125]:36298 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388052AbfA1Qeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:34:37 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 91EEA80AA;
        Mon, 28 Jan 2019 16:34:44 +0000 (UTC)
Date:   Mon, 28 Jan 2019 08:34:33 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Randy Dunlap <rdunlap@infradead.org>, Keerthy <j-keerthy@ti.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
Subject: Re: linux-5.0-rc3, ti-soc-thermal: unmet dependencies Kconfig warning
Message-ID: <20190128163433.GY5720@atomide.com>
References: <8baafd04-eda0-778d-84d2-7ccc1d07db6b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8baafd04-eda0-778d-84d2-7ccc1d07db6b@infradead.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Randy Dunlap <rdunlap@infradead.org> [190126 06:54]:
> Hi,
> 
> FYI, I'm seeing this Kconfig warning in 5.0-rc3:

Thanks for reporting it.

> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP || COMPILE_TEST [=n]) && HAS_IOMEM [=y]
>   Selected by [m]:
>   - MMC_SDHCI_OMAP [=m] && MMC [=m] && MMC_SDHCI_PLTFM [=m] && OF [=y]
> 
> 
> Maybe there is already a patch for this?

Keerthy can you please take a look at this issue?

Regards,

Tony
