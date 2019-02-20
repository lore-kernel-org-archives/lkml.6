Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5396821738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550622605;
	bh=kT9zHtPlBaKQe5WMaSmAugbGv64MVw2Dw/ptHixTyOo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ab7I2YKoiQ7jSvohDnzd9sb/Oi+2cI9NI6HmKbOPeian6t3zCMgoWjHcNj4VrFYal
	 mJQR3oaQD7MJZsCbMoqHzwBu8/D6PIIoafj1fI6Z1FMfJW51NZ5drWiU5uvC3z5TuD
	 IXPfC0hwkDIqG/8kGS/YOPDBu7aq/zGkMq4i5+S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfBTAaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbfBTAaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:30:03 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550622602;
        bh=kT9zHtPlBaKQe5WMaSmAugbGv64MVw2Dw/ptHixTyOo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GpILijyYJ5IK7ZFT5yI3JanG7vJ18lJdhzUdrmtCKc+UP3bsNqEhFdiilADSYJWN7
         yrpb52BhpDmip5d72N4GvNJlG0b7vqp4MfaTLgTYyzM/d6tW+1Dn8yiVQYXZtgnCqU
         DGNQcLXlOsmByn3GPyvdMmHWGm6ob0pPaTo2ed+A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190219.143326.1810127131443236789.davem@davemloft.net>
References: <20190219.143326.1810127131443236789.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190219.143326.1810127131443236789.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 1765f5dcd00963e33f1b8a4e0f34061fbc0e2f7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40e196a906d969fd10d885c692d2674b3d657006
Message-Id: <155062260262.16164.12672589311611784545.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Feb 2019 00:30:02 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 Feb 2019 14:33:26 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40e196a906d969fd10d885c692d2674b3d657006

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
