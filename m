Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SIYHJEv8GFsVDwAAmS7hNA
	; Thu, 07 Jun 2018 10:26:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 08279602FC; Thu,  7 Jun 2018 10:26:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8943D602FC;
	Thu,  7 Jun 2018 10:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8943D602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932637AbeFGK0M (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:26:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55578 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932118AbeFGK0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:26:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C18BA80592; Thu,  7 Jun 2018 12:26:09 +0200 (CEST)
Date: Thu, 7 Jun 2018 12:26:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, aaro.koskinen@iki.fi
Subject: Re: Common config for N900 and D4
Message-ID: <20180607102607.GA4372@localhost>
References: <20180603104839.GA21197@amd>
 <20180603165336.GA26995@amd>
 <20180603210115.GA7438@amd>
 <20180605042627.GB5738@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605042627.GB5738@atomide.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > [    0.000000] L2C-310 erratum 727915 enabled
> > > > [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> > > > [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> > > 
> > > I tried disabling outer cache to get rid of this. That got me further
> > > in boot, but not to working system:
> > 
> > I now have config that works.
> > 
> > My kernels were probably grossly misconfigured (OMAP4 not enabled on
> > droid4)... still I'd expect some kind of panic explaining board is not
> > compatible with kernel, not a random oops...
> 
> Like "clk-provider not found" error? :) I agree it's not very
> descriptive and I think we could easily print something from
> after the SoC detection for missing pdata.

If you had patch for testing, or pointer where such check would
belong, that would be nice. I might try to do something, but now it
boots so it is not too high priority for me.

Thanks,
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
