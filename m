Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE16C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28A820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfBDQfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:35:51 -0500
Received: from muru.com ([72.249.23.125]:37480 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfBDQfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:35:51 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4CD16808C;
        Mon,  4 Feb 2019 16:35:58 +0000 (UTC)
Date:   Mon, 4 Feb 2019 08:35:46 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, s-anna@ti.com, david@lechnology.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 02/14] soc: ti: pruss: Add a platform driver for PRUSS
 in TI SoCs
Message-ID: <20190204163546.GJ5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-3-git-send-email-rogerq@ti.com>
 <99a3717c-7eab-07d2-e73e-f302c3848b8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99a3717c-7eab-07d2-e73e-f302c3848b8a@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [190204 14:52]:
> On 2/4/19 8:22 AM, Roger Quadros wrote:
> > From: Suman Anna <s-anna@ti.com>
> > +++ b/drivers/soc/ti/Kconfig
> > @@ -73,4 +73,16 @@ config TI_SCI_PM_DOMAINS
> >  	  called ti_sci_pm_domains. Note this is needed early in boot before
> >  	  rootfs may be available.
> >  
> > +config TI_PRUSS
> > +	tristate "TI PRU-ICSS Subsystem Platform drivers"
> > +	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX
> > +	select MFD_SYSCON
> > +	default n

Just a nitpick comment, we have n as the default already,
so default n can be dropped.

Regards,

Tony
