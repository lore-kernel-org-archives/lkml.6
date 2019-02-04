Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451F2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182BA2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfBDVZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:25:21 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41087 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbfBDVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:25:20 -0500
X-Originating-IP: 86.202.150.119
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 488191C0002;
        Mon,  4 Feb 2019 21:25:18 +0000 (UTC)
Date:   Mon, 4 Feb 2019 22:25:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC support
Message-ID: <20190204212517.GC24598@piout.net>
References: <20190117184608.20987-1-panfilov.artyom@gmail.com>
 <20190130214828.GK19959@piout.net>
 <58b5d6e0-a1a5-59c5-3994-87852d62891e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b5d6e0-a1a5-59c5-3994-87852d62891e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2019 03:36:54+0300, Artem Panfilov wrote:
> Hi Alexandre,
> 
> On 31.01.2019 0:48, Alexandre Belloni wrote:
> 
> >> +#endif /* CONFIG_RTC_DRV_ABEOZ9_HWMON */
> > This comment is not correct
> 
> Thank you for your remarks. Can I add HMON support as Kconfig build option?
> 

I'm not sure this is useful and most of the drivers are now moving away
from additional options.

> Regards,
> Artem

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
