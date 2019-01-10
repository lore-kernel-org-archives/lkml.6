Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0086C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F52214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547141111;
	bh=VHUGZrCe3eK9yv5cVT9CyH/jzMGmdtxgkQQEWkCvUz8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cuvx10xG+46rVfaMsFNWbDvS9pabiIlKQRaTCec+byjvZlRQcFmWEsBwnYcKJ92ob
	 DdvPbEo7ibxdaISrdcF2v05pN6Tq/Tg+uhxqxl+Q+MuMF6bqxKtOzyJ2Rjew7Rs+mQ
	 31NN+2SnfH17CCrzLHd6L3DkXbtyHocxq2N669sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfAJRZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbfAJRZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:25:02 -0500
Subject: Re: [GIT PULL] sound fixes for 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547141101;
        bh=VHUGZrCe3eK9yv5cVT9CyH/jzMGmdtxgkQQEWkCvUz8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qNxmGV6oppX77oxQNvxhE8DY1HvDydJGoMJf0EEfNi+jE7+qLfEsCJLl+otZGmhZ+
         DtrNMxn0kq1w0muud8H03OnlT8bpq8SZFOPVK2Fyt8JFUnQLKThKNDWyPx+b7a8Ir4
         +SqyOacL+H4+DJ8ki3BRsNwFn5st9aX86JZ9Bdqs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hzhs8obtw.wl-tiwai@suse.de>
References: <s5hzhs8obtw.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hzhs8obtw.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.0-rc2
X-PR-Tracked-Commit-Id: d1dd42110d2727e81b9265841a62bc84c454c3a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0ebbe9b18e0d2bb79c7963faf847b949d4f5720
Message-Id: <154714110165.8982.15497575701204447925.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Jan 2019 17:25:01 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Jan 2019 14:56:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0ebbe9b18e0d2bb79c7963faf847b949d4f5720

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
