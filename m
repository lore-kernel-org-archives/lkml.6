Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66601C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371AA218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865824;
	bh=YxhP7edGFutlJ1G2yzYVPzv8IQzgUAJUhzmke1vNfYg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=z1opzSwqpaZwYxyM1Qr2v4B6/k33mPMsOY5vCIHfneXeJ4vaRFDk2XNclkPFSPPEF
	 6nAsHumpY311xVCtJb5K7CMR9O8EPQl5XgfyOwdADvbNV29K/Pzy0l+4PDxEPd4Glw
	 XhiO+0esOTl7J/zMFfB0dc74JohgBeFLm90tsctc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbeLZXKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbeLZXKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:10:03 -0500
Subject: Re: [GIT PULL] perf updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865803;
        bh=YxhP7edGFutlJ1G2yzYVPzv8IQzgUAJUhzmke1vNfYg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UvLf840UnpOpJHiZA47q2P/F9oVgJ2JWaiCc6hKOeJJOs6qszXpPEz/3jVl4Y50F7
         ZuSvwpb3SHmPURAyJ7I1uWwSt3TGiGHa8YPUoj36pdDRMcAUuKBP3/ddoljcZtNSpv
         kLsrKuieQfzD1XuC+6QnCyao0pApwULyfh8Y66ps=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224223727.GA34100@gmail.com>
References: <20181224223727.GA34100@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224223727.GA34100@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus
X-PR-Tracked-Commit-Id: 883f4def8b77e6870ce42be279564cca0256c611
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 116b081c285d89dc6ece72eeecc6aa3979e8b54e
Message-Id: <20181226231003.2587.96952.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 23:10:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 23:37:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/116b081c285d89dc6ece72eeecc6aa3979e8b54e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
