Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92937C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62522218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061758;
	bh=eUNI5Zln5HhBgWKu6yORvQioJdv420MDTicdjIQpVGY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jIZqQE+E25qaufggWvgCuxcmN0eZ1fEJUH8GjW+Fd2KHTzpht0R7pMM2o+n75m4As
	 wiBG7TursS7xFVGxREfPnTZYQBUtBHWmwaLD3+fvKMubIM+I87EYOiY0x6/VfMimhk
	 6zFEj5iFcLVSPLCccN7cDtCAxZEEHio21WhSl1Y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbeL2Ffs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbeL2FfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:08 -0500
Subject: Re: [GIT PULL] TTY/Serial patches for 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061707;
        bh=eUNI5Zln5HhBgWKu6yORvQioJdv420MDTicdjIQpVGY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rZO3966rl292SZf4IgFpdUfpONnYNS2KPCNvtOjeJ/+RugsWeMCqBwDaPfHHYIbUy
         VpqzyIskOeWStGQ0k7Bx/wnG6IZPGMt6aIEfGHmeQ8pV5DoeVDMrTe8Kpo+LQCUiNt
         FEew927qaRQi5WO6+7ty2FQkuQMaYav/4gqWGiLY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228153506.GA23511@kroah.com>
References: <20181228153506.GA23511@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228153506.GA23511@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
 tags/tty-4.21-rc1
X-PR-Tracked-Commit-Id: 598134ffcab5bfb1d342458732394487063e1b9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 117eda8f71ff545cfdec8fe8073adbd173a1ceff
Message-Id: <20181229053507.9301.27578.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 16:35:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/117eda8f71ff545cfdec8fe8073adbd173a1ceff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
