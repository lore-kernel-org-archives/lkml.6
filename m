Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8B2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CF3218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545878727;
	bh=3gmDFETMCDuHA4CNc/awAI+GB1W3HwevleptCFtB7DM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cxxoiDZH0DqQUFygvsZu3kG35VHZGKY+7l2see4zLu9jKaTbwtWgf7XPmpNaKlAUY
	 56EJxzS4Qa+ngTWyKFSnda25eqk/Hfu8Jq0FkY49N1tzlbHuCiYiN1Qxw1fXX6kUxJ
	 V1RRFKwsvs3ydJPh+DLAIbinwpbgEhKXJdhmRMIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeL0Cp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:45:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbeL0CpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:45:04 -0500
Subject: Re: [GIT PULL] x86/cpu changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545878703;
        bh=3gmDFETMCDuHA4CNc/awAI+GB1W3HwevleptCFtB7DM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UECNRFln925qhr21XTVrd9EXyzEfD0bTEbgHBP3oufv4nqUkN31A3EMrWN3lu0yyn
         cGzuRRn7YYLjRaNkNtYyzLnEYhgp3+41O8C1278DBNdwnvrRX4MYhQ17suXbKDit52
         0Bc+srHvMbaOwnoJGaTpK6i0K0cm562bLVfeQX/o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224230357.GA96402@gmail.com>
References: <20181224230357.GA96402@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224230357.GA96402@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus
X-PR-Tracked-Commit-Id: aa02ef099cff042c2a9109782ec2bf1bffc955d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db2ab474c4a434872e1794c2af8b2e561caa756e
Message-Id: <20181227024503.3706.66164.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 02:45:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Dec 2018 00:03:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db2ab474c4a434872e1794c2af8b2e561caa756e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
