Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F43920651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfAOMXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:23:16 -0500
Received: from foss.arm.com ([217.140.101.70]:49178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbfAOMXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:23:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64E89A78;
        Tue, 15 Jan 2019 04:23:15 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35DCF3F70D;
        Tue, 15 Jan 2019 04:23:15 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 8F8BB682073; Tue, 15 Jan 2019 12:23:13 +0000 (GMT)
Date:   Tue, 15 Jan 2019 12:23:13 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: Re: linux-next: build failure after merge of the mali-dp tree
Message-ID: <20190115122313.GR20661@e110455-lin.cambridge.arm.com>
References: <20190115104619.516be4b9@canb.auug.org.au>
 <20190115101219.GP20661@e110455-lin.cambridge.arm.com>
 <20190115214725.360798cf@canb.auug.org.au>
 <20190115105102.GQ20661@e110455-lin.cambridge.arm.com>
 <20190115120836.GN10517@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115120836.GN10517@phenom.ffwll.local>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 01:08:36PM +0100, Daniel Vetter wrote:
> On Tue, Jan 15, 2019 at 10:51:02AM +0000, Liviu Dudau wrote:
> > On Tue, Jan 15, 2019 at 09:47:25PM +1100, Stephen Rothwell wrote:
> > > Hi Liviu,
> > > 
> > > On Tue, 15 Jan 2019 10:12:19 +0000 Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > > >
> > > > That looks like the right fix, thank you for that!
> > > 
> > > Thanks for your verification.
> > > 
> > > > I will roll your patch into my tree.
> > > 
> > > You can only do that when your tree is merged with the drm tree (and
> > > it should be part of the merge resolution).
> > 
> > I can also rebase on top of the latest drm-next tree, that should not be
> > a problem.
> 
> If you have a lot of patches already rebasing is kinda discouraged. There
> might be other stuff that's conflicting and then making your entire tree
> non-bisectable (maybe just on one platform that you missed in testing).

My tree has always been "unstable", I have been rebasing it on top of
latest drm or drm-next in preparation for sending pull requests. I've hoped
that people don't depend on the linearity of my tree anyway and it hasn't
been an issue so far.

TBH, I should've based the latest update of my tree on drm-next anyway, I
just started at the time when it was at v5.0-rc1 so I thought it will not
matter.

Best regards,
Liviu

> 
> In that case just send out a pull for drm-next and include the merge
> resolution in the pull request so Dave/I can double-check we did it right.
> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
