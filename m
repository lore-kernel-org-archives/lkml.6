Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE1EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B870F218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545858607;
	bh=/0mYtziTY3sLlrr7FlImQcltfFmaDeVVWtz5Z+u5Ilc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gytShexrnGr2I1QcCf6b3ILgaHyb3GaWH/iEYYf1uB2xmB56XK1iB60YMnyMHlGdW
	 JWQsTLom2c8bbdoRvOZnzTCWPKlAerqGYzmwjp45z+m2/zeInwbjymrjgr9sCfAW0W
	 icpP/OdBCBkRLTw7/U0nphaDoteWsXsmROqmgRGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeLZVKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbeLZVKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:10:03 -0500
Subject: Re: [GIT PULL] RAS updates for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545858603;
        bh=/0mYtziTY3sLlrr7FlImQcltfFmaDeVVWtz5Z+u5Ilc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pb/IiMD9fDaDImeNE6zWYpwrtnfqxO9qsoFV6qjoSL1n/yDxAwgkYKpSuKvCXLjxK
         V4rQ3mtMNeGfaZe0c/NpnEzYZ1D2I/fhY0oShy0UqF1DmASwqH+Om8vNA2nKSdwFHi
         gKjQY7OTNCZI8ntyeQfcJFRkOpliIdcpZT+na+2k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181223125339.GC26860@zn.tnic>
References: <20181223125339.GC26860@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181223125339.GC26860@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus
X-PR-Tracked-Commit-Id: 72a8f089c382c078f8c7c1c759cb726de80d4284
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eed9688f8513189295887e5a27ec7f576754b60e
Message-Id: <20181226211003.9490.26087.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 21:10:03 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Dec 2018 13:53:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eed9688f8513189295887e5a27ec7f576754b60e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
