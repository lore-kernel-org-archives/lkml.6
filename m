Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ACAECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2A820869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2A820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeJTAvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:51:47 -0400
Received: from muru.com ([72.249.23.125]:52434 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbeJTAvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:51:47 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 279A380BF;
        Fri, 19 Oct 2018 16:44:52 +0000 (UTC)
Date:   Fri, 19 Oct 2018 09:44:50 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: omap4: support for manually updated display
Message-ID: <20181019164450.GD43338@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com>
 <20181018221549.GB6364@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018221549.GB6364@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181018 22:15]:
> Hi!
> 
> > > I want to make it clear that I don't want to claim any privilege in getting 
> > > patches merged first. I am however worried that, without an easy way to test 
> > > DSI support, and without enough time to focus on it, I would break whatever 
> > > would be merged now in future reworks. I would thus like to find out how to 
> > > collaborate on this task, hopefully to move towards usage of drm_bridge and 
> > > drm_panel for DSI-based pipelines.
> > 
> > Real users with mainline kernel with a real product should
> > always have priority over any ongoing clean-up.
> > 
> > And for testing, a bunch of real users is something you can't
> > beat for proper testing of code on ongoing basis!
> > 
> > Naturally the burden of getting the patches ready is on the people
> > using them for rebase and fixing comments. And Sebastian has
> > already agreed help with maintaining it.
> > 
> > I've been actually using DSI command mode support and testing
> > Linux next several times a week to prevent regressions from
> > sneaking into -rc1 in general. So now I can't test omapdrm with
> > next until Sebastian is done with rebasing.. Back to headless
> > testing then.
> > 
> > Anyways, I'd say let's add the DSI command mode support ASAP after
> > rebasing, there are at least Sebastian, Pavel and I then testing
> > and helping with further ongoing panel conversion work.
> 
> Are there any news here? Does someone have a patch set that actually
> works?

I was wondering about that too.. I only have the v4.19-rc1 based
patches and can no longer test with Linux next. Sebastian, any
update?

> Are there any in-progress patches I could help with?

I can put in some effort too if needed.

Regards,

Tony

