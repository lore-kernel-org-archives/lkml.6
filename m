Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CDC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6BC20898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6BC20898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH1G0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:26:50 -0400
Received: from muru.com ([72.249.23.125]:54666 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeH1G0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:26:49 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 27B2A80CC;
        Tue, 28 Aug 2018 02:41:17 +0000 (UTC)
Date:   Mon, 27 Aug 2018 19:37:22 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, tomi.valkeinen@ti.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        daniel@fooishbar.org
Subject: Re: 4.19-rc1 on droid 4: screen not updating
Message-ID: <20180828023722.GK7523@atomide.com>
References: <20180827105121.GA8283@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827105121.GA8283@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180827 10:55]:
> Hi!
> 
> With Sebastian's patches, display works on Droid 4 in v4.18.

Hmm care to post your v4.18 patches somewhere too for people?
I'd have to look around for them since I've been using Linux
next for past few months.

Also, do you have v4.19-rc1 versions of your pending audio
patches somewhere? I'd like to play with voice calls again
now with my WIP pending n_gsm serdev patches..

> I had to do some manual merging, and I see kernel messages in
> v4.19-rc1, but they are frozen -- no updates.
> 
> a) does someone have it working?

I have had it working for few weeks since I'm following
Linux next. I just pushed Sebastian's patches I rebased
earlier today against v4.19-rc1 to [0][1].

> b) is there some way I can help to get it working in mainline? Droid 4
> is not exactly new, and this is painful point that makes it hard to
> use.

Well since Sebastian is busy according to [2], maybe try to update
Sebastian's mfd-ti-lmu backlight patches so they can get merged?
Please check with Sebastian, but that would cut down the pending
pile by quite a few patches.

Regards,

Tony

[0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap droid4-pending-v4.19
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-v4.19
[2] https://lists.freedesktop.org/archives/dri-devel/2018-August/186226.html
