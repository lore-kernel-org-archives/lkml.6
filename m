Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A9CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC477218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394323AbfBNQDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:03:06 -0500
Received: from muru.com ([72.249.23.125]:38858 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391103AbfBNQDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:03:05 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 555F980EA;
        Thu, 14 Feb 2019 16:03:15 +0000 (UTC)
Date:   Thu, 14 Feb 2019 08:03:02 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Florian Vaussard <florian.vaussard@epfl.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mfd: twl6040: Fix device init errors for ACCCTL register
Message-ID: <20190214160302.GE5720@atomide.com>
References: <20190211225726.38355-1-tony@atomide.com>
 <20190214092045.GD13737@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214092045.GD13737@dell>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [190214 09:21]:
> On Mon, 11 Feb 2019, Tony Lindgren wrote:
> > +		ret = regcache_sync(twl6040->regmap);
> > +		if (ret) {
> > +			dev_err(twl6040->dev, "%s register write failed: %i\n",
> > +				__func__, ret);
> 
> Please drop the __func__ and just use the standard format.
> 
> Wouldn't something a little more forthcoming be better?
> 
> "Failed to sync with the HW" ?

Sure I'll send an updated patch.

Regards,

Tony
