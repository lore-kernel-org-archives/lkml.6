Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846C7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551A02146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546107304;
	bh=Cf9RIDXkmHb761q4rxuG/1dwsBwv4Jqb8AEO9etJSq4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HFP/HFZFoH/E0NskviWGmBppGFr+KA7N7nCIiOSWUByyrLjYoBH7I3AL+P/ugtccg
	 6pqaGqK/Q/XRL02hFv/fFEj0DYNcBzJXDVdgHYu0scUJqewWWoV27jNLnkdzEK70KQ
	 uFRBqQXkWP6GqpFV/oNd7Nq18jNWC6ei6T+AcReM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeL2SPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbeL2SPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:15:03 -0500
Subject: Re: [GIT PULL] nds32 new features and bug fix for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546107302;
        bh=Cf9RIDXkmHb761q4rxuG/1dwsBwv4Jqb8AEO9etJSq4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EM+vpds9To8jdhsdLZPVxVabOGAdMZwWwsqxAeg3DA61042hQk0XoEEsV983yIqko
         hXcWz84d/POPCc1Zo1ykgsTpy69Q/0ajq2mRmthC9kZWdRKvJ3oeGGMeX7rgggYtzh
         /L0EnQUyIh47cPLLzH3gqRHnO8F+1M4BGDaRzt8s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAEbi=3c7dr2pjQf_1FMZXMfYx5qvnf6_+WsfEVByKHwrh-bBPA@mail.gmail.com>
References: <CAEbi=3c7dr2pjQf_1FMZXMfYx5qvnf6_+WsfEVByKHwrh-bBPA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAEbi=3c7dr2pjQf_1FMZXMfYx5qvnf6_+WsfEVByKHwrh-bBPA@mail.gmail.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
 tags/nds32-for-linus-4.21
X-PR-Tracked-Commit-Id: e2f3f8b4a497d26bdcd55a53246ec2e613ae0fd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 889bb74302e5aba85d987b4093344150984d7cda
Message-Id: <20181229181502.27859.83391.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 18:15:02 +0000
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 16:24:01 +0800:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git tags/nds32-for-linus-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/889bb74302e5aba85d987b4093344150984d7cda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
