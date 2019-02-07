Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B2C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A8621900
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549527007;
	bh=9B4+2Gcoim0DDwEi5cMs5xQTPbqQuw+Qu26BDTk6OqI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V6YhcbQ1Vx88TDRoUvpJTtspBkN+CPO518B9g2hW0pdYWRiquXHBqnbTsama1OPLB
	 0qvPOsy+TXcf7zzVDjY7tKQDH96l0AAjemSoBWRvWOr04wWv4ZWD0JmUjAuFCziIVp
	 1CuK74whA4sfGMkTKUFADEpzb2TTs69FTWQLORKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfBGIKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfBGIKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:10:04 -0500
Subject: Re: [GIT PULL] pin control fixes for v5.0-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549527004;
        bh=9B4+2Gcoim0DDwEi5cMs5xQTPbqQuw+Qu26BDTk6OqI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M8fdoJtwxO5siGL2JBwboW5WFoi2tucbugYuH2V5I/NPxszVWvjuBnr4UpNMy//L0
         /q4b5DHVsFtvHuxFnI5Y7w+fK+hT16mqiXMU7QqdZMgmyvNsuireVr9wtCHt8zWip8
         nQ4dACflhsUoQ9nQuGl7jllCE5fiW351cBcCqIn0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYfCT9eBfrKZBA_Do3PcCwvTCX9odD1uHDyZQKdJ4KsNg@mail.gmail.com>
References: <CACRpkdYfCT9eBfrKZBA_Do3PcCwvTCX9odD1uHDyZQKdJ4KsNg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYfCT9eBfrKZBA_Do3PcCwvTCX9odD1uHDyZQKdJ4KsNg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.0-2
X-PR-Tracked-Commit-Id: 10098709b4ee6f6f19f25ba81d9c6f83518c584c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b66bc7776748c97a6dc013c8d06e10ebf1c14307
Message-Id: <154952700402.18479.15641626487708151430.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Feb 2019 08:10:04 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jason Kridner <jdk@ti.com>, Chen-Yu Tsai <wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Feb 2019 09:09:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b66bc7776748c97a6dc013c8d06e10ebf1c14307

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
