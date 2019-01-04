Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB61C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E275E2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546575606;
	bh=VQ/YpeqEVlTKWQzApCOIhBxcRiW5gW1ceD15jOQGwPY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N6XSATOT6ki/BdhwArHz3ph1d6HX2J15MsFTQ2hWHJ1BWHUOUpmIBbY1Uw04Wd+yH
	 pctVqF9wQeKTg/AzpKzRZTs2Z31C1ig/bsOKu7fampQGpGVp1DAleh2gzRawiGX0eb
	 XUyqHLkZTe2ZVEiIIiuxUrgn/6dY690C20ser6Qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfADEUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbfADEUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:20:03 -0500
Subject: Re: [GIT PULL] sound fixes for 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546575602;
        bh=VQ/YpeqEVlTKWQzApCOIhBxcRiW5gW1ceD15jOQGwPY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Vt5rPBWrLF1UN6YJ1biWJwSKsewL5KAsfqULzq3VJWOYhzao68CRmoEs+JgrrnR9r
         C1ge1ClHuhQ5DsTtkDGE8vHQn7nziFhRwTMTKdi8qHHC/wvBQH/zhzF3lvWpbIUzW2
         nkscSuSwYvf7pCvcETJI6OnPCKcZiNo6SX4nILs8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hr2dt6ffh.wl-tiwai@suse.de>
References: <s5hr2dt6ffh.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hr2dt6ffh.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-4.21-rc1
X-PR-Tracked-Commit-Id: 3e9ad24b0e91c066311a958afbd6210dda8a43eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 810574ca7e2f95d149023f4ea247d6672f69f9af
Message-Id: <20190104042002.16893.18618.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 04 Jan 2019 04:20:02 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 03 Jan 2019 14:25:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/810574ca7e2f95d149023f4ea247d6672f69f9af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
