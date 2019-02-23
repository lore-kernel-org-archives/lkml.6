Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09445C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC77B206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550886310;
	bh=fKRNjEXSaHRDTNsWUMWrDELY6HFUtF1puP3IXeMZKHs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rZS50GLRj9LGtMmFtRGx0o3HLBvPkRfCuQ1vhl2AdgkwVFBV/n+COLBi68uxLr47j
	 RtkEehrCp9BUzHkoVkmr67T+ME8Bm3LbUFsB6sDXE5faPfRbBnk2zzMtVlJlYNqmOf
	 8IHB2dIuTQLw/KNuzKpFpRxJ9hNFOghE5/8PDvFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfBWBpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbfBWBpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:45:04 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550886303;
        bh=fKRNjEXSaHRDTNsWUMWrDELY6HFUtF1puP3IXeMZKHs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SKW2SmExEiD7sZsdZ89oumxRgpMShlbzSFoMJk0n8CsLLczt7KHIoBck0Rb/8olgb
         USuOLKilZ785IZga9bY/oEZZtuPG+wFg+d2S7j4Seurdr3oYrYn6tDqJlxcnbE7Q2G
         t+l7w+XyRCOdOQClX5mG9yiJqhwze1Ubm+GKOsfI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a3dhfKVAtABqeuh4g2xtK5Zic8Nq_xxdoa61H+UctRK9Q@mail.gmail.com>
References: <CAK8P3a3dhfKVAtABqeuh4g2xtK5Zic8Nq_xxdoa61H+UctRK9Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a3dhfKVAtABqeuh4g2xtK5Zic8Nq_xxdoa61H+UctRK9Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 2f8b1ce19ebdaffa0f3f11d178b387b60e29c0fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9053d2db8b04a468ce1ab92693b940b046ea392c
Message-Id: <155088630354.27298.1173921139841253211.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Feb 2019 01:45:03 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Feb 2019 23:23:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9053d2db8b04a468ce1ab92693b940b046ea392c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
