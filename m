Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FA1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C04218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865811;
	bh=wlbZEDQl97HdszbRAsB+4OmHAw088fJ6nXH0zUNP+ys=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JKA4Ptl1eFGPgg/XVv05ugExkj4jxR9k7/cKxtZvL6B5J8dRjblpTrti+6CkiJdxx
	 xH7Sy2BpGFcriXPfWoWAXj8PmzRiZCX+IGMqyMGpoUTL8itMPc6xOaU6F05pnpgUNF
	 S4hzzMZZAppdTiDOniy7iDNBfb1jE089MRVFrqvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeLZXKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbeLZXKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:10:02 -0500
Subject: Re: [GIT PULL] RCU updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865801;
        bh=wlbZEDQl97HdszbRAsB+4OmHAw088fJ6nXH0zUNP+ys=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f2SWZ0ITKr/FNdLUeE6GLsBIiv/A81t+82ZvbW3YMLSBY0dI7x0JjDLMXr4u338k6
         j1UoNNjE69m7xL9pnwHHBQmqi227GORnZ625kppJKha2+9bfFk/undEYRSwB5JH0oo
         XFULSt94s9z3rFJNNmvUdMX3VTRtnKu3uEOdli4A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224221726.GA78524@gmail.com>
References: <20181224221726.GA78524@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224221726.GA78524@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus
X-PR-Tracked-Commit-Id: 4bbfd7467cfc7d42e18d3008fa6a28ffd56e901a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 792bf4d871dea8b69be2aaabdd320d7c6ed15985
Message-Id: <20181226231001.2587.22712.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 23:10:01 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 23:17:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/792bf4d871dea8b69be2aaabdd320d7c6ed15985

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
