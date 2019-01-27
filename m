Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2964FC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96E2217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548619808;
	bh=yGGg8oEGIZTDEN9eYHA1bd3C7YcUExEjGcVeHihKkqk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=buZka3LZ3iaFLbJSCMZ1nTnWvOUl9UcmCQDSScRXRlU0gMT0cei0yiEs9zj17CHD6
	 rb0/y37F7cPr/xUtKE4rEi2ZqPUrjMCQ5cKqd06S5btILLlzywMRfNBXdh1c5J64Dl
	 OLVOSNbL8tiDfyEFpwoJggrzkZRhdvmQ1InCSh+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfA0UKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfA0UKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:10:05 -0500
Subject: Re: [GIT pull] timer updates for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548619805;
        bh=yGGg8oEGIZTDEN9eYHA1bd3C7YcUExEjGcVeHihKkqk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mF4e8I6aRuA7JOjab3QkOUotmmvGSn0121F39lPeBnQL2EOM/8NA/dqTTLfKAYSaV
         LIDTFYp7z+u4VE9saD1eCcO/ZW5AVfdOBXbu2sgScIXcLEgkCeG8srUletsLDSYvGQ
         mYR09its5A2ImFhOEKshLiplVMt/BoZr6jIiH3dI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154858670614.17124.9973897341622496366.tglx@nanos.tec.linutronix.de>
References: <154858670614.17124.729797537033859836.tglx@nanos.tec.linutronix.de>
 <154858670614.17124.9973897341622496366.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154858670614.17124.9973897341622496366.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 93ad0fc088c5b4631f796c995bdd27a082ef33a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f907bb4c326d145c13504db184f38557d169f4bc
Message-Id: <154861980530.25513.4256455854979370857.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 20:10:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Jan 2019 12:05:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f907bb4c326d145c13504db184f38557d169f4bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
