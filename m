Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E53EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E998218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545852101;
	bh=3lVWu1ZD0Cg7VNWagxgrog+FxTaSmjcP5gEKT3kGusk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UKpbmQYg6wUuzqcvaP8mVQyY7sVVnIuGd6WQJ9ro2+0EU2NeLUh9s39rrw1Az+eda
	 e0UfWWsy9maUX8PfeVj8vGx406Lxe3yKQFiS1vOI9fDhJqxhyD3F7GHWULCLax/Cnb
	 1WtBTYVilfOfWimh1bAfFkmtCuyDmiQ1oqJw8LRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeLZTVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbeLZTUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:20:03 -0500
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545852003;
        bh=3lVWu1ZD0Cg7VNWagxgrog+FxTaSmjcP5gEKT3kGusk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1ZALHWGuZPy4FqMzK7tDVVmHDPWPgWYfMNV1/3OvIbVmtJepodJdrN99CavOTExfU
         MHFPFLH+knGcQV6waLOZqorMaEcB4xOFUdQrz2okvoXWAgt6svqQMWSprOZPel8oeN
         QTrgr5aFM3hHfdDCuo17No9Ztu372v+PL9p6QySw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181222.154626.2057028219500846030.davem@davemloft.net>
References: <20181222.154626.2057028219500846030.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181222.154626.2057028219500846030.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git master
X-PR-Tracked-Commit-Id: c23b8e7acea3dc034edeb902f0c843856e215938
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2f1f3e0e17d94ab0c66d83e669492cb9e9a3698
Message-Id: <20181226192003.20075.69725.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 19:20:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Dec 2018 15:46:26 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2f1f3e0e17d94ab0c66d83e669492cb9e9a3698

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
