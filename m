Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE8C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688862146F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547937313;
	bh=zohmQFoZn8tZGxQq1wFKBBFa7F/YEb3Rp5R+BosRD18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OrhOiAfktNLn/WqEh0xfsEOdL8wuN0Wg8Ww9YVlGvwQk3oHIABwmi+6nbuwckEKbg
	 l7mkSo6l8PK0hTsplmy03GPfv0TrrosgApHV0kICeH33hohb1RxfLs65Rs78c2HOB8
	 bTO+J17r4vK1/EHpSMTmevdNSA/TfrHwzUopRgYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfASWfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:35:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729734AbfASWfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:35:02 -0500
Subject: Re: [GIT PULL] MIPS fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547937302;
        bh=zohmQFoZn8tZGxQq1wFKBBFa7F/YEb3Rp5R+BosRD18=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NiJvwtj0sFT4+6NQ2g9k+dBRFHp1OlMj9fCDif5+h3eaq5U6tei3WDa2evw/JM/KX
         nup/liFnnLzRAB/FodiwfvzXVZt/4kSK+n4kjSZJ+B6wIs3MUsWqWknubMXSat5fwK
         gf6e5q+vmPkj1SFnIHxdf6Mm4Zj2tpm2jjJr0caA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190119191831.7vx5kfjtkyji55zr@pburton-laptop>
References: <20190119191831.7vx5kfjtkyji55zr@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190119191831.7vx5kfjtkyji55zr@pburton-laptop>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.0_2
X-PR-Tracked-Commit-Id: 8a644c64a9f1aefb99fdc4413e6b7fee17809e38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d5c303ea095bdd3a2b073075920bf159457069a
Message-Id: <154793730236.16838.16525346723118394777.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Jan 2019 22:35:02 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Jan 2019 19:18:34 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.0_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d5c303ea095bdd3a2b073075920bf159457069a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
