Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FB1C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC93217D8
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548619811;
	bh=8KVNEQUXhz27Q3HPU2y+AsFSZ160ywouwD/ROSQ1TGo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SthA1r1g51L7zxPeruFreKRVkb2cEFxcOYExnxPNFkFYQRilXFgdUs42z/vduSa1K
	 Lm2bks8WHa6W2Jliv6RlpktqSP/T0yc8cvHC+AEGNIcfRqbpmvst5YrYoGMpXD4c5N
	 vy2JxeodWEdKGZfZ15jzR64hDwKxBmJqSNCOccLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfA0UKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfA0UKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:10:06 -0500
Subject: Re: [GIT pull] locking updates for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548619806;
        bh=8KVNEQUXhz27Q3HPU2y+AsFSZ160ywouwD/ROSQ1TGo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UE/qxy46lk780Ja1eMg83+utxtngvwX5uj7VaRPYwrHv557O2mkgeZinbfOmkfsqj
         8AlCKzibDB5VkY/eRs2rSaHUWaugPGbTeVX+hx/96mymBW48111vZVVM6Q3XmO6Qd5
         OynD/oun6jHpuaLxFonG6nVJ4ik4aNctx1YR2Vnc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154858670614.17124.13586792661477887597.tglx@nanos.tec.linutronix.de>
References: <154858670614.17124.729797537033859836.tglx@nanos.tec.linutronix.de>
 <154858670614.17124.13586792661477887597.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154858670614.17124.13586792661477887597.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: e158488be27b157802753a59b336142dc0eb0380
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9881051828375a872964f91bf985b8a35e4fbaef
Message-Id: <154861980646.25513.16485543160106350886.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 20:10:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Jan 2019 12:05:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9881051828375a872964f91bf985b8a35e4fbaef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
