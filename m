Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91EAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828BC20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547057107;
	bh=wG2srjWR7fZWF91edzZ1eiDAemtHe5aIGv6Fmd6G1Zo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iiA4yied5sBpFFXO4KauE5JBC06KwxwGE+NHbIdO6DA7KBPSmVKw/MfpovfDyl4Cx
	 /fUvTv84lY3k4C1ifZmhw0e8Dnyi2C9Xt6hBUYKK6qk3WNwm+FtcXgtukKDahHqIGm
	 RFnQQq4MzJJCENmaz1rdg5aMyg8hKRb05CC0SKuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfAISFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfAISFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:05:02 -0500
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547057101;
        bh=wG2srjWR7fZWF91edzZ1eiDAemtHe5aIGv6Fmd6G1Zo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UqE36/btGDGwV9yZwuLrQsC5HxhTqzrQEXqaEYZK2bsKxIOMZgFZhjbl82yixzjmu
         9Rl+iEPbtoEKHaECOP1bJyRZrT+UtLKEzM+X/W7FfuJvQWvQflPFhVdSSrxXDCojPQ
         +VPIXlr9cUQeFlgcPgJIoDvq7O+qca7f0A1JyJ6U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1547045397-24388-1-git-send-email-guoren@kernel.org>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1547045397-24388-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: 56752b21755aef598709d143684cb363db98a7d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4064e47c82810586975b4304b105056389beaa06
Message-Id: <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 09 Jan 2019 18:05:01 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        guoren@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  9 Jan 2019 22:49:57 +0800:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4064e47c82810586975b4304b105056389beaa06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
