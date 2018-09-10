Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7799C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6601D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6601D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeIJSyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:54:33 -0400
Received: from muru.com ([72.249.23.125]:55732 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeIJSyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:54:33 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E790380B6;
        Mon, 10 Sep 2018 14:04:22 +0000 (UTC)
Date:   Mon, 10 Sep 2018 07:00:14 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] mfd: omap-usb-host: Fix dts probe of children
Message-ID: <20180910140014.GS5662@atomide.com>
References: <20180425142922.128233-1-tony@atomide.com>
 <20180830221853.GX7523@atomide.com>
 <20180910111408.GK28860@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910111408.GK28860@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [180910 11:18]:
> On Thu, 30 Aug 2018, Tony Lindgren wrote:
> 
> > Lee,
> > 
> > * Tony Lindgren <tony@atomide.com> [180425 07:31]:
> > > It currently only works if the parent bus uses "simple-bus". We
> > > currently try to probe children with non-existing compatible values.
> > > And we're missing .probe.
> > > 
> > > I noticed this while testing devices configured to probe using ti-sysc
> > > interconnect target module driver. For that we also may want to rebind
> > > the driver, so let's remove __init and __exit.
> > > 
> > > Cc: Roger Quadros <rogerq@ti.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > > 
> > > This is OK to wait for v4.18 merge window as the related dts node has
> > > not yet been updated to probe via ti-sysc interconnect target driver.
> > 
> > Sorry I just noticed this is still pending, it should be
> > applied as a fix for the -rc series.
> > 
> > Do you want me to resend the patch?
> 
> Just back from vacation.

Welcome back :)

> No thanks, I'll get to it.

OK thanks!

Tony

