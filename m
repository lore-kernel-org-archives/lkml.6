Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A044C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394E121908
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545858604;
	bh=djFfBgdznPWVBAR2tb+BW1v6UsiZCzwdPl4uApcoNSs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s4gV/Zf+YkhL16lST8Zna6lP4NAtWD4VK1C+Heczy77SGTdDQJ9aXK8ogsjdCwZNZ
	 /YIB+lS6/7UNhieK9HI8XVF+dxTOiKGSucLsge3bd/bR6LU1FM8PnSs1hLsmYdBSQ0
	 MFibDdZpA3zHkHAaCCLTot+mR/zjqSapX6C8tK/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeLZVKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbeLZVKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:10:02 -0500
Subject: Re: [GIT PULL] x86/cache updates for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545858602;
        bh=djFfBgdznPWVBAR2tb+BW1v6UsiZCzwdPl4uApcoNSs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IxbwbyxTkO/eq1eIVshGz23M2OM++T4MFJ/x/h7f0ZnJ6QFE5+KFaNpGxunk/N2d6
         F8lzGYsbeIy9XvcFRpnVAc7nbZjB+5yBLDrF+ac06C8mHXvjX7G8w/E0ZAIQVz5UsK
         XCHe/6GJtKP64lMXxuncaEy6xeIa/JMrFOC2V43k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181223124859.GA26860@zn.tnic>
References: <20181223124859.GA26860@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181223124859.GA26860@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus
X-PR-Tracked-Commit-Id: 52eb74339a6233c69f4e3794b69ea7c98eeeae1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a52fb43a5faa40507cb164a793a7fa08da863ac7
Message-Id: <20181226211002.9490.15691.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 21:10:02 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Dec 2018 13:48:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a52fb43a5faa40507cb164a793a7fa08da863ac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
